export default (router, { services, database }) => {
  const { ItemsService } = services;

  // Endpoint para importar CSV
  router.post('/people-import', async (req, res) => {
    try {
      // Verificar que se recibió contenido
      if (!req.body || !req.body.csvData) {
        return res.status(400).json({
          success: false,
          error: 'No se proporcionó datos CSV'
        });
      }

      const csvData = req.body.csvData;
      const lines = csvData.split('\n').filter(line => line.trim());

      if (lines.length < 2) {
        return res.status(400).json({
          success: false,
          error: 'El CSV debe tener al menos una fila de datos'
        });
      }

      // Obtener esquema para servicios
      const schema = req.schema;

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
      for (let i = 1; i < lines.length; i++) {
        try {
          const line = lines[i];
          if (!line.trim()) continue;

          // Parsear CSV simple (asumiendo comas como separador)
          const values = line.split(',').map(v => v.trim().replace(/^"(.*)"$/, '$1'));

          if (values.length < 10) {
            errors.push({
              row: i + 1,
              error: 'Fila incompleta, se esperan 10 columnas'
            });
            continue;
          }

          const [nit, nombre, telefono, email, industria, linkedin, fundacion, ubicaciones, keywords, tecnologias] = values;

          // 1. Crear o encontrar empresa
          let enterpriseId = null;
          if (nit && nombre) {
            const existingEnterprise = await enterprisesService.readByQuery({
              filter: { nit: { _eq: nit } },
              limit: 1
            });

            if (existingEnterprise && existingEnterprise.length > 0) {
              enterpriseId = existingEnterprise[0].id;
            } else {
              // Crear nueva empresa
              const enterpriseData = {
                nit: nit,
                name: nombre,
                phone: telefono || null,
                email: email || null,
                linkedin: linkedin || null,
                founded_year: fundacion || null
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
            name: nombre
          };

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
        message: `Importación completada. ${results.length} registros procesados.`,
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

  // Endpoint para obtener template CSV
  router.get('/people-import/template', (req, res) => {
    const template = [
      'nit,nombre,telefono,email,industria,linkedin,fundacion,ubicaciones,keywords,tecnologias',
      '123456789,TechCorp,+57601234567,info@techcorp.com,Tecnología,linkedin.com/company/techcorp,2010,Bogotá,software development,PHP;Laravel;React'
    ].join('\n');

    res.setHeader('Content-Type', 'text/csv');
    res.setHeader('Content-Disposition', 'attachment; filename="people-import-template.csv"');
    res.send(template);
  });

  // Endpoint de prueba
  router.get('/people-import/test', (req, res) => {
    res.json({
      message: 'Endpoint de importación de personas funcionando',
      endpoints: [
        'POST /people-import - Importar CSV',
        'GET /people-import/template - Descargar template',
        'GET /people-import/test - Prueba'
      ]
    });
  });
};