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
        'POST /people - Importar CSV de personas (formato Pipedrive)',
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

      // Servicios
      const peopleService = new ItemsService('people', { schema, accountability: req.accountability });
      const enterprisesService = new ItemsService('enterprises', { schema, accountability: req.accountability });

      const results = [];
      const errors = [];

      // Procesar header
      const headers = parseCSVLine(lines[0]);

      // Mapeo de campos de Pipedrive a nuestra estructura
      const fieldMapping = {};
      headers.forEach((header, index) => {
        switch (header.toLowerCase()) {
          case 'name':
            fieldMapping.full_name = index;
            break;
          case 'email_value':
            fieldMapping.primary_email = index;
            break;
          case 'phone_value':
            fieldMapping.phone_number = index;
            break;
          case 'job_title':
            fieldMapping.position_title = index;
            break;
          case 'org_name':
            fieldMapping.org_name = index;
            break;
          case 'notes':
            fieldMapping.notes = index;
            break;
          case 'first_name':
            fieldMapping.first_name = index;
            break;
          case 'last_name':
            fieldMapping.last_name = index;
            break;
          case 'org_id_name':
            fieldMapping.org_id_name = index;
            break;
        }
      });

      // Procesar cada fila
      for (let i = 1; i < lines.length; i++) {
        try {
          const values = parseCSVLine(lines[i]);

          // Construir nombre completo
          let fullName = '';
          if (fieldMapping.full_name !== undefined && values[fieldMapping.full_name]) {
            fullName = values[fieldMapping.full_name].trim();
          } else if (fieldMapping.first_name !== undefined && fieldMapping.last_name !== undefined) {
            const firstName = values[fieldMapping.first_name] || '';
            const lastName = values[fieldMapping.last_name] || '';
            fullName = `${firstName} ${lastName}`.trim();
          }

          if (!fullName) {
            errors.push({
              row: i + 1,
              error: 'Nombre completo requerido'
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
              filter: { full_name: { _eq: fullName } },
              limit: 1,
              fields: ['id', 'full_name', 'primary_email']
            });
          }

          if (existingPerson && existingPerson.length > 0) {
            results.push({
              row: i + 1,
              full_name: fullName,
              primary_email: email,
              status: 'exists',
              id: existingPerson[0].id
            });
            continue;
          }

          // Buscar empresa si existe
          let enterpriseId = null;
          const orgName = fieldMapping.org_name !== undefined ? values[fieldMapping.org_name] :
                         fieldMapping.org_id_name !== undefined ? values[fieldMapping.org_id_name] : null;

          if (orgName && orgName.trim()) {
            const existingEnterprise = await enterprisesService.readByQuery({
              filter: { organization_name: { _eq: orgName.trim() } },
              limit: 1,
              fields: ['id', 'organization_name']
            });

            if (existingEnterprise && existingEnterprise.length > 0) {
              enterpriseId = existingEnterprise[0].id;
            }
          }

          // Crear nueva persona
          const personData = {
            full_name: fullName,
            acquisition_source: 'other'
          };

          // Agregar campos opcionales
          if (email && email.trim()) {
            personData.primary_email = email.trim();
          }

          if (fieldMapping.phone_number !== undefined && values[fieldMapping.phone_number]) {
            const phone = values[fieldMapping.phone_number].trim();
            // Separar prefijo y número si el teléfono contiene un +
            if (phone.startsWith('+')) {
              const match = phone.match(/^(\+\d{1,4})\s*(.+)$/);
              if (match) {
                personData.phone_prefix = match[1];
                personData.phone_number = match[2].replace(/\D/g, '');
              } else {
                personData.phone_number = phone.replace(/\D/g, '');
              }
            } else {
              personData.phone_number = phone.replace(/\D/g, '');
            }
          }

          if (fieldMapping.position_title !== undefined && values[fieldMapping.position_title]) {
            personData.position_title = values[fieldMapping.position_title].trim();
          }

          if (fieldMapping.notes !== undefined && values[fieldMapping.notes]) {
            personData.notes = values[fieldMapping.notes].trim();
          }

          if (enterpriseId) {
            personData.enterprise_relation_id = enterpriseId;
          }

          // Agregar nota de importación
          const importNote = 'Importado desde CSV Pipedrive';
          if (personData.notes) {
            personData.notes = `${personData.notes}\n\n${importNote}`;
          } else {
            personData.notes = importNote;
          }

          const newPerson = await peopleService.createOne(personData);

          results.push({
            row: i + 1,
            full_name: fullName,
            primary_email: email,
            enterprise_relation_id: enterpriseId,
            status: 'created',
            id: newPerson
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