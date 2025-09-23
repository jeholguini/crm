# Explicitly specify a Directus version to use on Railway
FROM directus/directus:11.12

USER root

# Set the environment variable for your timezone if needed
# RUN apk add --no-cache tzdata
# ENV TZ=America/New_York

RUN npm install -g pnpm --force

USER node

# Copy and build our custom extension first
USER root
COPY ./extensions/people-import /tmp/people-import
RUN chown -R node:node /tmp/people-import
USER node

WORKDIR /tmp/people-import
RUN npm ci && npm run build && npm pack

# Installing contributed/custom extensions through npm on Railway
WORKDIR /directus
RUN pnpm install directus-extension-computed-interface && pnpm install directus-extension-upsert && \
pnpm install directus-extension-wpslug-interface && pnpm install pg && \
pnpm install directus-extension-flexible-editor && pnpm install @directus-labs/simple-list-interface && \
pnpm install @directus-labs/migration-bundle && \
pnpm install directus-extension-sync && \
pnpm install @directus-labs/super-header-interface && \
pnpm install /tmp/people-import/people-import-1.0.0.tgz

# Copying templates, migrations, and config to the Directus container
COPY ./templates /directus/templates
COPY ./migrations /directus/migrations
COPY ./config.cjs /directus/config.cjs

# Migrations and Directus schema update
RUN npx directus bootstrap           

# Custom entrypoint script to run Directus on Railway for migrations, snapshots, and extensions
COPY entrypoint.sh /directus/entrypoint.sh
WORKDIR /directus
USER root
RUN chmod +x ./entrypoint.sh
USER node
ENTRYPOINT ["./entrypoint.sh"]