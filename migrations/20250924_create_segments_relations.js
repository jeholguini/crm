exports.up = async function (knex) {
  // Crear tabla de unión segments_enterprises (many-to-many)
  await knex.schema.createTable('segments_enterprises', (table) => {
    table.increments('id').primary();
    table.integer('segments_id').unsigned().references('id').inTable('segments').onDelete('cascade');
    table.integer('enterprises_id').unsigned().references('id').inTable('enterprises').onDelete('cascade');
    table.timestamp('date_created').defaultTo(knex.fn.now());
    table.uuid('user_created').references('id').inTable('directus_users').onDelete('set null');

    // Índice único para evitar duplicados
    table.unique(['segments_id', 'enterprises_id']);

    // Índices para performance
    table.index('segments_id');
    table.index('enterprises_id');
  });

  // Crear tabla de unión segments_people (many-to-many)
  await knex.schema.createTable('segments_people', (table) => {
    table.increments('id').primary();
    table.integer('segments_id').unsigned().references('id').inTable('segments').onDelete('cascade');
    table.integer('people_id').unsigned().references('id').inTable('people').onDelete('cascade');
    table.timestamp('date_created').defaultTo(knex.fn.now());
    table.uuid('user_created').references('id').inTable('directus_users').onDelete('set null');

    // Índice único para evitar duplicados
    table.unique(['segments_id', 'people_id']);

    // Índices para performance
    table.index('segments_id');
    table.index('people_id');
  });
};

exports.down = async function (knex) {
  await knex.schema.dropTableIfExists('segments_people');
  await knex.schema.dropTableIfExists('segments_enterprises');
};