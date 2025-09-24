const axios = require('axios');

// Intentar cargar configuración, si no existe usar variable de entorno
let config = {};
try {
  config = require('../config.js');
} catch (e) {
  config = {};
}

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

  // Función para analizar consulta con OpenAI
  async function analyzeWithOpenAI(query, searchType = 'people') {
    const openaiApiKey = config.OPENAI_API_KEY || process.env.OPENAI_API_KEY;

    if (!openaiApiKey) {
      throw new Error('OPENAI_API_KEY not found in config.js or environment variables');
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

    try {
      // Primero obtener todas las empresas con sus industries
      const allEnterprises = await enterprisesService.readByQuery({
        limit: 1000,
        fields: [
          'id',
          'organization_name',
          'commercial_name',
          'fiscal_identification',
          'normalized_address',
          'internal_owner',
          'notes',
          'industries'
        ]
      });

      if (!allEnterprises || allEnterprises.length === 0) {
        return [];
      }

      // Filtrar en JavaScript usando las entidades extraídas
      const filteredResults = allEnterprises.filter(enterprise => {
        let matches = false;

        // Buscar por industria
        if (entities.industry && entities.industry.length > 0) {
          for (const industry of entities.industry) {
            if (enterprise.notes && enterprise.notes.toLowerCase().includes(industry.toLowerCase())) {
              matches = true;
              break;
            }
            if (enterprise.organization_name && enterprise.organization_name.toLowerCase().includes(industry.toLowerCase())) {
              matches = true;
              break;
            }
            // Si la empresa tiene industrias con ID 9 (que sabemos es tecnología)
            if (enterprise.industries && enterprise.industries.includes(9) && industry.toLowerCase().includes('tecnolog')) {
              matches = true;
              break;
            }
          }
        }

        // Buscar por keywords
        if (!matches && entities.keywords && entities.keywords.length > 0) {
          for (const keyword of entities.keywords) {
            if (enterprise.organization_name && enterprise.organization_name.toLowerCase().includes(keyword.toLowerCase())) {
              matches = true;
              break;
            }
            if (enterprise.commercial_name && enterprise.commercial_name.toLowerCase().includes(keyword.toLowerCase())) {
              matches = true;
              break;
            }
            if (enterprise.notes && enterprise.notes.toLowerCase().includes(keyword.toLowerCase())) {
              matches = true;
              break;
            }
          }
        }

        // Si no hay filtros específicos, buscar en todos los campos
        if (!matches && (!entities.industry || entities.industry.length === 0) && (!entities.keywords || entities.keywords.length === 0)) {
          const allTerms = [
            ...(entities.industry || []),
            ...(entities.keywords || []),
            ...(entities.segment || [])
          ];

          for (const term of allTerms) {
            if (enterprise.organization_name && enterprise.organization_name.toLowerCase().includes(term.toLowerCase())) {
              matches = true;
              break;
            }
            if (enterprise.notes && enterprise.notes.toLowerCase().includes(term.toLowerCase())) {
              matches = true;
              break;
            }
          }
        }

        return matches;
      });

      return filteredResults.slice(0, 50); // Limitar a 50 resultados

    } catch (error) {
      console.error('Error ejecutando búsqueda de empresas:', error);
      throw new Error('Error executing enterprise search: ' + error.message);
    }
  }
};