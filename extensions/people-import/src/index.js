const multer = require('multer');

const upload = multer({ storage: multer.memoryStorage() });

module.exports = (router, { services, getSchema, database }) => {
  const { ItemsService } = services;

  // Función para parsear líneas CSV
  function parseCSVLine(line) {
    const values = [];
    let current = '';
    let inQuotes = false;

    for (let i = 0; i < line.length; i++) {
      const char = line[i];
      const nextChar = line[i + 1];

      if (char === '"' && !inQuotes) {
        inQuotes = true;
      } else if (char === '"' && inQuotes && nextChar === '"') {
        current += '"';
        i++;
      } else if (char === '"' && inQuotes) {
        inQuotes = false;
      } else if (char === ',' && !inQuotes) {
        values.push(current.trim());
        current = '';
      } else {
        current += char;
      }
    }
    values.push(current.trim());
    return values;
  }

  // Endpoint de prueba
  router.get('/test', (req, res) => {
    res.json({
      success: true,
      message: 'Extensión de importación funcionando',
      timestamp: new Date().toISOString(),
      routes: [
        'GET /test - Prueba de conectividad',
        'POST /enterprises - Importar CSV de empresas (Pipedrive)',
        'POST /people - Importar CSV de personas (formato HubSpot normalizado)',
        'POST /migrate - Ejecutar migración SQL (temporal)'
      ]
    });
  });

  // Endpoint temporal para ejecutar migraciones SQL
  router.post('/migrate', async (req, res) => {
    try {
      const { sql } = req.body;

      if (!sql) {
        return res.status(400).json({
          success: false,
          error: 'SQL query required'
        });
      }

      // Ejecutar SQL
      const result = await database.raw(sql);

      res.json({
        success: true,
        message: 'SQL executed successfully',
        result: result
      });

    } catch (error) {
      console.error('Error ejecutando SQL:', error);
      res.status(500).json({
        success: false,
        error: error.message
      });
    }
  });

  // Endpoint para importar empresas (CSV Pipedrive)
  router.post('/enterprises', upload.single('file'), async (req, res) => {
    try {
      // Verificar archivo
      if (!req.file) {
        return res.status(400).json({
          success: false,
          error: 'No se proporcionó archivo CSV'
        });
      }

      const csvData = req.file.buffer.toString('utf-8');
      const lines = csvData.split('\n').filter(line => line.trim());

      if (lines.length < 2) {
        return res.status(400).json({
          success: false,
          error: 'El CSV debe tener al menos una fila de datos'
        });
      }

      // Obtener esquema
      const schema = await getSchema();

      // Servicios
      const enterprisesService = new ItemsService('enterprises', {
        schema,
        accountability: req.accountability
      });

      const results = [];
      const errors = [];

      // Procesar header
      const headers = parseCSVLine(lines[0]);

      // Mapeo de campos
      const fieldMapping = {};
      headers.forEach((header, index) => {
        switch (header.toLowerCase()) {
          case 'name':
            fieldMapping.organization_name = index;
            break;
          case 'address':
            fieldMapping.normalized_address = index;
            break;
          case 'owner_name':
            fieldMapping.internal_owner = index;
            break;
          case 'company_id':
            fieldMapping.fiscal_identification = index;
            break;
          case 'label':
            fieldMapping.commercial_name = index;
            break;
        }
      });

      // Procesar cada fila
      for (let i = 1; i < lines.length; i++) {
        try {
          const values = parseCSVLine(lines[i]);

          const organizationName = fieldMapping.organization_name !== undefined
            ? values[fieldMapping.organization_name]
            : null;

          if (!organizationName || organizationName.trim() === '') {
            errors.push({
              row: i + 1,
              error: 'Nombre de organización requerido'
            });
            continue;
          }

          // Verificar si existe
          const existing = await enterprisesService.readByQuery({
            filter: { organization_name: { _eq: organizationName.trim() } },
            limit: 1,
            fields: ['id', 'organization_name']
          });

          if (existing && existing.length > 0) {
            results.push({
              row: i + 1,
              organization_name: organizationName,
              status: 'exists',
              id: existing[0].id
            });
            continue;
          }

          // Crear nueva empresa
          const enterpriseData = {
            organization_name: organizationName.trim(),
            acquisition_source: 'other',
            notes: 'Importado desde CSV Pipedrive'
          };

          // Agregar campos opcionales
          if (fieldMapping.normalized_address !== undefined && values[fieldMapping.normalized_address]) {
            enterpriseData.normalized_address = values[fieldMapping.normalized_address].trim();
          }
          if (fieldMapping.internal_owner !== undefined && values[fieldMapping.internal_owner]) {
            enterpriseData.internal_owner = values[fieldMapping.internal_owner].trim();
          }
          if (fieldMapping.fiscal_identification !== undefined && values[fieldMapping.fiscal_identification]) {
            enterpriseData.fiscal_identification = values[fieldMapping.fiscal_identification].trim();
          }
          if (fieldMapping.commercial_name !== undefined && values[fieldMapping.commercial_name]) {
            enterpriseData.commercial_name = values[fieldMapping.commercial_name].trim();
          }

          const newEnterprise = await enterprisesService.createOne(enterpriseData);

          results.push({
            row: i + 1,
            organization_name: organizationName,
            status: 'created',
            id: newEnterprise
          });

        } catch (error) {
          errors.push({
            row: i + 1,
            error: error.message
          });
        }
      }

      res.json({
        success: true,
        message: `Importación completada. ${results.length} empresas procesadas.`,
        data: {
          processed: lines.length - 1,
          successful: results.length,
          errors: errors.length,
          results: results,
          errorDetails: errors
        }
      });

    } catch (error) {
      console.error('Error en importación:', error);
      res.status(500).json({
        success: false,
        error: error.message
      });
    }
  });

  // Endpoint para importar personas (formato Pipedrive)
  router.post('/people', upload.single('file'), async (req, res) => {
    try {
      // Verificar archivo
      if (!req.file) {
        return res.status(400).json({
          success: false,
          error: 'No se proporcionó archivo CSV'
        });
      }

      const csvData = req.file.buffer.toString('utf-8');
      const lines = csvData.split('\n').filter(line => line.trim());

      if (lines.length < 2) {
        return res.status(400).json({
          success: false,
          error: 'El CSV debe tener al menos una fila de datos'
        });
      }

      // Obtener esquema
      const schema = await getSchema();

      // Servicios para personas y relaciones
      const peopleService = new ItemsService('people', { schema, accountability: req.accountability });
      const tagsService = new ItemsService('tags', { schema, accountability: req.accountability });
      const peopleTagsService = new ItemsService('people_tags', { schema, accountability: req.accountability });
      const segmentsService = new ItemsService('segments', { schema, accountability: req.accountability });
      const peopleSegmentsService = new ItemsService('people_segments', { schema, accountability: req.accountability });

      const results = [];
      const errors = [];

      // Función auxiliar para encontrar o crear elemento
      async function findOrCreate(service, field, value, defaultData = {}) {
        if (!value || value.trim() === '') return null;

        try {
          const existing = await service.readByQuery({
            filter: { [field]: { _eq: value.trim() } },
            limit: 1
          });

          if (existing && existing.length > 0) {
            return existing[0].id;
          }

          const newItem = await service.createOne({
            [field]: value.trim(),
            ...defaultData
          });

          return newItem;
        } catch (error) {
          console.error(`Error en findOrCreate para ${value}:`, error);
          return null;
        }
      }

      // Procesar header
      const headers = parseCSVLine(lines[0]);

      // Mapeo de campos del CSV a la estructura REAL de Directus people
      const fieldMapping = {};
      headers.forEach((header, index) => {
        switch (header.toLowerCase()) {
          case 'full_name':
            fieldMapping.full_name = index;
            break;
          case 'primary_email':
            fieldMapping.primary_email = index;
            break;
          case 'position_title':
            fieldMapping.position_title = index;
            break;
          case 'department':
            fieldMapping.department = index;
            break;
          case 'linkedin':
            fieldMapping.linkedin = index;
            break;
          case 'phone_prefix':
            fieldMapping.phone_prefix = index;
            break;
          case 'phone_number':
            fieldMapping.phone_number = index;
            break;
          case 'enterprise_relation_id':
            fieldMapping.enterprise_relation_id = index;
            break;
          case 'decision_level':
            fieldMapping.decision_level = index;
            break;
          case 'acquisition_source':
            fieldMapping.acquisition_source = index;
            break;
          case 'internal_owner':
            fieldMapping.internal_owner = index;
            break;
          case 'notes':
            fieldMapping.notes = index;
            break;
          case 'communication_consent':
            fieldMapping.communication_consent = index;
            break;
          case 'tags':
            fieldMapping.tags = index;
            break;
          case 'segments':
            fieldMapping.segments = index;
            break;
        }
      });

      // Procesar cada fila
      for (let i = 1; i < lines.length; i++) {
        try {
          const values = parseCSVLine(lines[i]);

          // Obtener nombre completo (campo requerido)
          const fullName = fieldMapping.full_name !== undefined ? values[fieldMapping.full_name] : null;

          if (!fullName || !fullName.trim()) {
            errors.push({
              row: i + 1,
              error: 'full_name requerido'
            });
            continue;
          }

          // Verificar si la persona ya existe por email o nombre
          const email = fieldMapping.primary_email !== undefined ? values[fieldMapping.primary_email] : null;
          let existingPerson = null;

          if (email && email.trim()) {
            existingPerson = await peopleService.readByQuery({
              filter: { primary_email: { _eq: email.trim() } },
              limit: 1,
              fields: ['id', 'full_name', 'primary_email']
            });
          }

          if (!existingPerson || existingPerson.length === 0) {
            existingPerson = await peopleService.readByQuery({
              filter: { full_name: { _eq: fullName.trim() } },
              limit: 1,
              fields: ['id', 'full_name', 'primary_email']
            });
          }

          if (existingPerson && existingPerson.length > 0) {
            results.push({
              row: i + 1,
              full_name: fullName.trim(),
              primary_email: email,
              status: 'exists',
              id: existingPerson[0].id
            });
            continue;
          }

          // Crear nueva persona con los campos REALES de Directus
          const personData = {
            full_name: fullName.trim()
          };

          // Agregar campos opcionales que coincidan con Directus
          if (email && email.trim()) {
            personData.primary_email = email.trim();
          }

          if (fieldMapping.position_title !== undefined && values[fieldMapping.position_title]) {
            personData.position_title = values[fieldMapping.position_title].trim();
          }

          if (fieldMapping.department !== undefined && values[fieldMapping.department]) {
            personData.department = values[fieldMapping.department].trim();
          }

          if (fieldMapping.linkedin !== undefined && values[fieldMapping.linkedin]) {
            personData.linkedin = values[fieldMapping.linkedin].trim();
          }

          if (fieldMapping.phone_prefix !== undefined && values[fieldMapping.phone_prefix]) {
            personData.phone_prefix = values[fieldMapping.phone_prefix].trim();
          }

          if (fieldMapping.phone_number !== undefined && values[fieldMapping.phone_number]) {
            personData.phone_number = values[fieldMapping.phone_number].trim();
          }

          if (fieldMapping.enterprise_relation_id !== undefined && values[fieldMapping.enterprise_relation_id]) {
            const enterpriseId = parseInt(values[fieldMapping.enterprise_relation_id]);
            if (!isNaN(enterpriseId)) {
              personData.enterprise_relation_id = enterpriseId;
            }
          }

          if (fieldMapping.decision_level !== undefined && values[fieldMapping.decision_level]) {
            personData.decision_level = values[fieldMapping.decision_level].trim();
          }

          if (fieldMapping.acquisition_source !== undefined && values[fieldMapping.acquisition_source]) {
            personData.acquisition_source = values[fieldMapping.acquisition_source].trim();
          }

          if (fieldMapping.internal_owner !== undefined && values[fieldMapping.internal_owner]) {
            personData.internal_owner = values[fieldMapping.internal_owner].trim();
          }

          if (fieldMapping.notes !== undefined && values[fieldMapping.notes]) {
            personData.notes = values[fieldMapping.notes].trim();
          }

          if (fieldMapping.communication_consent !== undefined && values[fieldMapping.communication_consent]) {
            const consent = values[fieldMapping.communication_consent].toLowerCase();
            personData.communication_consent = consent === 'true' || consent === '1' || consent === 'yes';
          }

          const newPerson = await peopleService.createOne(personData);
          const personId = newPerson;

          // Procesar tags (separados por ;)
          if (fieldMapping.tags !== undefined && values[fieldMapping.tags]) {
            const tagsList = values[fieldMapping.tags].split(';').map(tag => tag.trim()).filter(tag => tag);
            for (const tagName of tagsList) {
              const tagId = await findOrCreate(tagsService, 'name', tagName);
              if (tagId) {
                try {
                  await peopleTagsService.createOne({
                    person_id: personId,
                    tag_id: tagId
                  });
                } catch (error) {
                  // Ignorar errores de duplicados
                  if (!error.message.includes('duplicate') && !error.message.includes('unique')) {
                    console.error('Error creando relación tag:', error);
                  }
                }
              }
            }
          }

          // Procesar segmentos (separados por ;)
          if (fieldMapping.segments !== undefined && values[fieldMapping.segments]) {
            const segmentsList = values[fieldMapping.segments].split(';').map(seg => seg.trim()).filter(seg => seg);
            for (const segmentName of segmentsList) {
              const segmentId = await findOrCreate(segmentsService, 'name', segmentName);
              if (segmentId) {
                try {
                  await peopleSegmentsService.createOne({
                    people_id: personId,
                    segments_id: segmentId
                  });
                } catch (error) {
                  // Ignorar errores de duplicados
                  if (!error.message.includes('duplicate') && !error.message.includes('unique')) {
                    console.error('Error creando relación segmento:', error);
                  }
                }
              }
            }
          }

          results.push({
            row: i + 1,
            full_name: fullName.trim(),
            primary_email: email,
            status: 'created',
            id: personId
          });

        } catch (error) {
          console.error(`Error procesando fila ${i + 1}:`, error);
          errors.push({
            row: i + 1,
            error: error.message
          });
        }
      }

      res.json({
        success: true,
        message: `Importación de personas completada. ${results.length} registros procesados.`,
        data: {
          processed: lines.length - 1,
          successful: results.length,
          errors: errors.length,
          results: results,
          errorDetails: errors
        }
      });

    } catch (error) {
      console.error('Error en importación de personas:', error);
      res.status(500).json({
        success: false,
        error: error.message
      });
    }
  });
};