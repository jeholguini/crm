import { defineEndpoint } from '@directus/extensions-sdk';

export default defineEndpoint((router, { services }) => {
  const { ItemsService } = services;

  // Configurar multer para manejo de archivos
  const multer = require('multer');
  const upload = multer({
    storage: multer.memoryStorage(),
    limits: {
      fileSize: 10 * 1024 * 1024, // 10MB max
    },
    fileFilter: (req: any, file: any, cb: any) => {
      if (file.mimetype === 'text/csv' || file.originalname.endsWith('.csv')) {
        cb(null, true);
      } else {
        cb(new Error('Solo se permiten archivos CSV'));
      }
    }
  });

  // Endpoint para importar archivo CSV
  router.post('/', upload.single('file'), async (req, res) => {
    try {
      // Verificar que se recibió archivo
      if (!req.file) {
        return res.status(400).json({
          success: false,
          error: 'No se proporcionó archivo CSV'
        });
      }

      // Convertir buffer a string
      const csvData = req.file.buffer.toString('utf-8');
      const lines = csvData.split('\n').filter((line: string) => line.trim());

      if (lines.length < 2) {
        return res.status(400).json({
          success: false,
          error: 'El CSV debe tener al menos una fila de datos'
        });
      }

      // Obtener esquema para servicios
      const schema = req.schema;

      // Servicios para cada colección (solo para empresas)
      const enterprisesService = new ItemsService('enterprises', { schema, accountability: req.accountability });
      const industriesService = new ItemsService('industries', { schema, accountability: req.accountability });
      const locationsService = new ItemsService('locations', { schema, accountability: req.accountability });
      const keywordsService = new ItemsService('keywords', { schema, accountability: req.accountability });
      const technologiesService = new ItemsService('technologies', { schema, accountability: req.accountability });
      const enterprisesIndustriesService = new ItemsService('enterprises_industries', { schema, accountability: req.accountability });
      const enterprisesLocationsService = new ItemsService('enterprises_locations', { schema, accountability: req.accountability });
      const enterprisesKeywordsService = new ItemsService('enterprises_keywords', { schema, accountability: req.accountability });
      const enterprisesTechnologiesService = new ItemsService('enterprises_technologies', { schema, accountability: req.accountability });

      const results: any[] = [];
      const errors: any[] = [];

      // Función para encontrar o crear elemento
      async function findOrCreate(service: any, field: string, value: string, defaultData: any = {}) {
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
        } catch (error: any) {
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
          const values = line.split(',').map((v: string) => v.trim().replace(/^"(.*)"$/, '$1'));

          if (values.length < 10) {
            errors.push({
              row: i + 1,
              error: 'Fila incompleta, se esperan 10 columnas'
            });
            continue;
          }

          const [nit, nombre, telefono, email, industria, linkedin, fundacion, ubicaciones, keywords, tecnologias] = values;

          // Verificar que tenemos los campos mínimos requeridos
          if (!nit || !nombre) {
            errors.push({
              row: i + 1,
              error: 'NIT y nombre son campos obligatorios'
            });
            continue;
          }

          // 1. Crear o encontrar empresa
          let enterpriseId = null;
          const existingEnterprise = await enterprisesService.readByQuery({
            filter: { nit: { _eq: nit } },
            limit: 1
          });

          if (existingEnterprise && existingEnterprise.length > 0) {
            // Empresa ya existe, actualizar información si es necesario
            enterpriseId = existingEnterprise[0].id;
            console.log(`Empresa existente encontrada: ${nombre} (ID: ${enterpriseId})`);
          } else {
            // Crear nueva empresa
            const enterpriseData: any = {
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
            console.log(`Nueva empresa creada: ${nombre} (ID: ${enterpriseId})`);
          }

          // Procesar relaciones para la empresa (nueva o existente)
          if (enterpriseId) {
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
              const ubicacionesList = ubicaciones.split(';').map((u: string) => u.trim());
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
              const keywordsList = keywords.split(';').map((k: string) => k.trim()).filter((k: string) => k);
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
              const tecnologiasList = tecnologias.split(';').map((t: string) => t.trim()).filter((t: string) => t);
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

          // Resultado exitoso
          results.push({
            enterprise_id: enterpriseId,
            name: nombre,
            nit: nit,
            status: 'success'
          });

        } catch (error: any) {
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
        message: `Importación de empresas completada. ${results.length} empresas procesadas.`,
        data: {
          processed: lines.length - 1,
          successful: results.length,
          errors: errors.length,
          enterprises: results,
          errorDetails: errors
        }
      });

    } catch (error: any) {
      console.error('Error en importación:', error);
      res.status(500).json({
        success: false,
        error: error.message
      });
    }
  });
});