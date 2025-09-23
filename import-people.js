const fs = require('fs');
const csv = require('csv-parser');
const fetch = require('node-fetch');

// URL base de Directus
const DIRECTUS_URL = 'http://localhost:8055';
const TOKEN = 'sXbZMcS_1GgGc-Wgaf4a_-2gKMq-IYBt';

// Función para hacer requests a Directus
async function directusRequest(endpoint, method = 'GET', data = null) {
  const url = `${DIRECTUS_URL}${endpoint}`;
  const options = {
    method,
    headers: {
      'Authorization': `Bearer ${TOKEN}`,
      'Content-Type': 'application/json'
    }
  };

  if (data && (method === 'POST' || method === 'PATCH')) {
    options.body = JSON.stringify(data);
  }

  const response = await fetch(url, options);

  if (!response.ok) {
    const error = await response.text();
    throw new Error(`HTTP ${response.status}: ${error}`);
  }

  return await response.json();
}

// Función para encontrar o crear elemento
async function findOrCreate(collection, field, value, defaultData = {}) {
  if (!value || value.trim() === '') return null;

  try {
    // Buscar elemento existente
    const response = await directusRequest(`/items/${collection}?filter[${field}][_eq]=${encodeURIComponent(value.trim())}&limit=1`);

    if (response.data && response.data.length > 0) {
      return response.data[0].id;
    }

    // Crear nuevo elemento
    const newData = { [field]: value.trim(), ...defaultData };
    const newResponse = await directusRequest(`/items/${collection}`, 'POST', newData);

    return newResponse.data.id;
  } catch (error) {
    console.error(`Error en findOrCreate para ${collection}/${field}/${value}:`, error.message);
    return null;
  }
}

