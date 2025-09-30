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

      // Servicios para cada colección
      const enterprisesService = new ItemsService('enterprises', { schema, accountability: req.accountability });
      const industriesService = new ItemsService('industries', { schema, accountability: req.accountability });
      const enterprisesIndustriesService = new ItemsService('enterprises_industries', { schema, accountability: req.accountability });
      const tagsService = new ItemsService('enterprise_tags', { schema, accountability: req.accountability });
      const enterprisesTagsService = new ItemsService('enterprises_tags', { schema, accountability: req.accountability });

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

          // Mapear headers del CSV a campos de la base de datos
          // Se esperan headers: organization_name, commercial_name, fiscal_identification, fiscal_identification_type,
          // country, normalized_address, website, phone_prefix, phone_number, company_size, linkedin,
          // acquisition_source, internal_owner, notes, industries (separados por ;), tags (separados por ;)

          // Parsear valores del CSV
          const fieldMap: any = {};
          const headers = lines[0].split(',').map((h: string) => h.trim().replace(/^"(.*)"$/, '$1'));

          headers.forEach((header: string, index: number) => {
            fieldMap[header] = values[index] || null;
          });

          // Verificar campo obligatorio
          if (!fieldMap.organization_name || fieldMap.organization_name.trim() === '') {
            errors.push({
              row: i + 1,
              error: 'organization_name es campo obligatorio'
            });
            continue;
          }

          // 1. Crear o encontrar empresa
          let enterpriseId = null;

          // Buscar empresa existente por fiscal_identification si existe
          if (fieldMap.fiscal_identification && fieldMap.fiscal_identification.trim() !== '') {
            const existingEnterprise = await enterprisesService.readByQuery({
              filter: { fiscal_identification: { _eq: fieldMap.fiscal_identification.trim() } },
              limit: 1
            });

            if (existingEnterprise && existingEnterprise.length > 0) {
              enterpriseId = existingEnterprise[0].id;
              console.log(`Empresa existente encontrada: ${fieldMap.organization_name} (ID: ${enterpriseId})`);
            }
          }

          if (!enterpriseId) {
            // Crear nueva empresa con todos los campos
            const enterpriseData: any = {
              organization_name: fieldMap.organization_name?.trim(),
              commercial_name: fieldMap.commercial_name?.trim() || null,
              fiscal_identification: fieldMap.fiscal_identification?.trim() || null,
              fiscal_identification_type: fieldMap.fiscal_identification_type?.trim() || null,
              country: fieldMap.country?.trim() || null,
              normalized_address: fieldMap.normalized_address?.trim() || null,
              website: fieldMap.website?.trim() || null,
              phone_prefix: fieldMap.phone_prefix?.trim() || null,
              phone_number: fieldMap.phone_number?.trim() || null,
              company_size: fieldMap.company_size?.trim() || null,
              linkedin: fieldMap.linkedin?.trim() || null,
              acquisition_source: fieldMap.acquisition_source?.trim() || 'other',
              internal_owner: fieldMap.internal_owner?.trim() || null,
              notes: fieldMap.notes?.trim() || null
            };

            // Filtrar campos vacíos
            Object.keys(enterpriseData).forEach(key => {
              if (enterpriseData[key] === null || enterpriseData[key] === undefined || enterpriseData[key] === '') {
                delete enterpriseData[key];
              }
            });

            enterpriseId = await enterprisesService.createOne(enterpriseData);
            console.log(`Nueva empresa creada: ${fieldMap.organization_name} (ID: ${enterpriseId})`);
          }

          // Procesar relaciones para la empresa
          if (enterpriseId) {
            // Procesar industries (siempre asignar al menos "Sin clasificar")
            let industriesList = [];
            if (fieldMap.industries && fieldMap.industries.trim() !== '') {
              industriesList = fieldMap.industries.split(';').map((ind: string) => ind.trim()).filter((ind: string) => ind);
            }

            // Si no hay industrias, asignar "Sin clasificar"
            if (industriesList.length === 0) {
              industriesList = ['Sin clasificar'];
            }

            for (const industryName of industriesList) {
              const industryId = await findOrCreate(industriesService, 'name', industryName);
              if (industryId) {
                try {
                  await enterprisesIndustriesService.createOne({
                    enterprises_id: enterpriseId,
                    industries_id: industryId
                  });
                } catch (error: any) {
                  // Ignorar errores de duplicados
                  if (!error.message.includes('duplicate') && !error.message.includes('unique')) {
                    console.error('Error creando relación industria:', error);
                  }
                }
              }
            }

            // Procesar tags
            if (fieldMap.tags) {
              const tagsList = fieldMap.tags.split(';').map((tag: string) => tag.trim()).filter((tag: string) => tag);
              for (const tagName of tagsList) {
                const tagId = await findOrCreate(tagsService, 'name', tagName);
                if (tagId) {
                  try {
                    await enterprisesTagsService.createOne({
                      enterprises_id: enterpriseId,
                      enterprise_tags_id: tagId
                    });
                  } catch (error: any) {
                    // Ignorar errores de duplicados
                    if (!error.message.includes('duplicate') && !error.message.includes('unique')) {
                      console.error('Error creando relación tag:', error);
                    }
                  }
                }
              }
            }
          }

          // Resultado exitoso
          results.push({
            enterprise_id: enterpriseId,
            organization_name: fieldMap.organization_name,
            fiscal_identification: fieldMap.fiscal_identification,
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