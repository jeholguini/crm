# Extensión Enterprise Upsert

Extensión de Directus para crear o actualizar empresas mediante JSON.

## Descripción

Esta extensión proporciona un endpoint que permite crear o actualizar empresas en la colección `enterprises` de Directus, aceptando un formato JSON específico con mapeo automático de campos.

## Endpoints

### `GET /enterprise-upsert/test`

Endpoint de prueba para verificar que la extensión está funcionando.

**Respuesta:**
```json
{
  "success": true,
  "message": "Extensión de upsert de empresas funcionando",
  "timestamp": "2025-10-08T04:51:44.134Z",
  "routes": [
    "GET /test - Prueba de conectividad",
    "POST /upsert - Crear o actualizar empresas desde JSON"
  ]
}
```

### `POST /enterprise-upsert/upsert`

Endpoint principal para crear o actualizar empresas.

**Autenticación:** Requiere token de Directus en header `Authorization: Bearer <token>`

**Content-Type:** `application/json`

**Body:** Array de objetos con el siguiente formato:

```json
[
  {
    "Nombre de la organización": "REALRESULTS, S.L.",
    "Nombre comercial / marca": "Increnta",
    "LinkedIn": "https://www.linkedin.com/company/increnta-marketing-digital-y-ventas/",
    "Tipo de identificación fiscal": "CIF",
    "Identificación fiscal": "B98925548",
    "Sector / industria": "Marketing y publicidad",
    "Tamaño de la empresa (rango empleados)": "51–250",
    "País": "España",
    "Direccion": {
      "direccion_formateada": "Calle Nicolás Copérnico, 8, 1º Oficina 12, 46980 Paterna, Valencia, España"
    },
    "Sitio web": "https://increnta.com",
    "Teléfono – prefijo": "+34",
    "Teléfono – número": "961822972",
    "Fuente de adquisición": "LTB IA",
    "Propietario interno": "LTB IA",
    "Notas": "Agencia española de marketing digital.",
    "Etiquetas / tags": ["marketing digital", "consultoría", "ventas", "B2B"]
  }
]
```

**Respuesta exitosa:**
```json
{
  "success": true,
  "message": "Procesadas 1 empresas de 1 total.",
  "data": {
    "processed": 1,
    "successful": 1,
    "errors": 0,
    "results": [
      {
        "index": 0,
        "organization_name": "REALRESULTS, S.L.",
        "action": "created",
        "id": 52026
      }
    ],
    "errorDetails": []
  }
}
```

## Mapeo de Campos

| Campo JSON | Campo Directus | Notas |
|------------|----------------|-------|
| Nombre de la organización | `organization_name` | **Requerido para crear**. Opcional para actualizar si se proporciona ID fiscal |
| Nombre comercial / marca | `commercial_name` | |
| LinkedIn | `linkedin` | |
| Tipo de identificación fiscal | `fiscal_identification_type` | Se mapea a valores permitidos (NIT, RUT, CIF→OTHER, etc.) |
| Identificación fiscal | `fiscal_identification` | Se usa para buscar empresas existentes |
| Sector / industria | `industries` (M2M) | Crea la industria si no existe |
| Tamaño de la empresa (rango empleados) | `company_size` | Se mapea a rangos permitidos (51-250→51-200) |
| País | `country` | Se mapea a códigos ISO-3166 (España→ESP) |
| Direccion | `normalized_address` | **Guarda el objeto JSON completo como string** |
| Sitio web | `website` | |
| Teléfono – prefijo | `phone_prefix` | |
| Teléfono – número | `phone_number` | |
| Fuente de adquisición | `acquisition_source` | Se mapea a valores permitidos (LTB IA→other) |
| Propietario interno | `internal_owner` | |
| Notas | `notes` | |
| Etiquetas / tags | `tags` (M2M) | Array. Crea tags si no existen |

## Lógica de Upsert

1. **Validación inicial**: Se requiere al menos `Nombre de la organización` O `Identificación fiscal`
2. **Búsqueda por identificación fiscal**: Si se proporciona `Identificación fiscal`, busca primero por este campo
3. **Búsqueda por nombre**: Si no se encuentra por fiscal ID, busca por `Nombre de la organización`
4. **Actualización**: Si encuentra una empresa existente:
   - Actualiza **solo los campos proporcionados** en el JSON
   - Los campos no incluidos en el JSON **se mantienen sin cambios**
   - No requiere `Nombre de la organización` si se proporciona `Identificación fiscal`
5. **Creación**: Si no encuentra coincidencias:
   - Crea una nueva empresa
   - Requiere obligatoriamente `Nombre de la organización`
6. **Relaciones M2M**: Para industrias y tags:
   - Busca si ya existen
   - Crea si no existen
   - Vincula a la empresa (evita duplicados)
7. **Campo Dirección**: Se guarda el objeto JSON completo como string en `normalized_address`

## Ejemplo de Uso

### Con curl

**Crear o actualizar empresa completa:**
```bash
curl -X POST "http://localhost:8055/enterprise-upsert/upsert" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '[
    {
      "Nombre de la organización": "Mi Empresa SL",
      "Nombre comercial / marca": "MiEmpresa",
      "Identificación fiscal": "B12345678",
      "País": "España",
      "Etiquetas / tags": ["tecnología", "innovación"]
    }
  ]'
```

**Actualizar solo algunos campos (solo requiere ID fiscal):**
```bash
curl -X POST "http://localhost:8055/enterprise-upsert/upsert" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '[
    {
      "Identificación fiscal": "B12345678",
      "Notas": "Empresa actualizada",
      "Nombre comercial / marca": "MiEmpresa Actualizada"
    }
  ]'
```

### Con JavaScript

```javascript
const response = await fetch('http://localhost:8055/enterprise-upsert/upsert', {
  method: 'POST',
  headers: {
    'Authorization': 'Bearer YOUR_TOKEN',
    'Content-Type': 'application/json'
  },
  body: JSON.stringify([
    {
      "Nombre de la organización": "Mi Empresa SL",
      "Nombre comercial / marca": "MiEmpresa",
      "Identificación fiscal": "B12345678",
      "País": "España",
      "Etiquetas / tags": ["tecnología", "innovación"]
    }
  ])
});

const result = await response.json();
console.log(result);
```

## Desarrollo

### Compilar la extensión

```bash
cd extensions/enterprise-upsert
npm install
npm run build
```

### Modo watch (desarrollo)

```bash
npm run dev
```

### Reiniciar Directus para cargar cambios

```bash
docker compose restart directus
```

## Manejo de Errores

La extensión devuelve errores detallados en el array `errorDetails`:

```json
{
  "success": true,
  "message": "Procesadas 0 empresas de 1 total.",
  "data": {
    "processed": 1,
    "successful": 0,
    "errors": 1,
    "results": [],
    "errorDetails": [
      {
        "index": 0,
        "error": "Nombre de la organización es requerido"
      }
    ]
  }
}
```

## Notas Técnicas

- La extensión usa `ItemsService` de Directus para todas las operaciones
- Soporta autenticación y permisos de Directus
- Las relaciones M2M se crean de forma segura evitando duplicados
- Los mapeos de valores se ajustan automáticamente a los valores permitidos en Directus
- El objeto `Direccion` se puede pasar como string o como objeto con `direccion_formateada`
