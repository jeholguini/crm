module.exports = (router, { services, getSchema, database }) => {
  const { ItemsService } = services;

  // Función auxiliar para encontrar o crear un tag/industria
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

  // Función para formatear dirección como JSON string
  function formatAddress(direccionObj) {
    if (!direccionObj) return null;

    // Si ya es un string, devolverlo
    if (typeof direccionObj === 'string') {
      return direccionObj;
    }

    // Convertir objeto a JSON string
    return JSON.stringify(direccionObj);
  }

  // Función para mapear tamaño de empresa
  function mapCompanySize(size) {
    if (!size) return null;

    const mapping = {
      '1-10': '1-10',
      '11-50': '11-50',
      '51-200': '51-200',
      '51-250': '51-200', // Mapear 51-250 a 51-200
      '201-500': '201-500',
      '501-1000': '501-1000',
      '1000+': '1000+'
    };

    // Buscar coincidencia exacta
    if (mapping[size]) {
      return mapping[size];
    }

    // Intentar extraer rango numérico
    const match = size.match(/(\d+)[-–](\d+)/);
    if (match) {
      const min = parseInt(match[1]);
      const max = parseInt(match[2]);

      if (max <= 10) return '1-10';
      if (max <= 50) return '11-50';
      if (max <= 200 || max <= 250) return '51-200';
      if (max <= 500) return '201-500';
      if (max <= 1000) return '501-1000';
      return '1000+';
    }

    return null;
  }

  // Función para mapear código de país
  function mapCountryCode(country) {
    if (!country) return null;

    const mapping = {
      'España': 'ESP',
      'Spain': 'ESP',
      'Colombia': 'COL',
      'Argentina': 'ARG',
      'Brasil': 'BRA',
      'Brazil': 'BRA',
      'Chile': 'CHL',
      'México': 'MEX',
      'Mexico': 'MEX',
      'Perú': 'PER',
      'Peru': 'PER',
      'Estados Unidos': 'USA',
      'United States': 'USA',
      'USA': 'USA'
    };

    // Si ya es un código de 3 letras, devolverlo en mayúsculas
    if (country.length === 3) {
      return country.toUpperCase();
    }

    return mapping[country] || null;
  }

  // Función para mapear tipo de identificación fiscal
  function mapFiscalType(type) {
    if (!type) return null;

    const mapping = {
      'CIF': 'OTHER',
      'NIF': 'OTHER',
      'NIT': 'NIT',
      'RUT': 'RUT',
      'RUC': 'RUC',
      'CUIT': 'CUIT',
      'CNPJ': 'CNPJ',
      'RFC': 'RFC'
    };

    const upperType = type.toUpperCase();
    return mapping[upperType] || 'OTHER';
  }

  // Función para mapear fuente de adquisición
  function mapAcquisitionSource(source) {
    if (!source) return null;

    const mapping = {
      'LTB IA': 'other',
      'Sitio web': 'website',
      'Website': 'website',
      'Referido': 'referral',
      'LinkedIn': 'linkedin',
      'Publicidad': 'advertising',
      'Evento': 'event',
      'Cold outreach': 'cold_outreach',
      'Otro': 'other'
    };

    return mapping[source] || 'other';
  }

  // Endpoint de prueba
  router.get('/test', (req, res) => {
    res.json({
      success: true,
      message: 'Extensión de upsert de empresas funcionando',
      timestamp: new Date().toISOString(),
      routes: [
        'GET /test - Prueba de conectividad',
        'POST /upsert - Crear o actualizar empresas desde JSON'
      ]
    });
  });

  // Endpoint principal para upsert de empresas
  router.post('/upsert', async (req, res) => {
    try {
      const enterprises = req.body;

      // Validar que sea un array
      if (!Array.isArray(enterprises)) {
        return res.status(400).json({
          success: false,
          error: 'El cuerpo debe ser un array de objetos de empresas'
        });
      }

      if (enterprises.length === 0) {
        return res.status(400).json({
          success: false,
          error: 'El array no puede estar vacío'
        });
      }

      // Obtener esquema
      const schema = await getSchema();

      // Servicios necesarios
      const enterprisesService = new ItemsService('enterprises', {
        schema,
        accountability: req.accountability
      });

      const industriesService = new ItemsService('industries', {
        schema,
        accountability: req.accountability
      });

      const tagsService = new ItemsService('tags', {
        schema,
        accountability: req.accountability
      });

      const enterpriseIndustriesService = new ItemsService('enterprises_industries', {
        schema,
        accountability: req.accountability
      });

      const enterpriseTagsService = new ItemsService('enterprises_tags', {
        schema,
        accountability: req.accountability
      });

      const results = [];
      const errors = [];

      // Procesar cada empresa
      for (let i = 0; i < enterprises.length; i++) {
        try {
          const enterprise = enterprises[i];

          // Obtener campos de búsqueda
          const organizationName = enterprise['Nombre de la organización'];
          const fiscalId = enterprise['Identificación fiscal'];

          // Validar que al menos uno de los campos de búsqueda esté presente
          if ((!organizationName || organizationName.trim() === '') && (!fiscalId || fiscalId.trim() === '')) {
            errors.push({
              index: i,
              error: 'Se requiere al menos "Nombre de la organización" o "Identificación fiscal"'
            });
            continue;
          }

          // Buscar empresa existente por identificación fiscal
          let existingEnterprise = null;

          if (fiscalId && fiscalId.trim()) {
            const found = await enterprisesService.readByQuery({
              filter: {
                fiscal_identification: { _eq: fiscalId.trim() }
              },
              limit: 1,
              fields: ['id', 'organization_name']
            });

            if (found && found.length > 0) {
              existingEnterprise = found[0];
            }
          }

          // Si no se encontró por fiscal ID, buscar por nombre
          if (!existingEnterprise && organizationName && organizationName.trim()) {
            const found = await enterprisesService.readByQuery({
              filter: {
                organization_name: { _eq: organizationName.trim() }
              },
              limit: 1,
              fields: ['id', 'organization_name']
            });

            if (found && found.length > 0) {
              existingEnterprise = found[0];
            }
          }

          // Preparar datos de la empresa
          const enterpriseData = {};

          // Nombre de organización (requerido solo si no existe la empresa)
          if (organizationName && organizationName.trim()) {
            enterpriseData.organization_name = organizationName.trim();
          } else if (!existingEnterprise) {
            // Si no existe y no se proporciona nombre, error
            errors.push({
              index: i,
              error: 'Nombre de la organización es requerido para crear una nueva empresa'
            });
            continue;
          }

          // Mapear campos opcionales
          if (enterprise['Nombre comercial / marca']) {
            enterpriseData.commercial_name = enterprise['Nombre comercial / marca'].trim();
          }

          if (enterprise['LinkedIn']) {
            enterpriseData.linkedin = enterprise['LinkedIn'].trim();
          }

          if (enterprise['Tipo de identificación fiscal']) {
            enterpriseData.fiscal_identification_type = mapFiscalType(enterprise['Tipo de identificación fiscal']);
          }

          if (fiscalId) {
            enterpriseData.fiscal_identification = fiscalId.trim();
          }

          if (enterprise['Tamaño de la empresa (rango empleados)']) {
            enterpriseData.company_size = mapCompanySize(enterprise['Tamaño de la empresa (rango empleados)']);
          }

          if (enterprise['País']) {
            enterpriseData.country = mapCountryCode(enterprise['País']);
          }

          if (enterprise['Direccion']) {
            enterpriseData.normalized_address = formatAddress(enterprise['Direccion']);
          }

          if (enterprise['Sitio web']) {
            enterpriseData.website = enterprise['Sitio web'].trim();
          }

          if (enterprise['Teléfono – prefijo']) {
            enterpriseData.phone_prefix = enterprise['Teléfono – prefijo'].trim();
          }

          if (enterprise['Teléfono – número']) {
            enterpriseData.phone_number = enterprise['Teléfono – número'].trim();
          }

          if (enterprise['Fuente de adquisición']) {
            enterpriseData.acquisition_source = mapAcquisitionSource(enterprise['Fuente de adquisición']);
          }

          if (enterprise['Propietario interno']) {
            enterpriseData.internal_owner = enterprise['Propietario interno'].trim();
          }

          if (enterprise['Notas']) {
            enterpriseData.notes = enterprise['Notas'].trim();
          }

          let enterpriseId;
          let action;

          // Actualizar o crear empresa
          if (existingEnterprise) {
            // Actualizar empresa existente
            await enterprisesService.updateOne(existingEnterprise.id, enterpriseData);
            enterpriseId = existingEnterprise.id;
            action = 'updated';
          } else {
            // Crear nueva empresa
            enterpriseId = await enterprisesService.createOne(enterpriseData);
            action = 'created';
          }

          // Procesar industrias (M2M)
          if (enterprise['Sector / industria']) {
            const industry = enterprise['Sector / industria'];
            const industryId = await findOrCreate(industriesService, 'name', industry);

            if (industryId) {
              try {
                // Verificar si la relación ya existe
                const existingRelation = await enterpriseIndustriesService.readByQuery({
                  filter: {
                    _and: [
                      { enterprises_id: { _eq: enterpriseId } },
                      { industries_id: { _eq: industryId } }
                    ]
                  },
                  limit: 1
                });

                if (!existingRelation || existingRelation.length === 0) {
                  await enterpriseIndustriesService.createOne({
                    enterprises_id: enterpriseId,
                    industries_id: industryId
                  });
                }
              } catch (error) {
                console.error('Error creando relación industria:', error);
              }
            }
          }

          // Procesar tags (M2M)
          if (enterprise['Etiquetas / tags'] && Array.isArray(enterprise['Etiquetas / tags'])) {
            for (const tagName of enterprise['Etiquetas / tags']) {
              const tagId = await findOrCreate(tagsService, 'name', tagName);

              if (tagId) {
                try {
                  // Verificar si la relación ya existe
                  const existingRelation = await enterpriseTagsService.readByQuery({
                    filter: {
                      _and: [
                        { enterprises_id: { _eq: enterpriseId } },
                        { tags_id: { _eq: tagId } }
                      ]
                    },
                    limit: 1
                  });

                  if (!existingRelation || existingRelation.length === 0) {
                    await enterpriseTagsService.createOne({
                      enterprises_id: enterpriseId,
                      tags_id: tagId
                    });
                  }
                } catch (error) {
                  console.error('Error creando relación tag:', error);
                }
              }
            }
          }

          results.push({
            index: i,
            organization_name: organizationName && organizationName.trim()
              ? organizationName.trim()
              : existingEnterprise?.organization_name || 'N/A',
            action: action,
            id: enterpriseId
          });

        } catch (error) {
          console.error(`Error procesando empresa ${i}:`, error);
          errors.push({
            index: i,
            error: error.message
          });
        }
      }

      res.json({
        success: true,
        message: `Procesadas ${results.length} empresas de ${enterprises.length} total.`,
        data: {
          processed: enterprises.length,
          successful: results.length,
          errors: errors.length,
          results: results,
          errorDetails: errors
        }
      });

    } catch (error) {
      console.error('Error en upsert de empresas:', error);
      res.status(500).json({
        success: false,
        error: error.message
      });
    }
  });
};
