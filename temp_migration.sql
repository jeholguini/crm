-- Crear tabla enterprises_tags para producción
CREATE TABLE IF NOT EXISTS enterprises_tags (
    id SERIAL PRIMARY KEY,
    enterprises_id INTEGER,
    tag_id INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Agregar constrainst únicos (solo si no existe)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'enterprises_tags_enterprises_id_tag_id_key'
    ) THEN
        ALTER TABLE enterprises_tags
        ADD CONSTRAINT enterprises_tags_enterprises_id_tag_id_key
        UNIQUE (enterprises_id, tag_id);
    END IF;
END $$;

-- Agregar foreign keys (solo si no existen)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'enterprises_tags_enterprises_id_fkey'
    ) THEN
        ALTER TABLE enterprises_tags
        ADD CONSTRAINT enterprises_tags_enterprises_id_fkey
        FOREIGN KEY (enterprises_id) REFERENCES enterprises(id) ON DELETE CASCADE;
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'enterprises_tags_tag_id_fkey'
    ) THEN
        ALTER TABLE enterprises_tags
        ADD CONSTRAINT enterprises_tags_tag_id_fkey
        FOREIGN KEY (tag_id) REFERENCES enterprise_tags(id) ON DELETE CASCADE;
    END IF;
END $$;

-- Crear índices (solo si no existen)
CREATE INDEX IF NOT EXISTS idx_enterprises_tags_enterprises_id ON enterprises_tags(enterprises_id);
CREATE INDEX IF NOT EXISTS idx_enterprises_tags_tag_id ON enterprises_tags(tag_id);