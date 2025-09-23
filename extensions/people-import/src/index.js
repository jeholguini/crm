const multer = require('multer');

const upload = multer({ storage: multer.memoryStorage() });

module.exports = (router, { services, getSchema }) => {
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
        'POST /people - Importar CSV de personas (formato personalizado)'
      ]
    });
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

  // Endpoint para importar personas (formato personalizado)
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

      // Servicios para cada colección
      const peopleService = new ItemsService('people', { schema, accountability: req.accountability });
      const enterprisesService = new ItemsService('enterprises', { schema, accountability: req.accountability });
      const industriesService = new ItemsService('industries', { schema, accountability: req.accountability });
      const locationsService = new ItemsService('locations', { schema, accountability: req.accountability });
      const keywordsService = new ItemsService('keywords', { schema, accountability: req.accountability });
      const technologiesService = new ItemsService('technologies', { schema, accountability: req.accountability });
      const enterprisesIndustriesService = new ItemsService('enterprises_industries', { schema, accountability: req.accountability });
      const enterprisesLocationsService = new ItemsService('enterprises_locations', { schema, accountability: req.accountability });
      const enterprisesKeywordsService = new ItemsService('enterprises_keywords', { schema, accountability: req.accountability });
      const enterprisesTechnologiesService = new ItemsService('enterprises_technologies', { schema, accountability: req.accountability });
      const employmentHistoryService = new ItemsService('person_employment_history', { schema, accountability: req.accountability });

      const results = [];
      const errors = [];

      // Función para encontrar o crear elemento
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

      // Procesar cada línea del CSV (saltando el header)
      // Formato esperado: nit,nombre,telefono,email,industria,linkedin,fundacion,ubicaciones,keywords,tecnologias
      for (let i = 1; i < lines.length; i++) {
        try {
          const line = lines[i];
          if (!line.trim()) continue;

          // Parsear CSV
          const values = parseCSVLine(line);

          if (values.length < 10) {
            errors.push({
              row: i + 1,
              error: 'Fila incompleta, se esperan 10 columnas: nit,nombre,telefono,email,industria,linkedin,fundacion,ubicaciones,keywords,tecnologias'
            });
            continue;
          }

          const [nit, nombre, telefono, email, industria, linkedin, fundacion, ubicaciones, keywords, tecnologias] = values;

          // 1. Crear o encontrar empresa
          let enterpriseId = null;
          if (nit && nombre) {
            const existingEnterprise = await enterprisesService.readByQuery({
              filter: { fiscal_identification: { _eq: nit } },
              limit: 1,
              fields: ['id', 'organization_name']
            });

            if (existingEnterprise && existingEnterprise.length > 0) {
              enterpriseId = existingEnterprise[0].id;
            } else {
              // Crear nueva empresa
              const enterpriseData = {
                organization_name: nombre,
                fiscal_identification: nit,
                website: linkedin || null,
                notes: `Año fundación: ${fundacion || 'N/A'}`
              };

              // Filtrar campos vacíos
              Object.keys(enterpriseData).forEach(key => {
                if (enterpriseData[key] === null || enterpriseData[key] === undefined || enterpriseData[key] === '') {
                  delete enterpriseData[key];
                }
              });

              enterpriseId = await enterprisesService.createOne(enterpriseData);

              // Procesar industria
              if (industria) {
                const industryId = await findOrCreate(industriesService, 'name', industria);
                if (industryId) {
                  await enterprisesIndustriesService.createOne({
                    enterprises_id: enterpriseId,
                    industries_id: industryId
                  });
                }
              }

              // Procesar ubicaciones
              if (ubicaciones) {
                const ubicacionesList = ubicaciones.split(';').map(u => u.trim());
                for (const ubicacion of ubicacionesList) {
                  const locationId = await findOrCreate(locationsService, 'city', ubicacion, {
                    country: 'Colombia',
                    province: 'N/A'
                  });
                  if (locationId) {
                    await enterprisesLocationsService.createOne({
                      enterprises_id: enterpriseId,
                      locations_id: locationId
                    });
                  }
                }
              }

              // Procesar keywords
              if (keywords) {
                const keywordsList = keywords.split(';').map(k => k.trim()).filter(k => k);
                for (const keyword of keywordsList) {
                  const keywordId = await findOrCreate(keywordsService, 'name', keyword);
                  if (keywordId) {
                    await enterprisesKeywordsService.createOne({
                      enterprises_id: enterpriseId,
                      keywords_id: keywordId
                    });
                  }
                }
              }

              // Procesar tecnologías
              if (tecnologias) {
                const tecnologiasList = tecnologias.split(';').map(t => t.trim()).filter(t => t);
                for (const technology of tecnologiasList) {
                  const technologyId = await findOrCreate(technologiesService, 'name', technology);
                  if (technologyId) {
                    await enterprisesTechnologiesService.createOne({
                      enterprises_id: enterpriseId,
                      technologies_id: technologyId
                    });
                  }
                }
              }
            }
          }

          // 2. Crear persona
          const personData = {
            name: nombre,
            email: email || null,
            phone: telefono || null
          };

          // Filtrar campos vacíos
          Object.keys(personData).forEach(key => {
            if (personData[key] === null || personData[key] === undefined || personData[key] === '') {
              delete personData[key];
            }
          });

          const newPerson = await peopleService.createOne(personData);

          // 3. Crear relación de empleo si existe empresa
          if (enterpriseId) {
            await employmentHistoryService.createOne({
              person_id: newPerson,
              enterprise_id: enterpriseId,
              is_current: true
            });
          }

          results.push({
            person_id: newPerson,
            enterprise_id: enterpriseId,
            name: nombre,
            status: 'success'
          });

        } catch (error) {
          console.error(`Error procesando fila ${i + 1}:`, error);
          errors.push({
            row: i + 1,
            error: error.message
          });
        }
      }

      // Respuesta
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