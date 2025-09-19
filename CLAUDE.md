# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Proyecto

Este es un template de Directus para Railway que incluye PostGIS, extensiones personalizadas, websockets y configuración S3. Es una instalación completa de Directus usando Docker con configuración pre-establecida.

## Comandos de desarrollo

### Desarrollo local
```bash
# Copiar variables de entorno para desarrollo local
cp .env.example .env

# Iniciar servicios con Docker Compose
docker compose up

# Si falla la primera vez, ejecutar de nuevo (problema común de arranque)
docker compose up
```

### Gestión de esquemas
```bash
# Crear snapshot del esquema actual (ejecutar desde directorio scripts)
cd scripts && pnpm create-snapshot

# El comando anterior crea dos archivos:
# - ./snapshots/snapshot.yaml (versión actual)
# - ./snapshots/[fecha]-snapshot-[timestamp].yaml (copia con timestamp)
```

## Arquitectura

### Estructura Docker
- **Dockerfile**: Para producción en Railway, incluye extensiones y configuración
- **Dockerfile.dev**: Para desarrollo local, versión simplificada
- **docker-compose.yml**: Orquestación completa con PostGIS, Redis y Directus

### Servicios
1. **database**: PostGIS (PostgreSQL con extensiones geoespaciales)
2. **cache**: Redis para caché y rate limiting
3. **directus**: Aplicación principal construida desde Dockerfile.dev

### Configuración
- **config.cjs**: Configuración centralizada de Directus con valores por defecto
- **entrypoint.sh**: Script de inicialización que ejecuta bootstrap y aplica migraciones
- **.env.example**: Template de variables de entorno necesarias

### Extensiones incluidas
- directus-extension-computed-interface
- directus-extension-upsert
- directus-extension-wpslug-interface
- directus-extension-flexible-editor
- @directus-labs/simple-list-interface
- @directus-labs/migration-bundle
- directus-extension-sync
- @directus-labs/super-header-interface

### Directorios clave
- `/extensions`: Extensiones personalizadas y descargadas
- `/templates`: Templates de email
- `/migrations`: Migraciones de base de datos
- `/snapshots`: Snapshots del esquema de Directus
- `/uploads`: Archivos subidos (en desarrollo local)

### Almacenamiento
- **Desarrollo**: Volúmenes locales Docker
- **Producción**: S3 configurado a través de variables de entorno

### Variables de entorno críticas
- Credenciales de base de datos (DB_*)
- Configuración S3 (STORAGE_S3_*)
- Autenticación admin (ADMIN_EMAIL, ADMIN_PASSWORD)
- Claves de seguridad (KEY, SECRET)

### Versionado
- Actualmente usando **Directus 11.10**
- Versión se actualiza en ambos Dockerfiles