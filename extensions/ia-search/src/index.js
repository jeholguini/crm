const axios = require('axios');

// Acceder directamente a las variables de entorno de Directus
const config = {
  OPENAI_API_KEY: process.env.OPENAI_API_KEY
};

module.exports = (router, { services, getSchema, database }) => {
  const { ItemsService } = services;

  // Endpoint de prueba
  router.get('/test', (req, res) => {
    res.json({
      success: true,
      message: 'Extensión de búsqueda IA funcionando',
      timestamp: new Date().toISOString(),
      routes: [
        'GET /test - Prueba de conectividad',
        'POST /search-ia-profile - Búsqueda IA de perfiles',
        'POST /search-ia-enterprise - Búsqueda IA de empresas'
      ]
    });
  });

  // Endpoint principal para búsqueda con IA
  router.post('/search-ia-profile', async (req, res) => {
    try {
      const { query } = req.body;

      if (!query || query.trim() === '') {
        return res.status(400).json({
          success: false,
          error: 'Query is required'
        });
      }

      console.log('Búsqueda IA iniciada:', query);

      // Analizar consulta con OpenAI
      const entities = await analyzeWithOpenAI(query);
      console.log('Entidades extraídas:', entities);

      // Ejecutar búsqueda en Directus usando el accountability del request
      const schema = await getSchema();
      const results = await executePersonSearch(entities, schema, req.accountability);

      res.json({
        query: query,
        entities: entities,
        results: results,
        count: results.length
      });

    } catch (error) {
      console.error('Error en búsqueda IA:', error);
      res.status(500).json({
        success: false,
        error: 'Search failed: ' + error.message
      });
    }
  });

  // Endpoint para búsqueda de empresas con IA
  router.post('/search-ia-enterprise', async (req, res) => {
    try {
      const { query } = req.body;

      if (!query || query.trim() === '') {
        return res.status(400).json({
          success: false,
          error: 'Query is required'
        });
      }

      console.log('Búsqueda IA de empresas iniciada:', query);

      // Analizar consulta con OpenAI para empresas
      const entities = await analyzeWithOpenAI(query, 'enterprises');
      console.log('Entidades de empresas extraídas:', entities);

      // Ejecutar búsqueda en Directus
      const schema = await getSchema();
      const results = await executeEnterpriseSearch(entities, schema, req.accountability);

      res.json({
        query: query,
        entities: entities,
        results: results,
        count: results.length
      });

    } catch (error) {
      console.error('Error en búsqueda IA de empresas:', error);
      res.status(500).json({
        success: false,
        error: 'Search failed: ' + error.message
      });
    }
  });

  // Función para analizar consulta with OpenAI
  async function analyzeWithOpenAI(query, searchType = 'people') {
    // Obtener la clave desde config.js que usa variables de entorno
    const openaiApiKey = config.OPENAI_API_KEY || process.env.OPENAI_API_KEY;

    if (!openaiApiKey) {
      console.log('Config OPENAI_API_KEY:', config.OPENAI_API_KEY ? 'EXISTS' : 'NOT_FOUND');
      console.log('Process env OPENAI_API_KEY:', process.env.OPENAI_API_KEY ? 'EXISTS' : 'NOT_FOUND');
      throw new Error('OPENAI_API_KEY not found in configuration or environment variables');
    }

    const prompts = {
      people: {
        system: 'Analiza consultas para buscar personas. Extrae información sobre: cargo/posición, empresa, ubicación, tecnologías, industria, palabras clave, edad. Responde ÚNICAMENTE con JSON válido, sin texto adicional.',
        user: `Analiza esta consulta y extrae las entidades relevantes en formato JSON con las claves: position, company, location, technologies, keywords, industry, age_range. Consulta: "${query}"`
      },
      enterprises: {
        system: 'Analiza consultas para buscar empresas. Extrae información sobre: industria, ubicación, tecnologías, tamaño de empresa, palabras clave, segmento de mercado. Responde ÚNICAMENTE con JSON válido, sin texto adicional.',
        user: `Analiza esta consulta y extrae las entidades relevantes en formato JSON con las claves: industry, location, technologies, keywords, segment, size_range. Consulta: "${query}"`
      }
    };

    const systemPrompt = prompts[searchType].system;
    const userPrompt = prompts[searchType].user;

    try {
      const response = await axios.post('https://api.openai.com/v1/chat/completions', {
        model: 'gpt-3.5-turbo',
        messages: [
          { role: 'system', content: systemPrompt },
          { role: 'user', content: userPrompt }
        ],
        temperature: 0.3,
        max_tokens: 500
      }, {
        headers: {
          'Authorization': `Bearer ${openaiApiKey}`,
          'Content-Type': 'application/json'
        },
        timeout: 30000
      });

      let content = response.data.choices[0].message.content;

      // Limpiar respuesta de posibles marcadores de código
      content = content.replace(/```(?:json)?\s*|\s*```/g, '').trim();

      const entities = JSON.parse(content);
      return normalizeEntities(entities || {});

    } catch (error) {
      console.error('Error con OpenAI:', error.message);
      throw new Error('Error analyzing query with OpenAI: ' + error.message);
    }
  }

  // Función para remover acentos y normalizar texto
  function removeAccents(str) {
    return str.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
  }

  // Función para normalizar entidades
  function normalizeEntities(entities) {
    const normalized = {};

    for (const [key, value] of Object.entries(entities)) {
      if (typeof value === 'string' && value.trim()) {
        normalized[key] = [value.trim()];
      } else if (Array.isArray(value)) {
        const filtered = value.filter(v => v && typeof v === 'string' && v.trim()).map(v => v.trim());
        if (filtered.length > 0) {
          normalized[key] = filtered;
        }
      }
    }

    return normalized;
  }

  // Función para ejecutar búsqueda de personas
  async function executePersonSearch(entities, schema, accountability) {
    const peopleService = new ItemsService('people', { schema, accountability });

    // Construir filtros dinámicos
    const filters = [];
    let hasSpecificFilters = false;

    // Filtro por posición
    if (entities.position && entities.position.length > 0) {
      hasSpecificFilters = true;
      const positionFilters = entities.position.map(pos => ({
        position_title: { _icontains: pos }
      }));
      filters.push({ _or: positionFilters });
    }

    // Filtro por empresa (buscar en notas por ahora)
    if (entities.company && entities.company.length > 0) {
      hasSpecificFilters = true;
      const enterpriseFilters = entities.company.map(company => ({
        notes: { _icontains: company }
      }));
      filters.push({ _or: enterpriseFilters });
    }

    // Filtro por ubicación (buscar en notas por ahora)
    if (entities.location && entities.location.length > 0) {
      hasSpecificFilters = true;
      const locationFilters = [];
      entities.location.forEach(loc => {
        locationFilters.push(
          { notes: { _icontains: loc } }
        );
      });
      filters.push({ _or: locationFilters });
    }

    // Filtro por keywords (buscar en nombre y notas)
    if (entities.keywords && entities.keywords.length > 0) {
      hasSpecificFilters = true;
      const keywordFilters = [];
      entities.keywords.forEach(keyword => {
        keywordFilters.push(
          { full_name: { _icontains: keyword } },
          { notes: { _icontains: keyword } }
        );
      });
      filters.push({ _or: keywordFilters });
    }

    // Si no hay filtros específicos, buscar en campos generales
    if (!hasSpecificFilters) {
      const allTerms = [
        ...(entities.position || []),
        ...(entities.company || []),
        ...(entities.keywords || [])
      ];

      if (allTerms.length > 0) {
        const generalFilters = [];
        allTerms.forEach(term => {
          generalFilters.push(
            { full_name: { _icontains: term } },
            { position_title: { _icontains: term } },
            { notes: { _icontains: term } }
          );
        });
        filters.push({ _or: generalFilters });
      }
    }

    // Construir query final
    let queryFilter = {};
    if (filters.length > 0) {
      queryFilter = filters.length === 1 ? filters[0] : { _or: filters };
    }

    try {
      const results = await peopleService.readByQuery({
        filter: queryFilter,
        limit: 50,
        fields: [
          'id',
          'full_name',
          'primary_email',
          'phone_number',
          'position_title',
          'notes'
        ]
      });

      return results || [];

    } catch (error) {
      console.error('Error ejecutando búsqueda:', error);
      throw new Error('Error executing search: ' + error.message);
    }
  }

  // Función para ejecutar búsqueda de empresas
  async function executeEnterpriseSearch(entities, schema, accountability) {
    const enterprisesService = new ItemsService('enterprises', { schema, accountability });
    const industriesService = new ItemsService('industries', { schema, accountability });

    try {
      // Variables para controlar el tipo de búsqueda
      let hasIndustryFilter = false;
      let matchedIndustries = [];

      // 1. Buscar por industria usando la relación
      if (entities.industry && entities.industry.length > 0) {
        // Buscar IDs de industrias que coincidan
        const industryFilters = entities.industry.map(ind => ({
          name: { _icontains: ind }
        }));

        matchedIndustries = await industriesService.readByQuery({
          filter: { _or: industryFilters },
          fields: ['id', 'name']
        });

        if (matchedIndustries && matchedIndustries.length > 0) {
          hasIndustryFilter = true;
          console.log('Industrias encontradas:', matchedIndustries.map(i => ({ id: i.id, name: i.name })));
        }
      }

      let queryFilter = {};

      // Si hay industria, buscar por industria Y keywords adicionales
      if (hasIndustryFilter) {
        const industryOrFilters = matchedIndustries.map(ind => ({
          industries: {
            industries_id: { _eq: ind.id }
          }
        }));

        // Verificar si hay keywords que no son parte del nombre de la industria
        const additionalKeywords = [];
        if (entities.keywords && entities.keywords.length > 0) {
          entities.keywords.forEach(keyword => {
            // Ver si el keyword NO está en ninguna industria encontrada
            const isPartOfIndustry = matchedIndustries.some(ind =>
              ind.name.toLowerCase().includes(keyword.toLowerCase())
            );

            if (!isPartOfIndustry) {
              additionalKeywords.push(keyword);
            }
          });
        }

        // Si hay keywords adicionales, usar OR (buscar por industria O por nombre)
        if (additionalKeywords.length > 0) {
          const keywordFilters = [];

          additionalKeywords.forEach(keyword => {
            const words = keyword.split(/\s+/).filter(w => w.length > 2);

            words.forEach(word => {
              const normalizedWord = removeAccents(word);

              keywordFilters.push(
                { organization_name: { _icontains: word } },
                { commercial_name: { _icontains: word } }
              );

              if (normalizedWord !== word) {
                keywordFilters.push(
                  { organization_name: { _icontains: normalizedWord } },
                  { commercial_name: { _icontains: normalizedWord } }
                );
              }
            });
          });

          // Combinar: (industria correcta) OR (keywords en nombre)
          // Esto permite encontrar tanto empresas de la industria como empresas con ese nombre
          const allFilters = [...industryOrFilters, ...keywordFilters];
          queryFilter = { _or: allFilters };

        } else {
          // Solo industria
          queryFilter = industryOrFilters.length === 1 ? industryOrFilters[0] : { _or: industryOrFilters };
        }

      } else {
        // Si NO hay industria, buscar por keywords, ubicación, etc.
        const orFilters = [];

        // 2. Buscar por keywords en TODOS los campos de texto
        if (entities.keywords && entities.keywords.length > 0) {
          entities.keywords.forEach(keyword => {
            // Saltar keywords genéricos que no aportan valor
            const lowerKeyword = keyword.toLowerCase();
            if (lowerKeyword === 'desconocida' || lowerKeyword === 'desconocido') {
              return;
            }

            // Dividir keywords en palabras individuales para buscar cada una
            const words = keyword.split(/\s+/).filter(w => w.length > 2); // Solo palabras con más de 2 caracteres

            words.forEach(word => {
              // Buscar tanto la palabra original como la versión sin acentos
              const normalizedWord = removeAccents(word);

              orFilters.push(
                { organization_name: { _icontains: word } },
                { commercial_name: { _icontains: word } },
                { fiscal_identification: { _icontains: word } }
              );

              // Si la palabra tiene acentos, buscar también la versión sin acentos
              if (normalizedWord !== word) {
                orFilters.push(
                  { organization_name: { _icontains: normalizedWord } },
                  { commercial_name: { _icontains: normalizedWord } },
                  { fiscal_identification: { _icontains: normalizedWord } }
                );
              }
            });
          });
        }

        // 3. Buscar por ubicación si existe
        if (entities.location && entities.location.length > 0) {
          entities.location.forEach(loc => {
            // Saltar ubicaciones genéricas
            const lowerLoc = loc.toLowerCase();
            if (lowerLoc === 'desconocida' || lowerLoc === 'desconocido') {
              return;
            }

            orFilters.push({ normalized_address: { _icontains: loc } });
          });
        }

        if (orFilters.length > 0) {
          queryFilter = orFilters.length === 1 ? orFilters[0] : { _or: orFilters };
        }
      }

      console.log('Filtro de búsqueda (hasIndustryFilter=' + hasIndustryFilter + '):', JSON.stringify(queryFilter, null, 2));

      // Ejecutar búsqueda
      const results = await enterprisesService.readByQuery({
        filter: queryFilter,
        limit: 200,
        fields: [
          'id',
          'organization_name',
          'commercial_name',
          'fiscal_identification',
          'normalized_address',
          'linkedin',
          'internal_owner',
          'notes',
          'industries.industries_id.id',
          'industries.industries_id.name'
        ]
      });

      console.log('Resultados encontrados:', results ? results.length : 0);

      // Ordenar resultados por relevancia
      if (results && results.length > 0) {
        const sortedResults = results.sort((a, b) => {
          let scoreA = 0;
          let scoreB = 0;

          // Calcular score para empresa A
          const nameA = (a.organization_name || '').toLowerCase();
          const notesA = (a.notes || '').toLowerCase();

          // Calcular score para empresa B
          const nameB = (b.organization_name || '').toLowerCase();
          const notesB = (b.notes || '').toLowerCase();

          // Priorizar empresas con industria que coincida (mayor peso)
          if (entities.industry && entities.industry.length > 0) {
            let industryMatchA = false;
            let industryMatchB = false;

            if (a.industries && Array.isArray(a.industries)) {
              industryMatchA = a.industries.some(ind => {
                if (ind && ind.industries_id && ind.industries_id.name) {
                  const industryName = ind.industries_id.name.toLowerCase();
                  const match = entities.industry.some(searchInd =>
                    industryName.includes(searchInd.toLowerCase())
                  );
                  return match;
                }
                return false;
              });
            }

            if (b.industries && Array.isArray(b.industries)) {
              industryMatchB = b.industries.some(ind => {
                if (ind && ind.industries_id && ind.industries_id.name) {
                  const industryName = ind.industries_id.name.toLowerCase();
                  const match = entities.industry.some(searchInd =>
                    industryName.includes(searchInd.toLowerCase())
                  );
                  return match;
                }
                return false;
              });
            }

            if (industryMatchA) scoreA += 100; // Peso muy alto para industria
            if (industryMatchB) scoreB += 100;
          }

          // Priorizar matches en organization_name
          if (entities.keywords) {
            let keywordMatchesA = 0;
            let keywordMatchesB = 0;

            entities.keywords.forEach(keyword => {
              const words = keyword.split(/\s+/).filter(w => w.length > 2);
              words.forEach(word => {
                const normalizedWord = removeAccents(word.toLowerCase());
                const nameANorm = removeAccents(nameA);
                const nameBNorm = removeAccents(nameB);

                if (nameANorm.includes(normalizedWord)) {
                  scoreA += 10;
                  keywordMatchesA++;
                }
                if (nameBNorm.includes(normalizedWord)) {
                  scoreB += 10;
                  keywordMatchesB++;
                }
                if (notesA.includes(word.toLowerCase())) scoreA += 1;
                if (notesB.includes(word.toLowerCase())) scoreB += 1;
              });
            });

            // Bonus adicional si tiene TODOS los keywords en el nombre (mayor que industria)
            const totalKeywordWords = entities.keywords.reduce((sum, kw) =>
              sum + kw.split(/\s+/).filter(w => w.length > 2).length, 0
            );

            if (keywordMatchesA === totalKeywordWords && totalKeywordWords > 1) scoreA += 200;
            if (keywordMatchesB === totalKeywordWords && totalKeywordWords > 1) scoreB += 200;
          }

          return scoreB - scoreA; // Mayor score primero
        });

        return sortedResults.slice(0, 50);
      }

      return results || [];

    } catch (error) {
      console.error('Error ejecutando búsqueda de empresas:', error);
      throw new Error('Error executing enterprise search: ' + error.message);
    }
  }
};