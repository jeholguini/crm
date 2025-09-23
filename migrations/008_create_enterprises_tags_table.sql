-- Crear tabla de relación M2M para enterprises y enterprise_tags
-- Fecha: 2025-09-23

-- 1. Crear tabla enterprises_tags para relación M2M
CREATE TABLE IF NOT EXISTS enterprises_tags (
    id SERIAL PRIMARY KEY,
    enterprises_id INTEGER,
    tag_id INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Agregar constrainst únicos
ALTER TABLE enterprises_tags
ADD CONSTRAINT enterprises_tags_enterprises_id_tag_id_key
UNIQUE (enterprises_id, tag_id);

-- 3. Agregar foreign keys
ALTER TABLE enterprises_tags
ADD CONSTRAINT enterprises_tags_enterprises_id_fkey
FOREIGN KEY (enterprises_id) REFERENCES enterprises(id) ON DELETE CASCADE;

ALTER TABLE enterprises_tags
ADD CONSTRAINT enterprises_tags_tag_id_fkey
FOREIGN KEY (tag_id) REFERENCES enterprise_tags(id) ON DELETE CASCADE;

-- 4. Crear índices para mejorar performance
CREATE INDEX IF NOT EXISTS idx_enterprises_tags_enterprises_id ON enterprises_tags(enterprises_id);
CREATE INDEX IF NOT EXISTS idx_enterprises_tags_tag_id ON enterprises_tags(tag_id);

-- 5. Comentario para documentar
COMMENT ON TABLE enterprises_tags IS 'Tabla de relación M2M entre enterprises y enterprise_tags';
COMMENT ON COLUMN enterprises_tags.enterprises_id IS 'ID de la empresa';
COMMENT ON COLUMN enterprises_tags.tag_id IS 'ID del tag/etiqueta';