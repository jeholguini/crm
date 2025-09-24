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

      // Servicios
      const peopleService = new ItemsService('people', { schema, accountability: req.accountability });

      const results = [];
      const errors = [];

      // Procesar header
      const headers = parseCSVLine(lines[0]);

      // Mapeo de campos del CSV a la estructura REAL de la tabla people
      const fieldMapping = {};
      headers.forEach((header, index) => {
        switch (header.toLowerCase()) {
          case 'name':
            fieldMapping.name = index;
            break;
          case 'email':
            fieldMapping.email = index;
            break;
          case 'personal_phone':
            fieldMapping.personal_phone = index;
            break;
          case 'office_number':
            fieldMapping.office_number = index;
            break;
          case 'linkedin':
            fieldMapping.linkedin = index;
            break;
          case 'about':
            fieldMapping.about = index;
            break;
          case 'sex':
            fieldMapping.sex = index;
            break;
          case 'age':
            fieldMapping.age = index;
            break;
          case 'image':
            fieldMapping.image = index;
            break;
          case 'location_id':
            fieldMapping.location_id = index;
            break;
        }
      });

      // Procesar cada fila
      for (let i = 1; i < lines.length; i++) {
        try {
          const values = parseCSVLine(lines[i]);

          // Obtener nombre
          const name = fieldMapping.name !== undefined ? values[fieldMapping.name] : null;

          if (!name || !name.trim()) {
            errors.push({
              row: i + 1,
              error: 'Nombre requerido'
            });
            continue;
          }

          // Verificar si la persona ya existe por email o nombre
          const email = fieldMapping.email !== undefined ? values[fieldMapping.email] : null;
          let existingPerson = null;

          if (email && email.trim()) {
            existingPerson = await peopleService.readByQuery({
              filter: { email: { _eq: email.trim() } },
              limit: 1,
              fields: ['id', 'name', 'email']
            });
          }

          if (!existingPerson || existingPerson.length === 0) {
            existingPerson = await peopleService.readByQuery({
              filter: { name: { _eq: name.trim() } },
              limit: 1,
              fields: ['id', 'name', 'email']
            });
          }

          if (existingPerson && existingPerson.length > 0) {
            results.push({
              row: i + 1,
              name: name.trim(),
              email: email,
              status: 'exists',
              id: existingPerson[0].id
            });
            continue;
          }

          // Crear nueva persona con los campos REALES
          const personData = {
            name: name.trim()
          };

          // Agregar campos opcionales que coincidan con la tabla real
          if (email && email.trim()) {
            personData.email = email.trim();
          }

          if (fieldMapping.personal_phone !== undefined && values[fieldMapping.personal_phone]) {
            personData.personal_phone = values[fieldMapping.personal_phone].trim();
          }

          if (fieldMapping.office_number !== undefined && values[fieldMapping.office_number]) {
            personData.office_number = values[fieldMapping.office_number].trim();
          }

          if (fieldMapping.linkedin !== undefined && values[fieldMapping.linkedin]) {
            personData.linkedin = values[fieldMapping.linkedin].trim();
          }

          if (fieldMapping.about !== undefined && values[fieldMapping.about]) {
            personData.about = values[fieldMapping.about].trim();
          }

          if (fieldMapping.sex !== undefined && values[fieldMapping.sex]) {
            personData.sex = values[fieldMapping.sex].trim();
          }

          if (fieldMapping.age !== undefined && values[fieldMapping.age]) {
            const age = parseInt(values[fieldMapping.age]);
            if (!isNaN(age)) {
              personData.age = age;
            }
          }

          if (fieldMapping.image !== undefined && values[fieldMapping.image]) {
            personData.image = values[fieldMapping.image].trim();
          }

          if (fieldMapping.location_id !== undefined && values[fieldMapping.location_id]) {
            const locationId = parseInt(values[fieldMapping.location_id]);
            if (!isNaN(locationId)) {
              personData.location_id = locationId;
            }
          }

          const newPerson = await peopleService.createOne(personData);

          results.push({
            row: i + 1,
            name: name.trim(),
            email: email,
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