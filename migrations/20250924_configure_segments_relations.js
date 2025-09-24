exports.up = async function (knex) {
  // Configurar colección segments_enterprises como tabla de unión oculta
  await knex('directus_collections').insert({
    collection: 'segments_enterprises',
    icon: 'import_export',
    note: 'Relación many-to-many entre segmentos y empresas',
    hidden: true,
    singleton: false,
    accountability: 'all',
    sort_field: null
  });

  // Configurar colección segments_people como tabla de unión oculta
  await knex('directus_collections').insert({
    collection: 'segments_people',
    icon: 'import_export',
    note: 'Relación many-to-many entre segmentos y personas',
    hidden: true,
    singleton: false,
    accountability: 'all',
    sort_field: null
  });

  // Crear campos en la tabla segments_enterprises
  await knex('directus_fields').insert([
    {
      collection: 'segments_enterprises',
      field: 'id',
      type: 'integer',
      interface: null,
      options: null,
      display: null,
      display_options: null,
      readonly: true,
      hidden: true,
      sort: 1,
      width: 'full',
      translations: null,
      note: null,
      conditions: null,
      required: false,
      group: null,
      validation: null,
      validation_message: null
    },
    {
      collection: 'segments_enterprises',
      field: 'segments_id',
      type: 'integer',
      interface: null,
      options: null,
      display: null,
      display_options: null,
      readonly: false,
      hidden: true,
      sort: 2,
      width: 'full',
      translations: null,
      note: null,
      conditions: null,
      required: false,
      group: null,
      validation: null,
      validation_message: null
    },
    {
      collection: 'segments_enterprises',
      field: 'enterprises_id',
      type: 'integer',
      interface: null,
      options: null,
      display: null,
      display_options: null,
      readonly: false,
      hidden: true,
      sort: 3,
      width: 'full',
      translations: null,
      note: null,
      conditions: null,
      required: false,
      group: null,
      validation: null,
      validation_message: null
    },
    {
      collection: 'segments_enterprises',
      field: 'date_created',
      type: 'timestamp',
      interface: 'datetime',
      options: null,
      display: 'datetime',
      display_options: '{"relative":true}',
      readonly: true,
      hidden: false,
      sort: 4,
      width: 'half',
      translations: null,
      note: null,
      conditions: null,
      required: false,
      group: null,
      validation: null,
      validation_message: null
    },
    {
      collection: 'segments_enterprises',
      field: 'user_created',
      type: 'uuid',
      interface: 'select-dropdown-m2o',
      options: '{"template":"{{first_name}} {{last_name}}"}',
      display: 'user',
      display_options: null,
      readonly: true,
      hidden: false,
      sort: 5,
      width: 'half',
      translations: null,
      note: null,
      conditions: null,
      required: false,
      group: null,
      validation: null,
      validation_message: null
    }
  ]);

  // Crear campos en la tabla segments_people
  await knex('directus_fields').insert([
    {
      collection: 'segments_people',
      field: 'id',
      type: 'integer',
      interface: null,
      options: null,
      display: null,
      display_options: null,
      readonly: true,
      hidden: true,
      sort: 1,
      width: 'full',
      translations: null,
      note: null,
      conditions: null,
      required: false,
      group: null,
      validation: null,
      validation_message: null
    },
    {
      collection: 'segments_people',
      field: 'segments_id',
      type: 'integer',
      interface: null,
      options: null,
      display: null,
      display_options: null,
      readonly: false,
      hidden: true,
      sort: 2,
      width: 'full',
      translations: null,
      note: null,
      conditions: null,
      required: false,
      group: null,
      validation: null,
      validation_message: null
    },
    {
      collection: 'segments_people',
      field: 'people_id',
      type: 'integer',
      interface: null,
      options: null,
      display: null,
      display_options: null,
      readonly: false,
      hidden: true,
      sort: 3,
      width: 'full',
      translations: null,
      note: null,
      conditions: null,
      required: false,
      group: null,
      validation: null,
      validation_message: null
    },
    {
      collection: 'segments_people',
      field: 'date_created',
      type: 'timestamp',
      interface: 'datetime',
      options: null,
      display: 'datetime',
      display_options: '{"relative":true}',
      readonly: true,
      hidden: false,
      sort: 4,
      width: 'half',
      translations: null,
      note: null,
      conditions: null,
      required: false,
      group: null,
      validation: null,
      validation_message: null
    },
    {
      collection: 'segments_people',
      field: 'user_created',
      type: 'uuid',
      interface: 'select-dropdown-m2o',
      options: '{"template":"{{first_name}} {{last_name}}"}',
      display: 'user',
      display_options: null,
      readonly: true,
      hidden: false,
      sort: 5,
      width: 'half',
      translations: null,
      note: null,
      conditions: null,
      required: false,
      group: null,
      validation: null,
      validation_message: null
    }
  ]);

  // Crear relaciones many-to-many

  // Relación: segments -> enterprises (a través de segments_enterprises)
  await knex('directus_relations').insert([
    {
      many_collection: 'segments_enterprises',
      many_field: 'segments_id',
      one_collection: 'segments',
      one_field: null,
      one_collection_field: null,
      one_allowed_collections: null,
      junction_field: 'enterprises_id',
      sort_field: null,
      one_deselect_action: 'nullify'
    },
    {
      many_collection: 'segments_enterprises',
      many_field: 'enterprises_id',
      one_collection: 'enterprises',
      one_field: null,
      one_collection_field: null,
      one_allowed_collections: null,
      junction_field: 'segments_id',
      sort_field: null,
      one_deselect_action: 'nullify'
    }
  ]);

  // Relación: segments -> people (a través de segments_people)
  await knex('directus_relations').insert([
    {
      many_collection: 'segments_people',
      many_field: 'segments_id',
      one_collection: 'segments',
      one_field: null,
      one_collection_field: null,
      one_allowed_collections: null,
      junction_field: 'people_id',
      sort_field: null,
      one_deselect_action: 'nullify'
    },
    {
      many_collection: 'segments_people',
      many_field: 'people_id',
      one_collection: 'people',
      one_field: null,
      one_collection_field: null,
      one_allowed_collections: null,
      junction_field: 'segments_id',
      sort_field: null,
      one_deselect_action: 'nullify'
    }
  ]);

  // Agregar campos many-to-many a la colección segments
  await knex('directus_fields').insert([
    {
      collection: 'segments',
      field: 'enterprises',
      type: 'alias',
      interface: 'list-m2m',
      options: '{"fields":["enterprises_id.organization_name","enterprises_id.commercial_name","enterprises_id.fiscal_identification"]}',
      display: 'related-values',
      display_options: '{"template":"{{enterprises_id.organization_name}}"}',
      readonly: false,
      hidden: false,
      sort: 10,
      width: 'full',
      translations: null,
      note: 'Empresas asociadas a este segmento',
      conditions: null,
      required: false,
      group: null,
      validation: null,
      validation_message: null,
      special: ['m2m']
    },
    {
      collection: 'segments',
      field: 'people',
      type: 'alias',
      interface: 'list-m2m',
      options: '{"fields":["people_id.full_name","people_id.primary_email","people_id.position_title"]}',
      display: 'related-values',
      display_options: '{"template":"{{people_id.full_name}}"}',
      readonly: false,
      hidden: false,
      sort: 11,
      width: 'full',
      translations: null,
      note: 'Personas asociadas a este segmento',
      conditions: null,
      required: false,
      group: null,
      validation: null,
      validation_message: null,
      special: ['m2m']
    }
  ]);

  // Agregar campos many-to-many a la colección enterprises
  await knex('directus_fields').insert({
    collection: 'enterprises',
    field: 'segments',
    type: 'alias',
    interface: 'list-m2m',
    options: '{"fields":["segments_id.name","segments_id.description"]}',
    display: 'related-values',
    display_options: '{"template":"{{segments_id.name}}"}',
    readonly: false,
    hidden: false,
    sort: 20,
    width: 'full',
    translations: null,
    note: 'Segmentos a los que pertenece esta empresa',
    conditions: null,
    required: false,
    group: null,
    validation: null,
    validation_message: null,
    special: ['m2m']
  });

  // Agregar campo many-to-many a la colección people
  await knex('directus_fields').insert({
    collection: 'people',
    field: 'segments',
    type: 'alias',
    interface: 'list-m2m',
    options: '{"fields":["segments_id.name","segments_id.description"]}',
    display: 'related-values',
    display_options: '{"template":"{{segments_id.name}}"}',
    readonly: false,
    hidden: false,
    sort: 20,
    width: 'full',
    translations: null,
    note: 'Segmentos a los que pertenece esta persona',
    conditions: null,
    required: false,
    group: null,
    validation: null,
    validation_message: null,
    special: ['m2m']
  });
};

exports.down = async function (knex) {
  // Eliminar campos de relaciones many-to-many
  await knex('directus_fields').where('collection', 'segments').andWhere('field', 'enterprises').del();
  await knex('directus_fields').where('collection', 'segments').andWhere('field', 'people').del();
  await knex('directus_fields').where('collection', 'enterprises').andWhere('field', 'segments').del();
  await knex('directus_fields').where('collection', 'people').andWhere('field', 'segments').del();

  // Eliminar relaciones
  await knex('directus_relations').where('many_collection', 'segments_enterprises').del();
  await knex('directus_relations').where('many_collection', 'segments_people').del();

  // Eliminar campos de las tablas de unión
  await knex('directus_fields').where('collection', 'segments_enterprises').del();
  await knex('directus_fields').where('collection', 'segments_people').del();

  // Eliminar configuración de colecciones
  await knex('directus_collections').where('collection', 'segments_enterprises').del();
  await knex('directus_collections').where('collection', 'segments_people').del();
};