// Función principal de importación
async function importPeopleFromCSV(csvFilePath) {
  console.log(`📊 Iniciando importación desde ${csvFilePath}...`);

  const results = [];
  const errors = [];
  let count = 0;

  // Leer todos los registros primero
  const rows = [];

  return new Promise((resolve, reject) => {
    fs.createReadStream(csvFilePath)
      .pipe(csv())
      .on('data', (row) => {
        rows.push(row);
      })
      .on('end', async () => {
        // Procesar registros uno por uno de forma secuencial
        for (const row of rows) {
        try {
          count++;
          console.log(`\n🔄 Procesando registro ${count}: ${row.nombre}`);

          // 1. Crear o encontrar empresa
          let enterpriseId = null;
          if (row.nit && row.nombre) {
            // Buscar empresa por NIT
            const existingEnterprise = await directusRequest(`/items/enterprises?filter[nit][_eq]=${encodeURIComponent(row.nit)}&limit=1`);

            if (existingEnterprise.data && existingEnterprise.data.length > 0) {
              enterpriseId = existingEnterprise.data[0].id;
              console.log(`✅ Empresa encontrada: ${row.nombre} (ID: ${enterpriseId})`);
            } else {
              // Crear nueva empresa
              const enterpriseData = {
                nit: row.nit,
                name: row.nombre,
                phone: row.telefono || null,
                email: row.email || null,
                linkedin: row.linkedin || null,
                founded_year: row.fundacion || null
              };

              // Filtrar campos vacíos
              Object.keys(enterpriseData).forEach(key => {
                if (enterpriseData[key] === null || enterpriseData[key] === undefined || enterpriseData[key] === '') {
                  delete enterpriseData[key];
                }
              });

              const newEnterprise = await directusRequest('/items/enterprises', 'POST', enterpriseData);
              enterpriseId = newEnterprise.data.id;
              console.log(`✅ Empresa creada: ${row.nombre} (ID: ${enterpriseId})`);

              // Procesar industria de la empresa
              if (row.industria) {
                const industryId = await findOrCreate('industries', 'name', row.industria);
                if (industryId) {
                  await directusRequest('/items/enterprises_industries', 'POST', {
                    enterprises_id: enterpriseId,
                    industries_id: industryId
                  });
                  console.log(`   ✅ Industria vinculada: ${row.industria}`);
                }
              }

              // Procesar ubicaciones de la empresa
              if (row.ubicaciones) {
                const ubicaciones = row.ubicaciones.split(',').map(u => u.trim());
                for (const ubicacion of ubicaciones) {
                  const locationId = await findOrCreate('locations', 'city', ubicacion, {
                    country: 'Colombia',
                    province: 'N/A' // Valor por defecto ya que es requerido
                  });
                  if (locationId) {
                    await directusRequest('/items/enterprises_locations', 'POST', {
                      enterprises_id: enterpriseId,
                      locations_id: locationId
                    });
                    console.log(`   ✅ Ubicación vinculada: ${ubicacion}`);
                  }
                }
              }

              // Procesar keywords de la empresa
              if (row.keywords) {
                const keywords = row.keywords.split(',').map(k => k.trim()).filter(k => k);
                for (const keyword of keywords) {
                  const keywordId = await findOrCreate('keywords', 'name', keyword);
                  if (keywordId) {
                    await directusRequest('/items/enterprises_keywords', 'POST', {
                      enterprises_id: enterpriseId,
                      keywords_id: keywordId
                    });
                    console.log(`   ✅ Keyword vinculada: ${keyword}`);
                  }
                }
              }

              // Procesar tecnologías de la empresa
              if (row.tecnologias) {
                const tecnologias = row.tecnologias.split(',').map(t => t.trim()).filter(t => t);
                for (const technology of tecnologias) {
                  const technologyId = await findOrCreate('technologies', 'name', technology);
                  if (technologyId) {
                    await directusRequest('/items/enterprises_technologies', 'POST', {
                      enterprises_id: enterpriseId,
                      technologies_id: technologyId
                    });
                    console.log(`   ✅ Tecnología vinculada: ${technology}`);
                  }
                }
              }
            }
          }

          // 2. Crear persona
          const personData = {
            name: row.nombre,
            phone: enterpriseId ? null : (row.telefono || null),
            email: enterpriseId ? null : (row.email || null),
            linkedin: enterpriseId ? null : (row.linkedin || null)
          };

          // Filtrar campos vacíos
          Object.keys(personData).forEach(key => {
            if (personData[key] === null || personData[key] === undefined || personData[key] === '') {
              delete personData[key];
            }
          });

          const newPerson = await directusRequest('/items/people', 'POST', personData);
          console.log(`✅ Persona creada: ${row.nombre} (ID: ${newPerson.data.id})`);

          // 3. Crear relación de empleo si existe empresa
          if (enterpriseId) {
            await directusRequest('/items/person_employment_history', 'POST', {
              person_id: newPerson.data.id,
              enterprise_id: enterpriseId,
              is_current: true
            });
            console.log(`   ✅ Relación laboral creada`);
          }

          // 4. Si no hay empresa, asociar keywords y tecnologías a la persona
          if (!enterpriseId) {
            // Procesar keywords de la persona
            if (row.keywords) {
              const keywords = row.keywords.split(',').map(k => k.trim()).filter(k => k);
              for (const keyword of keywords) {
                const keywordId = await findOrCreate('keywords', 'name', keyword);
                if (keywordId) {
                  await directusRequest('/items/people_keywords', 'POST', {
                    people_id: newPerson.data.id,
                    keywords_id: keywordId
                  });
                  console.log(`   ✅ Keyword personal vinculada: ${keyword}`);
                }
              }
            }

            // Procesar tecnologías de la persona
            if (row.tecnologias) {
              const tecnologias = row.tecnologias.split(',').map(t => t.trim()).filter(t => t);
              for (const technology of tecnologias) {
                const technologyId = await findOrCreate('technologies', 'name', technology);
                if (technologyId) {
                  await directusRequest('/items/people_technologies', 'POST', {
                    people_id: newPerson.data.id,
                    technologies_id: technologyId
                  });
                  console.log(`   ✅ Tecnología personal vinculada: ${technology}`);
                }
              }
            }
          }

          results.push({
            person_id: newPerson.data.id,
            enterprise_id: enterpriseId,
            name: row.nombre,
            status: 'success'
          });

          } catch (error) {
            console.error(`❌ Error procesando ${row.nombre}:`, error.message);
            errors.push({
              row: count,
              name: row.nombre || 'Sin nombre',
              error: error.message
            });
          }
        }

        console.log(`\n🎉 Importación completada!`);
        console.log(`📊 Registros procesados: ${count}`);
        console.log(`✅ Exitosos: ${results.length}`);
        console.log(`❌ Errores: ${errors.length}`);

        if (errors.length > 0) {
          console.log('\n❌ Errores encontrados:');
          errors.forEach(error => {
            console.log(`   - Fila ${error.row} (${error.name}): ${error.error}`);
          });
        }

        resolve({ results, errors, count });
      })
      .on('error', reject);
  });
}

// Ejecutar importación
if (require.main === module) {
  const csvFile = process.argv[2] || 'ejemplo-people.csv';

  if (!fs.existsSync(csvFile)) {
    console.error(`❌ El archivo ${csvFile} no existe`);
    process.exit(1);
  }

  importPeopleFromCSV(csvFile)
    .then((result) => {
      console.log('\n✅ Importación finalizada correctamente');
      process.exit(0);
    })
    .catch((error) => {
      console.error('❌ Error en la importación:', error);
      process.exit(1);
    });
}