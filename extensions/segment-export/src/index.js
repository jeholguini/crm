const { Parser } = require('@json2csv/plainjs');

module.exports = (router, { services, getSchema, database }) => {
  const { ItemsService } = services;

  // Función para obtener campos de una colección dinámicamente
  function getCollectionFields(schema, collectionName) {
    const collection = schema.collections[collectionName];
    if (!collection || !collection.fields) {
      return [];
    }

    // Filtrar campos que no queremos exportar
    const excludeFields = [
      'user_created',
      'user_updated',
      'sort'
    ];

    const fields = Object.keys(collection.fields)
      .filter(fieldName => !excludeFields.includes(fieldName))
      .map(fieldName => {
        const field = collection.fields[fieldName];

        // Si es una relación many-to-many o many-to-one, incluir campos relacionados
        if (field.type === 'alias' && field.meta?.special?.includes('m2m')) {
          // Para relaciones m2m como segments, industries
          const relatedCollection = field.meta?.one_collection;
          if (relatedCollection) {
            return `${fieldName}.${fieldName}_id.id`;
          }
        }

        return fieldName;
      });

    return fields;
  }

  // Función para formatear el nombre del campo para el CSV
  function formatFieldName(fieldName) {
    return fieldName
      .split('_')
      .map(word => word.charAt(0).toUpperCase() + word.slice(1))
      .join(' ');
  }

  // Función para aplanar objetos relacionados
  function flattenValue(value, fieldName) {
    if (value === null || value === undefined) {
      return '';
    }

    // Si es un array (relaciones m2m)
    if (Array.isArray(value)) {
      return value
        .map(item => {
          if (typeof item === 'object' && item !== null) {
            // Para relaciones como industries.industries_id.name
            const relatedKey = Object.keys(item).find(k => k.endsWith('_id'));
            if (relatedKey && item[relatedKey]) {
              return item[relatedKey].name || item[relatedKey].id || JSON.stringify(item[relatedKey]);
            }
            return JSON.stringify(item);
          }
          return item;
        })
        .filter(Boolean)
        .join(', ');
    }

    // Si es un objeto
    if (typeof value === 'object' && value !== null) {
      return value.name || value.id || JSON.stringify(value);
    }

    return String(value);
  }

  // Endpoint de prueba
  router.get('/test', (req, res) => {
    res.json({
      success: true,
      message: 'Extensión de exportación de segmentos funcionando',
      timestamp: new Date().toISOString(),
      routes: [
        'GET /test - Prueba de conectividad',
        'GET /export-segment/:id - Exportar personas y/o empresas de un segmento'
      ]
    });
  });

  // Endpoint unificado para exportar personas y/o empresas de un segmento
  router.get('/export-segment/:id', async (req, res) => {
    try {
      const segmentId = req.params.id;

      if (!segmentId) {
        return res.status(400).json({
          success: false,
          error: 'Segment ID is required'
        });
      }

      console.log('Exportando segmento:', segmentId);

      const schema = await getSchema();

      // Obtener información del segmento
      const segmentsService = new ItemsService('segments', { schema, accountability: req.accountability });
      const segment = await segmentsService.readOne(segmentId);

      if (!segment) {
        return res.status(404).json({
          success: false,
          error: 'Segment not found'
        });
      }

      // Obtener campos dinámicamente
      const peopleFields = getCollectionFields(schema, 'people');
      const enterprisesFields = getCollectionFields(schema, 'enterprises');

      console.log('Campos de personas:', peopleFields);
      console.log('Campos de empresas:', enterprisesFields);

      // Obtener personas relacionadas con el segmento usando knex directamente
      // Consultar IDs de personas (usar tabla _1 que es la correcta)
      const peopleIdsResult = await database('segments_people_1')
        .where('segments_id', segmentId)
        .select('people_id');

      const peopleIds = peopleIdsResult.map(row => row.people_id).filter(id => id);

      // Obtener personas con todos sus datos
      let people = [];
      if (peopleIds.length > 0) {
        const peopleService = new ItemsService('people', { schema, accountability: req.accountability });
        people = await peopleService.readByQuery({
          filter: {
            id: { _in: peopleIds }
          },
          fields: ['*'],
          limit: -1
        });
      }

      // Consultar IDs de empresas
      const enterprisesIdsResult = await database('segments_enterprises')
        .where('segments_id', segmentId)
        .select('enterprises_id');

      const enterprisesIds = enterprisesIdsResult.map(row => row.enterprises_id).filter(id => id);

      // Obtener empresas con todos sus datos
      let enterprises = [];
      if (enterprisesIds.length > 0) {
        const enterprisesService = new ItemsService('enterprises', { schema, accountability: req.accountability });
        enterprises = await enterprisesService.readByQuery({
          filter: {
            id: { _in: enterprisesIds }
          },
          fields: ['*'],
          limit: -1
        });
      }

      // Verificar que haya al menos personas o empresas
      const hasPeople = people && people.length > 0;
      const hasEnterprises = enterprises && enterprises.length > 0;

      if (!hasPeople && !hasEnterprises) {
        return res.status(404).json({
          success: false,
          error: 'No people or enterprises found in this segment'
        });
      }

      // Crear estructura de columnas para el CSV
      const csvColumns = {};

      // Columnas fijas
      csvColumns['Tipo'] = '';
      csvColumns['Segmento'] = '';
      csvColumns['Segmento ID'] = '';
      csvColumns['Descripción Segmento'] = '';

      // Agregar columnas de personas con prefijo
      peopleFields.forEach(field => {
        const cleanField = field.split('.')[0]; // Remover partes de relaciones
        csvColumns[`Persona - ${formatFieldName(cleanField)}`] = '';
      });

      // Agregar columnas de empresas con prefijo
      enterprisesFields.forEach(field => {
        const cleanField = field.split('.')[0];
        csvColumns[`Empresa - ${formatFieldName(cleanField)}`] = '';
      });

      // Preparar datos combinados para CSV
      const csvData = [];

      // Agregar personas
      if (hasPeople) {
        people.forEach(person => {
          const row = { ...csvColumns };
          row['Tipo'] = 'Persona';
          row['Segmento'] = segment.name || '';
          row['Segmento ID'] = segmentId;
          row['Descripción Segmento'] = segment.description || '';

          // Llenar campos de persona
          Object.keys(person).forEach(key => {
            if (key !== 'segments') { // Evitar duplicar el segmento
              const columnName = `Persona - ${formatFieldName(key)}`;
              if (row.hasOwnProperty(columnName)) {
                row[columnName] = flattenValue(person[key], key);
              }
            }
          });

          csvData.push(row);
        });
      }

      // Agregar empresas
      if (hasEnterprises) {
        enterprises.forEach(enterprise => {
          const row = { ...csvColumns };
          row['Tipo'] = 'Empresa';
          row['Segmento'] = segment.name || '';
          row['Segmento ID'] = segmentId;
          row['Descripción Segmento'] = segment.description || '';

          // Llenar campos de empresa
          Object.keys(enterprise).forEach(key => {
            if (key !== 'segments') { // Evitar duplicar el segmento
              const columnName = `Empresa - ${formatFieldName(key)}`;
              if (row.hasOwnProperty(columnName)) {
                row[columnName] = flattenValue(enterprise[key], key);
              }
            }
          });

          csvData.push(row);
        });
      }

      // Generar CSV
      const parser = new Parser();
      const csv = parser.parse(csvData);

      // Configurar headers para descarga
      const sanitizedName = (segment.name || segmentId).toString()
        .replace(/[^a-zA-Z0-9]/g, '_')
        .replace(/_+/g, '_')
        .toLowerCase();
      const filename = `segmento_${sanitizedName}_${new Date().toISOString().split('T')[0]}.csv`;

      res.setHeader('Content-Type', 'text/csv; charset=utf-8');
      res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);

      // Agregar BOM para soporte de UTF-8 en Excel
      res.write('\ufeff');
      res.end(csv);

      console.log(`Exportado: ${people?.length || 0} personas, ${enterprises?.length || 0} empresas`);

    } catch (error) {
      console.error('Error exportando segmento:', error);
      res.status(500).json({
        success: false,
        error: 'Export failed: ' + error.message
      });
    }
  });
};
