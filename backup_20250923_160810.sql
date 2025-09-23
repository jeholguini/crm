--
-- PostgreSQL database dump
--

-- Dumped from database version 13.8 (Debian 13.8-1.pgdg110+1)
-- Dumped by pg_dump version 13.8 (Debian 13.8-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.segments DROP CONSTRAINT IF EXISTS segments_industry_id_foreign;
ALTER TABLE IF EXISTS ONLY public.person_employment_history DROP CONSTRAINT IF EXISTS person_employment_history_position_id_foreign;
ALTER TABLE IF EXISTS ONLY public.person_employment_history DROP CONSTRAINT IF EXISTS person_employment_history_person_id_foreign;
ALTER TABLE IF EXISTS ONLY public.person_employment_history DROP CONSTRAINT IF EXISTS person_employment_history_enterprise_id_foreign;
ALTER TABLE IF EXISTS ONLY public.people_technologies DROP CONSTRAINT IF EXISTS people_technologies_technologies_id_foreign;
ALTER TABLE IF EXISTS ONLY public.people_technologies DROP CONSTRAINT IF EXISTS people_technologies_people_id_foreign;
ALTER TABLE IF EXISTS ONLY public.people_tags DROP CONSTRAINT IF EXISTS people_tags_tag_id_fkey;
ALTER TABLE IF EXISTS ONLY public.people_tags DROP CONSTRAINT IF EXISTS people_tags_person_id_fkey;
ALTER TABLE IF EXISTS ONLY public.people_keywords DROP CONSTRAINT IF EXISTS people_keywords_people_id_foreign;
ALTER TABLE IF EXISTS ONLY public.people_keywords DROP CONSTRAINT IF EXISTS people_keywords_keywords_id_foreign;
ALTER TABLE IF EXISTS ONLY public.people DROP CONSTRAINT IF EXISTS fk_people_enterprise_relation;
ALTER TABLE IF EXISTS ONLY public.enterprises_technologies DROP CONSTRAINT IF EXISTS enterprises_technologies_technologies_id_foreign;
ALTER TABLE IF EXISTS ONLY public.enterprises_technologies DROP CONSTRAINT IF EXISTS enterprises_technologies_enterprises_id_foreign;
ALTER TABLE IF EXISTS ONLY public.enterprises_tags DROP CONSTRAINT IF EXISTS enterprises_tags_tag_id_fkey;
ALTER TABLE IF EXISTS ONLY public.enterprises_tags DROP CONSTRAINT IF EXISTS enterprises_tags_enterprise_id_fkey;
ALTER TABLE IF EXISTS ONLY public.enterprises_locations DROP CONSTRAINT IF EXISTS enterprises_locations_locations_id_foreign;
ALTER TABLE IF EXISTS ONLY public.enterprises_locations DROP CONSTRAINT IF EXISTS enterprises_locations_enterprises_id_foreign;
ALTER TABLE IF EXISTS ONLY public.enterprises_keywords DROP CONSTRAINT IF EXISTS enterprises_keywords_keywords_id_foreign;
ALTER TABLE IF EXISTS ONLY public.enterprises_keywords DROP CONSTRAINT IF EXISTS enterprises_keywords_enterprises_id_foreign;
ALTER TABLE IF EXISTS ONLY public.enterprises_industries DROP CONSTRAINT IF EXISTS enterprises_industries_industries_id_foreign;
ALTER TABLE IF EXISTS ONLY public.enterprises_industries DROP CONSTRAINT IF EXISTS enterprises_industries_enterprises_id_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_webhooks DROP CONSTRAINT IF EXISTS directus_webhooks_migrated_flow_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_versions DROP CONSTRAINT IF EXISTS directus_versions_user_updated_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_versions DROP CONSTRAINT IF EXISTS directus_versions_user_created_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_versions DROP CONSTRAINT IF EXISTS directus_versions_collection_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_users DROP CONSTRAINT IF EXISTS directus_users_role_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_shares DROP CONSTRAINT IF EXISTS directus_shares_user_created_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_shares DROP CONSTRAINT IF EXISTS directus_shares_role_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_shares DROP CONSTRAINT IF EXISTS directus_shares_collection_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_settings DROP CONSTRAINT IF EXISTS directus_settings_storage_default_folder_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_settings DROP CONSTRAINT IF EXISTS directus_settings_public_registration_role_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_settings DROP CONSTRAINT IF EXISTS directus_settings_public_foreground_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_settings DROP CONSTRAINT IF EXISTS directus_settings_public_favicon_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_settings DROP CONSTRAINT IF EXISTS directus_settings_public_background_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_settings DROP CONSTRAINT IF EXISTS directus_settings_project_logo_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_sessions DROP CONSTRAINT IF EXISTS directus_sessions_user_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_sessions DROP CONSTRAINT IF EXISTS directus_sessions_share_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_roles DROP CONSTRAINT IF EXISTS directus_roles_parent_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_revisions DROP CONSTRAINT IF EXISTS directus_revisions_version_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_revisions DROP CONSTRAINT IF EXISTS directus_revisions_parent_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_revisions DROP CONSTRAINT IF EXISTS directus_revisions_activity_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_presets DROP CONSTRAINT IF EXISTS directus_presets_user_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_presets DROP CONSTRAINT IF EXISTS directus_presets_role_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_permissions DROP CONSTRAINT IF EXISTS directus_permissions_policy_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_panels DROP CONSTRAINT IF EXISTS directus_panels_user_created_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_panels DROP CONSTRAINT IF EXISTS directus_panels_dashboard_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_operations DROP CONSTRAINT IF EXISTS directus_operations_user_created_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_operations DROP CONSTRAINT IF EXISTS directus_operations_resolve_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_operations DROP CONSTRAINT IF EXISTS directus_operations_reject_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_operations DROP CONSTRAINT IF EXISTS directus_operations_flow_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_notifications DROP CONSTRAINT IF EXISTS directus_notifications_sender_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_notifications DROP CONSTRAINT IF EXISTS directus_notifications_recipient_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_folders DROP CONSTRAINT IF EXISTS directus_folders_parent_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_flows DROP CONSTRAINT IF EXISTS directus_flows_user_created_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_files DROP CONSTRAINT IF EXISTS directus_files_uploaded_by_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_files DROP CONSTRAINT IF EXISTS directus_files_modified_by_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_files DROP CONSTRAINT IF EXISTS directus_files_folder_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_dashboards DROP CONSTRAINT IF EXISTS directus_dashboards_user_created_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_comments DROP CONSTRAINT IF EXISTS directus_comments_user_updated_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_comments DROP CONSTRAINT IF EXISTS directus_comments_user_created_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_collections DROP CONSTRAINT IF EXISTS directus_collections_group_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_access DROP CONSTRAINT IF EXISTS directus_access_user_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_access DROP CONSTRAINT IF EXISTS directus_access_role_foreign;
ALTER TABLE IF EXISTS ONLY public.directus_access DROP CONSTRAINT IF EXISTS directus_access_policy_foreign;
DROP INDEX IF EXISTS public.idx_people_primary_email;
DROP INDEX IF EXISTS public.idx_people_full_name;
DROP INDEX IF EXISTS public.idx_people_enterprise_relation;
DROP INDEX IF EXISTS public.idx_people_department;
DROP INDEX IF EXISTS public.idx_enterprises_fiscal_identification;
DROP INDEX IF EXISTS public.idx_enterprises_country;
DROP INDEX IF EXISTS public.idx_enterprises_company_size;
DROP INDEX IF EXISTS public.idx_enterprise_tags_name;
DROP INDEX IF EXISTS public.directus_sync_id_map_created_at_index;
ALTER TABLE IF EXISTS ONLY public.technologies DROP CONSTRAINT IF EXISTS technologies_pkey;
ALTER TABLE IF EXISTS ONLY public.segments DROP CONSTRAINT IF EXISTS segments_pkey;
ALTER TABLE IF EXISTS ONLY public.positions DROP CONSTRAINT IF EXISTS positions_pkey;
ALTER TABLE IF EXISTS ONLY public.person_employment_history DROP CONSTRAINT IF EXISTS person_employment_history_pkey;
ALTER TABLE IF EXISTS ONLY public.people_technologies DROP CONSTRAINT IF EXISTS people_technologies_pkey;
ALTER TABLE IF EXISTS ONLY public.people_tags DROP CONSTRAINT IF EXISTS people_tags_pkey;
ALTER TABLE IF EXISTS ONLY public.people_tags DROP CONSTRAINT IF EXISTS people_tags_person_id_tag_id_key;
ALTER TABLE IF EXISTS ONLY public.people DROP CONSTRAINT IF EXISTS people_pkey;
ALTER TABLE IF EXISTS ONLY public.people_keywords DROP CONSTRAINT IF EXISTS people_keywords_pkey;
ALTER TABLE IF EXISTS ONLY public.locations DROP CONSTRAINT IF EXISTS locations_pkey;
ALTER TABLE IF EXISTS ONLY public.keywords DROP CONSTRAINT IF EXISTS keywords_pkey;
ALTER TABLE IF EXISTS ONLY public.industries DROP CONSTRAINT IF EXISTS industries_pkey;
ALTER TABLE IF EXISTS ONLY public.enterprises_technologies DROP CONSTRAINT IF EXISTS enterprises_technologies_pkey;
ALTER TABLE IF EXISTS ONLY public.enterprises_tags DROP CONSTRAINT IF EXISTS enterprises_tags_pkey;
ALTER TABLE IF EXISTS ONLY public.enterprises_tags DROP CONSTRAINT IF EXISTS enterprises_tags_enterprise_id_tag_id_key;
ALTER TABLE IF EXISTS ONLY public.enterprises DROP CONSTRAINT IF EXISTS enterprises_pkey;
ALTER TABLE IF EXISTS ONLY public.enterprises_locations DROP CONSTRAINT IF EXISTS enterprises_locations_pkey;
ALTER TABLE IF EXISTS ONLY public.enterprises_keywords DROP CONSTRAINT IF EXISTS enterprises_keywords_pkey;
ALTER TABLE IF EXISTS ONLY public.enterprises_industries DROP CONSTRAINT IF EXISTS enterprises_industries_pkey;
ALTER TABLE IF EXISTS ONLY public.enterprise_tags DROP CONSTRAINT IF EXISTS enterprise_tags_pkey;
ALTER TABLE IF EXISTS ONLY public.enterprise_tags DROP CONSTRAINT IF EXISTS enterprise_tags_name_key;
ALTER TABLE IF EXISTS ONLY public.directus_webhooks DROP CONSTRAINT IF EXISTS directus_webhooks_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_versions DROP CONSTRAINT IF EXISTS directus_versions_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_users DROP CONSTRAINT IF EXISTS directus_users_token_unique;
ALTER TABLE IF EXISTS ONLY public.directus_users DROP CONSTRAINT IF EXISTS directus_users_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_users DROP CONSTRAINT IF EXISTS directus_users_external_identifier_unique;
ALTER TABLE IF EXISTS ONLY public.directus_users DROP CONSTRAINT IF EXISTS directus_users_email_unique;
ALTER TABLE IF EXISTS ONLY public.directus_translations DROP CONSTRAINT IF EXISTS directus_translations_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_sync_id_map DROP CONSTRAINT IF EXISTS directus_sync_id_map_table_sync_id_unique;
ALTER TABLE IF EXISTS ONLY public.directus_sync_id_map DROP CONSTRAINT IF EXISTS directus_sync_id_map_table_local_id_unique;
ALTER TABLE IF EXISTS ONLY public.directus_sync_id_map DROP CONSTRAINT IF EXISTS directus_sync_id_map_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_shares DROP CONSTRAINT IF EXISTS directus_shares_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_settings DROP CONSTRAINT IF EXISTS directus_settings_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_sessions DROP CONSTRAINT IF EXISTS directus_sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_roles DROP CONSTRAINT IF EXISTS directus_roles_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_revisions DROP CONSTRAINT IF EXISTS directus_revisions_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_relations DROP CONSTRAINT IF EXISTS directus_relations_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_presets DROP CONSTRAINT IF EXISTS directus_presets_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_policies DROP CONSTRAINT IF EXISTS directus_policies_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_permissions DROP CONSTRAINT IF EXISTS directus_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_panels DROP CONSTRAINT IF EXISTS directus_panels_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_operations DROP CONSTRAINT IF EXISTS directus_operations_resolve_unique;
ALTER TABLE IF EXISTS ONLY public.directus_operations DROP CONSTRAINT IF EXISTS directus_operations_reject_unique;
ALTER TABLE IF EXISTS ONLY public.directus_operations DROP CONSTRAINT IF EXISTS directus_operations_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_notifications DROP CONSTRAINT IF EXISTS directus_notifications_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_migrations DROP CONSTRAINT IF EXISTS directus_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_folders DROP CONSTRAINT IF EXISTS directus_folders_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_flows DROP CONSTRAINT IF EXISTS directus_flows_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_flows DROP CONSTRAINT IF EXISTS directus_flows_operation_unique;
ALTER TABLE IF EXISTS ONLY public.directus_files DROP CONSTRAINT IF EXISTS directus_files_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_fields DROP CONSTRAINT IF EXISTS directus_fields_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_extensions DROP CONSTRAINT IF EXISTS directus_extensions_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_dashboards DROP CONSTRAINT IF EXISTS directus_dashboards_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_comments DROP CONSTRAINT IF EXISTS directus_comments_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_collections DROP CONSTRAINT IF EXISTS directus_collections_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_activity DROP CONSTRAINT IF EXISTS directus_activity_pkey;
ALTER TABLE IF EXISTS ONLY public.directus_access DROP CONSTRAINT IF EXISTS directus_access_pkey;
ALTER TABLE IF EXISTS public.technologies ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.segments ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.positions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.person_employment_history ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.people_technologies ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.people_tags ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.people_keywords ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.people ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.locations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.keywords ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.industries ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.enterprises_technologies ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.enterprises_tags ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.enterprises_locations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.enterprises_keywords ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.enterprises_industries ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.enterprises ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.enterprise_tags ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_webhooks ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_sync_id_map ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_settings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_revisions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_relations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_presets ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_permissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_notifications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_fields ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.directus_activity ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.technologies_id_seq;
DROP TABLE IF EXISTS public.technologies;
DROP SEQUENCE IF EXISTS public.segments_id_seq;
DROP TABLE IF EXISTS public.segments;
DROP SEQUENCE IF EXISTS public.positions_id_seq;
DROP TABLE IF EXISTS public.positions;
DROP SEQUENCE IF EXISTS public.person_employment_history_id_seq;
DROP TABLE IF EXISTS public.person_employment_history;
DROP SEQUENCE IF EXISTS public.people_technologies_id_seq;
DROP TABLE IF EXISTS public.people_technologies;
DROP SEQUENCE IF EXISTS public.people_tags_id_seq;
DROP TABLE IF EXISTS public.people_tags;
DROP SEQUENCE IF EXISTS public.people_keywords_id_seq;
DROP TABLE IF EXISTS public.people_keywords;
DROP SEQUENCE IF EXISTS public.people_id_seq;
DROP TABLE IF EXISTS public.people;
DROP SEQUENCE IF EXISTS public.locations_id_seq;
DROP TABLE IF EXISTS public.locations;
DROP SEQUENCE IF EXISTS public.keywords_id_seq;
DROP TABLE IF EXISTS public.keywords;
DROP SEQUENCE IF EXISTS public.industries_id_seq;
DROP TABLE IF EXISTS public.industries;
DROP SEQUENCE IF EXISTS public.enterprises_technologies_id_seq;
DROP TABLE IF EXISTS public.enterprises_technologies;
DROP SEQUENCE IF EXISTS public.enterprises_tags_id_seq;
DROP TABLE IF EXISTS public.enterprises_tags;
DROP SEQUENCE IF EXISTS public.enterprises_locations_id_seq;
DROP TABLE IF EXISTS public.enterprises_locations;
DROP SEQUENCE IF EXISTS public.enterprises_keywords_id_seq;
DROP TABLE IF EXISTS public.enterprises_keywords;
DROP SEQUENCE IF EXISTS public.enterprises_industries_id_seq;
DROP TABLE IF EXISTS public.enterprises_industries;
DROP SEQUENCE IF EXISTS public.enterprises_id_seq;
DROP TABLE IF EXISTS public.enterprises;
DROP SEQUENCE IF EXISTS public.enterprise_tags_id_seq;
DROP TABLE IF EXISTS public.enterprise_tags;
DROP SEQUENCE IF EXISTS public.directus_webhooks_id_seq;
DROP TABLE IF EXISTS public.directus_webhooks;
DROP TABLE IF EXISTS public.directus_versions;
DROP TABLE IF EXISTS public.directus_users;
DROP TABLE IF EXISTS public.directus_translations;
DROP SEQUENCE IF EXISTS public.directus_sync_id_map_id_seq;
DROP TABLE IF EXISTS public.directus_sync_id_map;
DROP TABLE IF EXISTS public.directus_shares;
DROP SEQUENCE IF EXISTS public.directus_settings_id_seq;
DROP TABLE IF EXISTS public.directus_settings;
DROP TABLE IF EXISTS public.directus_sessions;
DROP TABLE IF EXISTS public.directus_roles;
DROP SEQUENCE IF EXISTS public.directus_revisions_id_seq;
DROP TABLE IF EXISTS public.directus_revisions;
DROP SEQUENCE IF EXISTS public.directus_relations_id_seq;
DROP TABLE IF EXISTS public.directus_relations;
DROP SEQUENCE IF EXISTS public.directus_presets_id_seq;
DROP TABLE IF EXISTS public.directus_presets;
DROP TABLE IF EXISTS public.directus_policies;
DROP SEQUENCE IF EXISTS public.directus_permissions_id_seq;
DROP TABLE IF EXISTS public.directus_permissions;
DROP TABLE IF EXISTS public.directus_panels;
DROP TABLE IF EXISTS public.directus_operations;
DROP SEQUENCE IF EXISTS public.directus_notifications_id_seq;
DROP TABLE IF EXISTS public.directus_notifications;
DROP TABLE IF EXISTS public.directus_migrations;
DROP TABLE IF EXISTS public.directus_folders;
DROP TABLE IF EXISTS public.directus_flows;
DROP TABLE IF EXISTS public.directus_files;
DROP SEQUENCE IF EXISTS public.directus_fields_id_seq;
DROP TABLE IF EXISTS public.directus_fields;
DROP TABLE IF EXISTS public.directus_extensions;
DROP TABLE IF EXISTS public.directus_dashboards;
DROP TABLE IF EXISTS public.directus_comments;
DROP TABLE IF EXISTS public.directus_collections;
DROP SEQUENCE IF EXISTS public.directus_activity_id_seq;
DROP TABLE IF EXISTS public.directus_activity;
DROP TABLE IF EXISTS public.directus_access;
DROP EXTENSION IF EXISTS postgis_topology;
DROP EXTENSION IF EXISTS postgis_tiger_geocoder;
DROP EXTENSION IF EXISTS postgis;
DROP EXTENSION IF EXISTS fuzzystrmatch;
DROP SCHEMA IF EXISTS topology;
DROP SCHEMA IF EXISTS tiger_data;
DROP SCHEMA IF EXISTS tiger;
--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA tiger;


--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA tiger_data;


--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA topology;


--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: directus_access; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_access (
    id uuid NOT NULL,
    role uuid,
    "user" uuid,
    policy uuid NOT NULL,
    sort integer
);


--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    origin character varying(255)
);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(64),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL
);


--
-- Name: directus_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_comments (
    id uuid NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id uuid NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle uuid
);


--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json,
    focal_point_x integer,
    focal_point_y integer,
    tus_id character varying(64),
    tus_data json,
    uploaded_on timestamp with time zone
);


--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    policy uuid NOT NULL
);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_policies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_policies (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT false NOT NULL
);


--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(64) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    parent uuid
);


--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent text,
    share uuid,
    origin character varying(255),
    next_token character varying(64)
);


--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json,
    report_error_url character varying(255),
    report_bug_url character varying(255),
    report_feature_url character varying(255),
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role uuid,
    public_registration_email_filter json,
    visual_editor_urls json,
    accepted_terms boolean DEFAULT false,
    project_id uuid,
    mcp_enabled boolean DEFAULT false NOT NULL,
    mcp_allow_deletes boolean DEFAULT false NOT NULL,
    mcp_prompts_collection character varying(255) DEFAULT NULL::character varying,
    mcp_system_prompt_enabled boolean DEFAULT true NOT NULL,
    mcp_system_prompt text
);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


--
-- Name: directus_sync_id_map; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_sync_id_map (
    id integer NOT NULL,
    "table" character varying(255) NOT NULL,
    sync_id character varying(255) NOT NULL,
    local_id character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: directus_sync_id_map_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_sync_id_map_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_sync_id_map_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_sync_id_map_id_seq OWNED BY public.directus_sync_id_map.id;


--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json,
    text_direction character varying(255) DEFAULT 'auto'::character varying NOT NULL
);


--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid,
    delta json
);


--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json,
    was_active_before_deprecation boolean DEFAULT false NOT NULL,
    migrated_flow uuid
);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: enterprise_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enterprise_tags (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    color character varying(7),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: enterprise_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enterprise_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enterprise_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enterprise_tags_id_seq OWNED BY public.enterprise_tags.id;


--
-- Name: enterprises; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enterprises (
    id integer NOT NULL,
    notes text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    company_size character varying(255) DEFAULT NULL::character varying,
    linkedin text DEFAULT NULL::character varying,
    organization_name character varying(255) DEFAULT NULL::character varying NOT NULL,
    fiscal_identification character varying(255) DEFAULT NULL::character varying,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    commercial_name character varying(255),
    fiscal_identification_type character varying(50),
    country character varying(3),
    normalized_address text,
    website character varying(500),
    phone_prefix character varying(10),
    phone_number character varying(20),
    acquisition_source character varying(100),
    internal_owner character varying(255)
);


--
-- Name: COLUMN enterprises.company_size; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprises.company_size IS 'Tamaño de empresa por rango de empleados';


--
-- Name: COLUMN enterprises.organization_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprises.organization_name IS 'Nombre oficial de la organización (obligatorio)';


--
-- Name: COLUMN enterprises.fiscal_identification; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprises.fiscal_identification IS 'Número de identificación fiscal';


--
-- Name: COLUMN enterprises.commercial_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprises.commercial_name IS 'Nombre comercial o marca';


--
-- Name: COLUMN enterprises.fiscal_identification_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprises.fiscal_identification_type IS 'Tipo de identificación fiscal (NIT, RUT, etc.)';


--
-- Name: COLUMN enterprises.country; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprises.country IS 'Código de país ISO-3166';


--
-- Name: COLUMN enterprises.normalized_address; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprises.normalized_address IS 'Dirección normalizada con geocodificación';


--
-- Name: COLUMN enterprises.phone_prefix; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprises.phone_prefix IS 'Prefijo telefónico en formato E.164';


--
-- Name: COLUMN enterprises.phone_number; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprises.phone_number IS 'Número telefónico sin prefijo';


--
-- Name: COLUMN enterprises.acquisition_source; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprises.acquisition_source IS 'Fuente de adquisición del lead';


--
-- Name: COLUMN enterprises.internal_owner; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.enterprises.internal_owner IS 'Propietario interno responsable';


--
-- Name: enterprises_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enterprises_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enterprises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enterprises_id_seq OWNED BY public.enterprises.id;


--
-- Name: enterprises_industries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enterprises_industries (
    id integer NOT NULL,
    enterprises_id integer,
    industries_id integer
);


--
-- Name: enterprises_industries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enterprises_industries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enterprises_industries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enterprises_industries_id_seq OWNED BY public.enterprises_industries.id;


--
-- Name: enterprises_keywords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enterprises_keywords (
    id integer NOT NULL,
    enterprises_id integer,
    keywords_id integer
);


--
-- Name: enterprises_keywords_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enterprises_keywords_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enterprises_keywords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enterprises_keywords_id_seq OWNED BY public.enterprises_keywords.id;


--
-- Name: enterprises_locations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enterprises_locations (
    id integer NOT NULL,
    enterprises_id integer,
    locations_id integer
);


--
-- Name: enterprises_locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enterprises_locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enterprises_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enterprises_locations_id_seq OWNED BY public.enterprises_locations.id;


--
-- Name: enterprises_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enterprises_tags (
    id integer NOT NULL,
    enterprises_id integer,
    tag_id integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: enterprises_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enterprises_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enterprises_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enterprises_tags_id_seq OWNED BY public.enterprises_tags.id;


--
-- Name: enterprises_technologies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enterprises_technologies (
    id integer NOT NULL,
    enterprises_id integer,
    technologies_id integer
);


--
-- Name: enterprises_technologies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enterprises_technologies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enterprises_technologies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enterprises_technologies_id_seq OWNED BY public.enterprises_technologies.id;


--
-- Name: industries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.industries (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    name character varying(255) DEFAULT NULL::character varying NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: industries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.industries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: industries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.industries_id_seq OWNED BY public.industries.id;


--
-- Name: keywords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keywords (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    name character varying(255) DEFAULT NULL::character varying NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: keywords_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.keywords_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: keywords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.keywords_id_seq OWNED BY public.keywords.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    city character varying(255) DEFAULT NULL::character varying NOT NULL,
    country character varying(255) DEFAULT NULL::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    province character varying(255) DEFAULT NULL::character varying NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.people (
    id integer NOT NULL,
    notes text,
    created_at timestamp with time zone,
    primary_email character varying(320) DEFAULT NULL::character varying,
    linkedin text DEFAULT NULL::character varying,
    full_name character varying(255) DEFAULT NULL::character varying NOT NULL,
    updated_at timestamp with time zone,
    position_title character varying(255),
    department character varying(100),
    phone_prefix character varying(10),
    phone_number character varying(20),
    enterprise_relation_id integer,
    decision_level character varying(50),
    acquisition_source character varying(100),
    internal_owner character varying(255),
    communication_consent boolean DEFAULT false
);


--
-- Name: COLUMN people.notes; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.notes IS 'Notas y comentarios adicionales';


--
-- Name: COLUMN people.created_at; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.created_at IS 'Fecha de creación automática';


--
-- Name: COLUMN people.primary_email; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.primary_email IS 'Email principal de contacto';


--
-- Name: COLUMN people.linkedin; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.linkedin IS 'URL del perfil de LinkedIn';


--
-- Name: COLUMN people.full_name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.full_name IS 'Nombre completo de la persona (obligatorio)';


--
-- Name: COLUMN people.updated_at; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.updated_at IS 'Fecha de última actualización';


--
-- Name: COLUMN people.position_title; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.position_title IS 'Cargo o puesto de trabajo';


--
-- Name: COLUMN people.department; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.department IS 'Área o departamento';


--
-- Name: COLUMN people.phone_prefix; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.phone_prefix IS 'Prefijo telefónico en formato E.164';


--
-- Name: COLUMN people.phone_number; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.phone_number IS 'Número telefónico sin prefijo';


--
-- Name: COLUMN people.enterprise_relation_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.enterprise_relation_id IS 'Relación con la organización';


--
-- Name: COLUMN people.decision_level; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.decision_level IS 'Nivel de decisión en la organización';


--
-- Name: COLUMN people.acquisition_source; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.acquisition_source IS 'Fuente de adquisición del contacto';


--
-- Name: COLUMN people.internal_owner; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.internal_owner IS 'Propietario interno responsable';


--
-- Name: COLUMN people.communication_consent; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.people.communication_consent IS 'Consentimiento de comunicación (GDPR/LOPD)';


--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.people_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.people_id_seq OWNED BY public.people.id;


--
-- Name: people_keywords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.people_keywords (
    id integer NOT NULL,
    keywords_id integer,
    people_id integer
);


--
-- Name: people_keywords_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.people_keywords_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_keywords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.people_keywords_id_seq OWNED BY public.people_keywords.id;


--
-- Name: people_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.people_tags (
    id integer NOT NULL,
    person_id integer,
    tag_id integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: people_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.people_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.people_tags_id_seq OWNED BY public.people_tags.id;


--
-- Name: people_technologies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.people_technologies (
    id integer NOT NULL,
    people_id integer,
    technologies_id integer
);


--
-- Name: people_technologies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.people_technologies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_technologies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.people_technologies_id_seq OWNED BY public.people_technologies.id;


--
-- Name: person_employment_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_employment_history (
    id integer NOT NULL,
    created_at timestamp with time zone,
    end_date date,
    is_current boolean,
    start_date date,
    updated_at timestamp with time zone,
    person_id integer,
    enterprise_id integer,
    position_id integer
);


--
-- Name: person_employment_history_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.person_employment_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_employment_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.person_employment_history_id_seq OWNED BY public.person_employment_history.id;


--
-- Name: positions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.positions (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    name character varying(255) DEFAULT NULL::character varying NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: positions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.positions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: positions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.positions_id_seq OWNED BY public.positions.id;


--
-- Name: segments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.segments (
    id integer NOT NULL,
    created_at timestamp with time zone,
    name character varying(255) DEFAULT NULL::character varying,
    total integer,
    updated_at timestamp with time zone,
    industry_id integer
);


--
-- Name: segments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.segments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: segments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.segments_id_seq OWNED BY public.segments.id;


--
-- Name: technologies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.technologies (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    name character varying(255) DEFAULT NULL::character varying NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: technologies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.technologies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: technologies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.technologies_id_seq OWNED BY public.technologies.id;


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_sync_id_map id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_sync_id_map ALTER COLUMN id SET DEFAULT nextval('public.directus_sync_id_map_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Name: enterprise_tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_tags ALTER COLUMN id SET DEFAULT nextval('public.enterprise_tags_id_seq'::regclass);


--
-- Name: enterprises id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises ALTER COLUMN id SET DEFAULT nextval('public.enterprises_id_seq'::regclass);


--
-- Name: enterprises_industries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_industries ALTER COLUMN id SET DEFAULT nextval('public.enterprises_industries_id_seq'::regclass);


--
-- Name: enterprises_keywords id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_keywords ALTER COLUMN id SET DEFAULT nextval('public.enterprises_keywords_id_seq'::regclass);


--
-- Name: enterprises_locations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_locations ALTER COLUMN id SET DEFAULT nextval('public.enterprises_locations_id_seq'::regclass);


--
-- Name: enterprises_tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_tags ALTER COLUMN id SET DEFAULT nextval('public.enterprises_tags_id_seq'::regclass);


--
-- Name: enterprises_technologies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_technologies ALTER COLUMN id SET DEFAULT nextval('public.enterprises_technologies_id_seq'::regclass);


--
-- Name: industries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.industries ALTER COLUMN id SET DEFAULT nextval('public.industries_id_seq'::regclass);


--
-- Name: keywords id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keywords ALTER COLUMN id SET DEFAULT nextval('public.keywords_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: people id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people ALTER COLUMN id SET DEFAULT nextval('public.people_id_seq'::regclass);


--
-- Name: people_keywords id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_keywords ALTER COLUMN id SET DEFAULT nextval('public.people_keywords_id_seq'::regclass);


--
-- Name: people_tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_tags ALTER COLUMN id SET DEFAULT nextval('public.people_tags_id_seq'::regclass);


--
-- Name: people_technologies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_technologies ALTER COLUMN id SET DEFAULT nextval('public.people_technologies_id_seq'::regclass);


--
-- Name: person_employment_history id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_employment_history ALTER COLUMN id SET DEFAULT nextval('public.person_employment_history_id_seq'::regclass);


--
-- Name: positions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positions ALTER COLUMN id SET DEFAULT nextval('public.positions_id_seq'::regclass);


--
-- Name: segments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.segments ALTER COLUMN id SET DEFAULT nextval('public.segments_id_seq'::regclass);


--
-- Name: technologies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.technologies ALTER COLUMN id SET DEFAULT nextval('public.technologies_id_seq'::regclass);


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
78775cda-b2a0-4097-8069-8fb82e235dea	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
d5f3beed-53d5-4ff4-a8a2-d8b9275e50f9	d5a3b569-26d9-4a9c-8213-4d0590840676	\N	8225d704-c297-4fef-9291-148737393e0c	\N
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 16:51:41.967+00	172.21.0.1	curl/8.5.0	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	\N
2	login	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 16:52:04.033+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	http://localhost:8055
3	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 16:52:06.282+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_settings	1	http://localhost:8055
4	login	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 17:25:57.856+00	172.21.0.1	curl/8.5.0	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	\N
5	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 17:28:30.122+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	http://localhost:8055
6	login	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 17:49:14.208+00	172.21.0.1	curl/8.5.0	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	\N
7	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:00:18.297+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	http://localhost:8055
8	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:03:31.332+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	http://localhost:8055
9	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:42.594+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_collections	Categories	\N
10	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:43.17+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	436	\N
11	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:43.173+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_collections	industries	\N
12	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:43.716+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	437	\N
13	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:43.719+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_collections	keywords	\N
14	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:44.258+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	438	\N
15	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:44.262+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_collections	technologies	\N
16	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:44.802+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	439	\N
17	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:44.805+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_collections	positions	\N
18	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:45.344+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	440	\N
19	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:45.347+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_collections	locations	\N
20	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:45.887+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	441	\N
21	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:45.889+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_collections	segments	\N
22	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:46.427+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	442	\N
23	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:46.431+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_collections	people	\N
24	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:46.971+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	443	\N
25	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:46.974+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_collections	enterprises	\N
26	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:47.516+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	444	\N
27	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:47.519+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_collections	people_keywords	\N
28	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:48.058+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	445	\N
29	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:48.061+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_collections	people_technologies	\N
30	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:48.594+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	446	\N
31	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:48.597+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_collections	enterprises_keywords	\N
32	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:49.138+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	447	\N
33	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:49.143+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_collections	enterprises_locations	\N
34	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:49.682+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	448	\N
35	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:49.684+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_collections	enterprises_technologies	\N
36	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:50.224+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	449	\N
37	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:14:50.227+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_collections	person_employment_history	\N
38	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:33.054+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	450	\N
39	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:33.326+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	451	\N
40	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:33.579+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	452	\N
41	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:33.838+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	453	\N
42	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:34.087+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	454	\N
43	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:34.34+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	455	\N
44	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:34.588+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	456	\N
45	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:35.064+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	457	\N
46	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:35.308+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	458	\N
47	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:35.553+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	459	\N
48	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:35.797+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	460	\N
49	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:36.042+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	461	\N
50	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:36.288+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	462	\N
51	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:36.533+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	463	\N
52	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:36.779+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	464	\N
53	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:37.021+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	465	\N
54	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:37.268+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	466	\N
55	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:37.511+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	467	\N
56	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:37.752+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	468	\N
57	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:38.227+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	469	\N
58	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:38.477+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	470	\N
59	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:38.946+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	471	\N
60	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:39.19+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	472	\N
61	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:39.662+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	473	\N
62	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:39.906+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	474	\N
63	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:40.377+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	475	\N
64	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:40.622+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	476	\N
65	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:40.866+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	477	\N
66	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:41.337+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	478	\N
67	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:41.582+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	479	\N
68	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:41.828+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	480	\N
69	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:42.078+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	481	\N
70	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:42.325+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	482	\N
71	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:42.788+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	483	\N
72	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:43.032+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	484	\N
73	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:43.284+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	485	\N
74	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:43.53+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	486	\N
75	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:43.775+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	487	\N
76	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:44.019+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	488	\N
77	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:44.494+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	489	\N
78	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:44.735+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	490	\N
79	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:44.978+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	491	\N
80	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:45.224+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	492	\N
81	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:45.468+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	493	\N
82	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:45.712+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	494	\N
83	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:45.956+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	495	\N
84	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:46.201+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	496	\N
85	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:46.445+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	497	\N
86	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:46.694+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	498	\N
87	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:46.942+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	499	\N
88	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:47.411+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	500	\N
89	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:47.657+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	501	\N
90	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:48.125+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	502	\N
91	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:48.375+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	503	\N
92	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:48.618+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	504	\N
93	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:48.861+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	505	\N
94	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:49.106+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	506	\N
280	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:01:18.496+00	172.21.0.1	curl/8.5.0	enterprises	14	\N
95	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:49.571+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	507	\N
96	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:49.812+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	508	\N
97	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:50.055+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	509	\N
98	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:50.3+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	510	\N
99	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:50.545+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	511	\N
100	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:50.79+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	512	\N
101	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:51.263+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	513	\N
102	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:51.509+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	514	\N
103	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:51.752+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	515	\N
104	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:52.227+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	516	\N
105	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:52.468+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	517	\N
106	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:52.712+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	518	\N
107	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:52.955+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	519	\N
108	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:53.2+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	520	\N
109	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:53.676+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	521	\N
110	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:15:53.924+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	522	\N
111	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:20:38.857+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	492	\N
112	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:20:39.216+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	516	\N
113	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:20:39.57+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	506	\N
114	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:20:39.919+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	508	\N
115	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:20:40.276+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	509	\N
116	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:21:55.468+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	492	http://localhost:8055
117	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:23:54.059+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	523	\N
118	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:24:16.797+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	523	\N
119	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:31:19.068+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	523	\N
120	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:31:20.183+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	524	\N
121	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:33:23.987+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	516	\N
122	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:35:16.962+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	516	\N
123	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:35:18.072+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	525	\N
124	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:38:08.104+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	508	\N
125	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:38:09.22+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	526	\N
126	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:38:10.893+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	506	\N
127	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:38:11.961+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	527	\N
128	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:38:13.624+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	509	\N
129	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:38:14.693+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	528	\N
130	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:44:27.589+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	locations	1	http://localhost:8055
131	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:44:52.29+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	keywords	1	http://localhost:8055
132	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:44:52.295+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people_keywords	1	http://localhost:8055
133	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:44:52.306+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	technologies	1	http://localhost:8055
134	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:44:52.31+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people_technologies	1	http://localhost:8055
135	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:44:52.317+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people	1	http://localhost:8055
136	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:45:07.374+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people	1	http://localhost:8055
137	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:46:53.769+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	people	3	\N
138	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:47:31.486+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises	1	\N
139	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:47:31.515+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	positions	1	\N
140	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:47:31.532+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	people	4	\N
141	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:47:31.552+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	person_employment_history	2	\N
142	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:49:30.498+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people	1	http://localhost:8055
143	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:49:30.5+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people	3	http://localhost:8055
144	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:50:27.842+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	keywords	2	http://localhost:8055
145	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:50:27.849+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people_keywords	2	http://localhost:8055
146	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:50:27.857+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	keywords	3	http://localhost:8055
147	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:50:27.861+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people_keywords	3	http://localhost:8055
148	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:50:27.874+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	technologies	2	http://localhost:8055
149	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:50:27.878+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people_technologies	2	http://localhost:8055
150	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:50:27.887+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	technologies	3	http://localhost:8055
151	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:50:27.892+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people_technologies	3	http://localhost:8055
152	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:50:27.899+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people	4	http://localhost:8055
153	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:52:22.786+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	526	\N
154	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:52:22.934+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	527	\N
155	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 21:52:23.028+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	directus_fields	528	\N
156	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 22:59:10.757+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	458	http://localhost:8055
157	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 22:59:42.076+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	529	http://localhost:8055
158	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 22:59:42.284+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	530	http://localhost:8055
159	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 22:59:42.291+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_collections	enterprises_industries	http://localhost:8055
160	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 22:59:42.387+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	531	http://localhost:8055
161	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 22:59:42.558+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_fields	532	http://localhost:8055
162	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 23:00:13.264+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	industries	1	http://localhost:8055
163	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 23:00:13.272+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises_industries	1	http://localhost:8055
164	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-19 23:00:13.283+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	1	http://localhost:8055
165	login	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-22 20:22:58.602+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	http://localhost:8055
166	login	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 03:45:29.208+00	172.21.0.1	curl/8.5.0	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	\N
167	login	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 03:57:13.821+00	172.21.0.1	curl/8.5.0	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	\N
168	login	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 03:58:30.103+00	172.21.0.1	curl/8.5.0	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	\N
169	login	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 03:59:56.827+00	172.21.0.1	curl/8.5.0	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	\N
170	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:00:48.267+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	http://localhost:8055
171	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:09.746+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises	2	\N
172	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:09.826+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises_industries	2	\N
173	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:09.925+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	keywords	4	\N
174	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:09.959+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises_keywords	1	\N
175	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.007+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	technologies	4	\N
176	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.031+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises_technologies	1	\N
177	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.057+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	people	5	\N
178	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.094+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	person_employment_history	3	\N
179	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.129+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises	3	\N
180	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.171+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	industries	2	\N
181	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.19+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises_industries	3	\N
182	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.292+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	keywords	5	\N
183	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.317+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises_keywords	2	\N
184	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.362+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	keywords	6	\N
185	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.389+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises_keywords	3	\N
186	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.44+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	technologies	5	\N
187	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.467+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises_technologies	2	\N
188	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.529+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	technologies	6	\N
189	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.553+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises_technologies	3	\N
190	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.594+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	technologies	7	\N
191	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.614+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises_technologies	4	\N
192	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.639+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	people	6	\N
193	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.669+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	person_employment_history	4	\N
194	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.71+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises	4	\N
195	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.763+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	industries	3	\N
196	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.785+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises_industries	4	\N
197	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.854+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	keywords	7	\N
198	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.871+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises_keywords	4	\N
199	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.906+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	keywords	8	\N
200	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.924+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises_keywords	5	\N
201	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.957+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises_technologies	5	\N
202	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:10.991+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	technologies	8	\N
203	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:11.01+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises_technologies	6	\N
204	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:11.041+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	technologies	9	\N
205	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:11.06+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	enterprises_technologies	7	\N
206	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:11.08+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	people	7	\N
207	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:06:11.107+00	172.21.0.1	node-fetch/1.0 (+https://github.com/bitinn/node-fetch)	person_employment_history	5	\N
208	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:19:39.57+00	172.21.0.1	curl/8.5.0	people	8	\N
209	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:19:39.584+00	172.21.0.1	curl/8.5.0	person_employment_history	6	\N
210	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:19:39.602+00	172.21.0.1	curl/8.5.0	enterprises	5	\N
211	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:19:39.614+00	172.21.0.1	curl/8.5.0	industries	4	\N
212	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:19:39.621+00	172.21.0.1	curl/8.5.0	enterprises_industries	5	\N
213	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:19:39.635+00	172.21.0.1	curl/8.5.0	locations	2	\N
214	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:19:39.643+00	172.21.0.1	curl/8.5.0	enterprises_locations	1	\N
215	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:19:39.654+00	172.21.0.1	curl/8.5.0	keywords	9	\N
216	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:19:39.663+00	172.21.0.1	curl/8.5.0	enterprises_keywords	6	\N
217	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:19:39.673+00	172.21.0.1	curl/8.5.0	technologies	10	\N
218	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:19:39.681+00	172.21.0.1	curl/8.5.0	enterprises_technologies	8	\N
219	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:19:39.69+00	172.21.0.1	curl/8.5.0	technologies	11	\N
220	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:19:39.697+00	172.21.0.1	curl/8.5.0	enterprises_technologies	9	\N
221	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:19:39.705+00	172.21.0.1	curl/8.5.0	people	9	\N
222	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:19:39.711+00	172.21.0.1	curl/8.5.0	person_employment_history	7	\N
223	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:27:41.917+00	172.21.0.1	curl/8.5.0	enterprises	6	\N
224	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:27:41.934+00	172.21.0.1	curl/8.5.0	enterprises_industries	6	\N
225	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:27:41.951+00	172.21.0.1	curl/8.5.0	locations	3	\N
226	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:27:41.96+00	172.21.0.1	curl/8.5.0	enterprises_locations	2	\N
227	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:27:41.971+00	172.21.0.1	curl/8.5.0	locations	4	\N
228	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:27:41.977+00	172.21.0.1	curl/8.5.0	enterprises_locations	3	\N
229	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:27:41.99+00	172.21.0.1	curl/8.5.0	keywords	10	\N
230	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:27:41.997+00	172.21.0.1	curl/8.5.0	enterprises_keywords	7	\N
231	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:27:42.009+00	172.21.0.1	curl/8.5.0	keywords	11	\N
232	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:27:42.016+00	172.21.0.1	curl/8.5.0	enterprises_keywords	8	\N
233	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:27:42.027+00	172.21.0.1	curl/8.5.0	enterprises_technologies	10	\N
234	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:27:42.039+00	172.21.0.1	curl/8.5.0	enterprises_technologies	11	\N
235	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:27:42.047+00	172.21.0.1	curl/8.5.0	enterprises_technologies	12	\N
236	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:28:26.148+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	person_employment_history	2	http://localhost:8055
237	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:28:26.15+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	person_employment_history	3	http://localhost:8055
238	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:28:26.151+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	person_employment_history	4	http://localhost:8055
239	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:28:26.152+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	person_employment_history	5	http://localhost:8055
240	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:28:26.154+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	person_employment_history	6	http://localhost:8055
241	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:28:26.156+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	person_employment_history	7	http://localhost:8055
242	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:28:31.5+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people	4	http://localhost:8055
243	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:28:31.501+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people	5	http://localhost:8055
244	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:28:31.503+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people	6	http://localhost:8055
245	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:28:31.504+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people	7	http://localhost:8055
246	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:28:31.506+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people	8	http://localhost:8055
247	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:28:31.507+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people	9	http://localhost:8055
248	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:30:24.28+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	1	http://localhost:8055
249	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:30:39.213+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	2	http://localhost:8055
250	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:30:39.216+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	3	http://localhost:8055
251	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:30:39.218+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	4	http://localhost:8055
252	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:30:39.219+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	5	http://localhost:8055
253	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:30:39.221+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	6	http://localhost:8055
254	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:37:05.061+00	172.21.0.1	curl/8.5.0	enterprises	7	\N
255	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:37:05.076+00	172.21.0.1	curl/8.5.0	enterprises_industries	7	\N
256	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:37:05.086+00	172.21.0.1	curl/8.5.0	enterprises_locations	4	\N
257	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:37:05.099+00	172.21.0.1	curl/8.5.0	keywords	12	\N
258	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:37:05.106+00	172.21.0.1	curl/8.5.0	enterprises_keywords	9	\N
259	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:37:05.118+00	172.21.0.1	curl/8.5.0	keywords	13	\N
260	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:37:05.126+00	172.21.0.1	curl/8.5.0	enterprises_keywords	10	\N
261	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:37:05.136+00	172.21.0.1	curl/8.5.0	enterprises_technologies	13	\N
262	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:37:05.145+00	172.21.0.1	curl/8.5.0	technologies	12	\N
263	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:37:05.153+00	172.21.0.1	curl/8.5.0	enterprises_technologies	14	\N
264	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:46:57.865+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	http://localhost:8055
265	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:47:04.63+00	172.21.0.1	PostmanRuntime/7.46.0	enterprises	8	\N
266	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:47:04.647+00	172.21.0.1	PostmanRuntime/7.46.0	enterprises_industries	8	\N
267	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:47:04.658+00	172.21.0.1	PostmanRuntime/7.46.0	enterprises_locations	5	\N
268	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:47:04.667+00	172.21.0.1	PostmanRuntime/7.46.0	enterprises_keywords	11	\N
269	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 04:47:04.678+00	172.21.0.1	PostmanRuntime/7.46.0	enterprises_technologies	15	\N
270	update	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 19:47:22.071+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	http://localhost:8055
271	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 19:55:08.777+00	172.21.0.1	curl/8.5.0	enterprises	9	\N
272	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 19:55:42.32+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	7	http://localhost:8055
273	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 19:55:42.323+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	8	http://localhost:8055
274	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 19:55:42.325+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	9	http://localhost:8055
275	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 19:55:45.679+00	172.21.0.1	PostmanRuntime/7.46.0	enterprises	10	\N
276	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 19:56:24.542+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	10	http://localhost:8055
277	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 19:56:33.808+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	11	http://localhost:8055
278	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 19:57:18.691+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	12	http://localhost:8055
279	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 19:59:56.388+00	172.21.0.1	curl/8.5.0	enterprises	13	\N
281	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:02:27.284+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	15	http://localhost:8055
282	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:02:32.641+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	11	http://localhost:8055
283	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:02:32.644+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	12	http://localhost:8055
284	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:02:32.647+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	13	http://localhost:8055
285	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:02:32.65+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	14	http://localhost:8055
286	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:02:32.651+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	15	http://localhost:8055
287	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:03:02.844+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	16	http://localhost:8055
288	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:03:08.317+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	16	http://localhost:8055
289	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:03:12.502+00	172.21.0.1	PostmanRuntime/7.46.0	enterprises	17	\N
290	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:05:11.847+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	enterprises	17	http://localhost:8055
291	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:12:32.916+00	172.21.0.1	curl/8.5.0	people	10	\N
292	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:13:29.277+00	172.21.0.1	curl/8.5.0	people	11	\N
293	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:42:24.355+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people	10	http://localhost:8055
294	delete	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:42:24.36+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	people	11	http://localhost:8055
295	create	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:42:58.472+00	172.21.0.1	PostmanRuntime/7.46.0	people	12	\N
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
Categories	folder	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	1	\N	open	\N	f
industries	factory	Colección para gestionar industrias del CRM	{{name}}	f	f	\N	\N	t	\N	\N	id	all	\N	\N	2	Categories	open	\N	f
keywords	label	Colección para gestionar palabras clave del CRM	{{name}}	f	f	\N	\N	t	\N	\N	id	all	#FFF700	\N	4	Categories	open	\N	f
technologies	memory	Colección para gestionar tecnologías del CRM	{{name}}	f	f	\N	\N	t	\N	\N	id	all	\N	\N	3	Categories	open	\N	f
positions	work	Colección para gestionar cargos/posiciones laborales del CRM	{{name}}	f	f	\N	\N	t	\N	\N	id	all	\N	\N	1	Categories	open	\N	f
locations	location_on	Colección para gestionar ubicaciones geográficas del CRM	{{country}} - {{province}} - {{city}}	f	f	\N	\N	t	\N	\N	id	all	#E35169	\N	5	Categories	open	\N	f
segments	category	Colección para gestionar segmentos del CRM	{{name}}	f	f	\N	\N	t	\N	\N	id	all	\N	\N	3	\N	open	\N	f
people_keywords	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	9	\N	open	\N	f
people_technologies	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	10	\N	open	\N	f
enterprises_keywords	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	6	\N	open	\N	f
enterprises_locations	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	7	\N	open	\N	f
enterprises_technologies	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	8	\N	open	\N	f
person_employment_history	work_history	Historial laboral de las personas - relación entre persona, empresa y posición	{{id}}	f	f	\N	\N	t	\N	\N	id	all	\N	\N	5	\N	open	\N	f
enterprises_industries	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
enterprise_tags	local_offer	Etiquetas para empresas	{{name}}	f	f	\N	\N	t	\N	\N	\N	all	#2ECDA7	\N	\N	\N	open	\N	f
enterprises	business	Colección para gestionar empresas del CRM	{{organization_name}}	f	f	\N	\N	t	\N	\N	id	all	\N	\N	4	\N	open	\N	f
people	group	Colección para gestionar personas del CRM	{{full_name}}	f	f	\N	\N	t	\N	\N	id	all	\N	\N	2	\N	open	\N	f
\.


--
-- Data for Name: directus_comments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_comments (id, collection, item, comment, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
t	e7379d4b-fc21-45bc-9db3-05edf770950c	directus-extension-endpoint-pokeapi	local	\N
t	742f7102-0bc8-4061-8fd3-a0bb45a1add4	@directus-labs/migration-bundle	module	\N
t	efd63ab9-21e7-444e-bd3b-333569574c9a	migration-module	module	742f7102-0bc8-4061-8fd3-a0bb45a1add4
t	727e9e9a-6dcf-4d84-bc69-6b7ac4307c8c	migration-endpoint	module	742f7102-0bc8-4061-8fd3-a0bb45a1add4
t	8d9a9a82-b1c4-4a26-aa1d-98969a38ea2a	@directus-labs/simple-list-interface	module	\N
t	99eea841-caad-4b69-b51c-5f6857d3f1fa	directus-extension-computed-interface	module	\N
t	e12925ac-b348-4980-87cf-34eba9a3b707	directus-extension-flexible-editor	module	\N
t	25ddd3db-a454-4ed3-8b5c-752be4bf49e3	interface	module	e12925ac-b348-4980-87cf-34eba9a3b707
t	c689f066-7e5c-46fc-a322-44aba86e9861	display	module	e12925ac-b348-4980-87cf-34eba9a3b707
t	01763434-6b88-4f9f-ab23-2515657b95f2	directus-extension-upsert	module	\N
t	48328a24-e4e3-4174-8e6b-c592e59b650d	directus-extension-wpslug-interface	module	\N
t	a5acb27e-f359-4897-8019-8a5867ba681a	directus-extension-sync	module	\N
t	960f791e-ab0d-4eea-b81c-a0e176925fe3	directus-extension-endpoint-people-import	local	\N
t	cb50d16f-cc4b-4ec8-b40b-b802d52612dc	people-import	local	\N
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
436	industries	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
437	keywords	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
438	technologies	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
439	positions	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
440	locations	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
441	segments	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
444	people_keywords	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
445	people_technologies	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
446	enterprises_keywords	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
447	enterprises_locations	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
448	enterprises_technologies	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
449	person_employment_history	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
468	enterprises_keywords	enterprises_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
469	enterprises_keywords	keywords_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
470	enterprises_locations	enterprises_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
471	enterprises_locations	locations_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
472	enterprises_technologies	enterprises_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
473	enterprises_technologies	technologies_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
474	industries	created_at	date-created,cast-timestamp	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	Fecha de creación	\N	f	\N	\N	\N
475	industries	name	\N	input	\N	raw	\N	f	f	2	full	\N	Nombre de la industria	\N	t	\N	\N	\N
476	industries	updated_at	date-updated,cast-timestamp	datetime	\N	datetime	{"relative":true}	t	t	4	half	\N	Fecha de última actualización	\N	f	\N	\N	\N
477	keywords	created_at	date-created,cast-timestamp	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	Fecha de creación	\N	f	\N	\N	\N
478	keywords	name	\N	input	\N	raw	\N	f	f	2	full	\N	Nombre de la palabra clave	\N	t	\N	\N	\N
479	keywords	updated_at	date-updated,cast-timestamp	datetime	\N	datetime	{"relative":true}	t	t	4	half	\N	Fecha de última actualización	\N	f	\N	\N	\N
480	locations	city	\N	input	\N	raw	\N	f	f	4	half	\N	Ciudad	\N	t	\N	\N	\N
481	locations	country	\N	input	\N	raw	\N	f	f	2	full	\N	País	\N	t	\N	\N	\N
482	locations	created_at	date-created,cast-timestamp	datetime	\N	datetime	{"relative":true}	t	t	5	half	\N	Fecha de creación	\N	f	\N	\N	\N
483	locations	province	\N	input	\N	raw	\N	f	f	3	half	\N	Provincia/Estado	\N	t	\N	\N	\N
484	locations	updated_at	date-updated,cast-timestamp	datetime	\N	datetime	{"relative":true}	t	t	6	half	\N	Fecha de última actualización	\N	f	\N	\N	\N
500	people_keywords	keywords_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
501	people_keywords	people_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
502	people_technologies	people_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
503	people_technologies	technologies_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
504	person_employment_history	created_at	date-created,cast-timestamp	datetime	\N	datetime	{"relative":true}	t	f	8	half	\N	\N	\N	f	\N	\N	\N
505	person_employment_history	end_date	\N	datetime	{"includeSeconds":false}	datetime	{"format":"YYYY-MM-DD"}	f	f	7	half	\N	\N	\N	f	\N	\N	\N
507	person_employment_history	is_current	\N	boolean	\N	boolean	\N	f	f	5	half	\N	Indica si es el trabajo actual	\N	f	\N	\N	\N
510	person_employment_history	start_date	\N	datetime	{"includeSeconds":false}	datetime	{"format":"YYYY-MM-DD"}	f	f	6	half	\N	\N	\N	f	\N	\N	\N
511	person_employment_history	updated_at	date-updated,cast-timestamp	datetime	\N	datetime	{"relative":true}	t	f	9	half	\N	\N	\N	f	\N	\N	\N
512	positions	created_at	date-created,cast-timestamp	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	Fecha de creación	\N	f	\N	\N	\N
513	positions	name	\N	input	\N	raw	\N	f	f	2	full	\N	Nombre del cargo/posición	\N	t	\N	\N	\N
514	positions	updated_at	date-updated,cast-timestamp	datetime	\N	datetime	{"relative":true}	t	t	4	half	\N	Fecha de última actualización	\N	f	\N	\N	\N
515	segments	created_at	date-created,cast-timestamp	datetime	\N	datetime	{"relative":true}	t	f	5	half	\N	\N	\N	f	\N	\N	\N
517	segments	name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	t	\N	\N	\N
518	segments	total	\N	input	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
519	segments	updated_at	date-updated,cast-timestamp	datetime	\N	datetime	{"relative":true}	t	f	6	half	\N	\N	\N	f	\N	\N	\N
520	technologies	created_at	date-created,cast-timestamp	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	Fecha de creación	\N	f	\N	\N	\N
521	technologies	name	\N	input	\N	raw	\N	f	f	2	full	\N	Nombre de la tecnología	\N	t	\N	\N	\N
522	technologies	updated_at	date-updated,cast-timestamp	datetime	\N	datetime	{"relative":true}	t	t	4	half	\N	Fecha de última actualización	\N	f	\N	\N	\N
544	enterprises	fiscal_identification_type	\N	select-dropdown	{"choices": [{"text": "NIT (Colombia)", "value": "NIT"}, {"text": "RUT (Chile)", "value": "RUT"}, {"text": "RUC (Perú)", "value": "RUC"}, {"text": "CUIT (Argentina)", "value": "CUIT"}, {"text": "CNPJ (Brasil)", "value": "CNPJ"}, {"text": "RFC (México)", "value": "RFC"}, {"text": "Otro", "value": "OTHER"}]}	\N	\N	f	f	5	half	[{"language": "es-ES", "translation": "Tipo de identificación fiscal"}]	Tipo de documento fiscal	\N	f	\N	\N	\N
546	enterprises	company_size	\N	select-dropdown	{"choices": [{"text": "1-10 empleados", "value": "1-10"}, {"text": "11-50 empleados", "value": "11-50"}, {"text": "51-200 empleados", "value": "51-200"}, {"text": "201-500 empleados", "value": "201-500"}, {"text": "501-1000 empleados", "value": "501-1000"}, {"text": "1000+ empleados", "value": "1000+"}]}	\N	\N	f	f	7	half	[{"language": "es-ES", "translation": "Tamaño de la empresa"}]	Rango de empleados	\N	f	\N	\N	\N
525	segments	industry_id	\N	select-dropdown-m2o	{"template":"{{name}}"}	related-values	{"template":"{{name}}"}	f	f	3	full	\N	\N	\N	f	\N	\N	\N
526	person_employment_history	person_id	\N	select-dropdown-m2o	{"template":"{{name}}","enable_create":false}	related-values	{"template":"{{name}}"}	f	f	10	full	\N	\N	\N	f	\N	\N	\N
527	person_employment_history	enterprise_id	\N	select-dropdown-m2o	{"template":"{{name}}","enable_create":false}	related-values	{"template":"{{name}}"}	f	f	11	full	\N	\N	\N	f	\N	\N	\N
528	person_employment_history	position_id	\N	select-dropdown-m2o	{"template":"{{name}}","enable_create":false}	related-values	{"template":"{{name}}"}	f	f	12	full	\N	\N	\N	f	\N	\N	\N
530	enterprises_industries	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
531	enterprises_industries	enterprises_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
532	enterprises_industries	industries_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
540	enterprises	id	\N	input	\N	\N	\N	t	f	1	full	[{"language": "es-ES", "translation": "ID interno"}]	ID autogenerado	\N	f	\N	\N	\N
541	enterprises	organization_name	\N	input	\N	\N	\N	f	f	2	full	[{"language": "es-ES", "translation": "Nombre de la organización"}]	Nombre oficial de la empresa (obligatorio)	\N	t	\N	\N	\N
542	enterprises	commercial_name	\N	input	\N	\N	\N	f	f	3	half	[{"language": "es-ES", "translation": "Nombre comercial / marca"}]	Nombre comercial o marca	\N	f	\N	\N	\N
543	enterprises	linkedin	\N	input	\N	\N	\N	f	f	4	half	[{"language": "es-ES", "translation": "LinkedIn"}]	URL del perfil de LinkedIn	\N	f	\N	\N	\N
545	enterprises	fiscal_identification	\N	input	\N	\N	\N	f	f	6	half	[{"language": "es-ES", "translation": "Identificación fiscal"}]	Número de identificación fiscal	\N	f	\N	\N	\N
548	enterprises	normalized_address	\N	input	\N	\N	\N	f	f	9	full	[{"language": "es-ES", "translation": "Dirección (normalizada)"}]	Dirección con autocompletado Mapbox	\N	f	\N	\N	\N
549	enterprises	website	\N	input	\N	\N	\N	f	f	10	half	[{"language": "es-ES", "translation": "Sitio web"}]	URL del sitio web	\N	f	\N	\N	\N
551	enterprises	phone_number	\N	input	\N	\N	\N	f	f	12	quarter	[{"language": "es-ES", "translation": "Teléfono – número"}]	Número telefónico	\N	f	\N	\N	\N
553	enterprises	internal_owner	\N	input	\N	\N	\N	f	f	14	half	[{"language": "es-ES", "translation": "Propietario interno"}]	Responsable interno	\N	f	\N	\N	\N
554	enterprises	notes	\N	input-multiline	\N	\N	\N	f	f	15	full	[{"language": "es-ES", "translation": "Notas"}]	Notas adicionales	\N	f	\N	\N	\N
555	enterprises	created_at	\N	datetime	\N	\N	\N	t	f	16	half	[{"language": "es-ES", "translation": "Fecha de creación"}]	Fecha de creación automática	\N	f	\N	\N	\N
556	enterprises	updated_at	\N	datetime	\N	\N	\N	t	f	17	half	[{"language": "es-ES", "translation": "Última actualización"}]	Fecha de última modificación	\N	f	\N	\N	\N
547	enterprises	country	\N	select-dropdown	{"choices": [{"text": "Colombia", "value": "COL"}, {"text": "Argentina", "value": "ARG"}, {"text": "Brasil", "value": "BRA"}, {"text": "Chile", "value": "CHL"}, {"text": "México", "value": "MEX"}, {"text": "Perú", "value": "PER"}, {"text": "Estados Unidos", "value": "USA"}, {"text": "España", "value": "ESP"}]}	\N	\N	f	f	8	half	[{"language": "es-ES", "translation": "País"}]	País de la empresa (ISO-3166)	\N	f	\N	\N	\N
550	enterprises	phone_prefix	\N	select-dropdown	{"choices": [{"text": "+57 (Colombia)", "value": "+57"}, {"text": "+54 (Argentina)", "value": "+54"}, {"text": "+55 (Brasil)", "value": "+55"}, {"text": "+56 (Chile)", "value": "+56"}, {"text": "+52 (México)", "value": "+52"}, {"text": "+51 (Perú)", "value": "+51"}, {"text": "+1 (Estados Unidos)", "value": "+1"}, {"text": "+34 (España)", "value": "+34"}]}	\N	\N	f	f	11	quarter	[{"language": "es-ES", "translation": "Teléfono – prefijo"}]	Prefijo telefónico (+E.164)	\N	f	\N	\N	\N
552	enterprises	acquisition_source	\N	select-dropdown	{"choices": [{"text": "Sitio web", "value": "website"}, {"text": "Referido", "value": "referral"}, {"text": "LinkedIn", "value": "linkedin"}, {"text": "Publicidad", "value": "advertising"}, {"text": "Evento", "value": "event"}, {"text": "Cold outreach", "value": "cold_outreach"}, {"text": "Otro", "value": "other"}]}	\N	\N	f	f	13	half	[{"language": "es-ES", "translation": "Fuente de adquisición"}]	Cómo se adquirió el lead	\N	f	\N	\N	\N
557	enterprises	industries	m2m	list-m2m	\N	\N	\N	f	f	18	full	[{"language": "es-ES", "translation": "Sector / industria"}]	Sectores o industrias (selección múltiple)	\N	f	\N	\N	\N
559	enterprise_tags	id	\N	input	\N	\N	\N	t	f	1	full	[{"language": "es-ES", "translation": "ID"}]	ID autogenerado	\N	f	\N	\N	\N
560	enterprise_tags	name	\N	input	\N	\N	\N	f	f	2	full	[{"language": "es-ES", "translation": "Nombre"}]	Nombre de la etiqueta	\N	t	\N	\N	\N
561	people	id	\N	input	\N	\N	\N	t	t	1	full	[{"language": "es-ES", "translation": "ID interno"}]	ID autogenerado	\N	f	\N	\N	\N
562	people	full_name	\N	input	\N	\N	\N	f	f	2	full	[{"language": "es-ES", "translation": "Nombre completo"}]	Nombre completo de la persona (obligatorio)	\N	t	\N	\N	\N
563	people	position_title	\N	input	\N	\N	\N	f	f	3	half	[{"language": "es-ES", "translation": "Cargo / puesto"}]	Cargo o puesto de trabajo	\N	f	\N	\N	\N
564	people	department	\N	select-dropdown	{"choices": [{"text": "Dirección General", "value": "direccion_general"}, {"text": "Ventas", "value": "ventas"}, {"text": "Marketing", "value": "marketing"}, {"text": "Tecnología / IT", "value": "tecnologia"}, {"text": "Recursos Humanos", "value": "rrhh"}, {"text": "Finanzas", "value": "finanzas"}, {"text": "Operaciones", "value": "operaciones"}, {"text": "Compras", "value": "compras"}, {"text": "Legal", "value": "legal"}, {"text": "Producto", "value": "producto"}, {"text": "Consultoría", "value": "consultoria"}, {"text": "Otro", "value": "otro"}]}	\N	\N	f	f	4	half	[{"language": "es-ES", "translation": "Área / departamento"}]	Área o departamento	\N	f	\N	\N	\N
565	people	linkedin	\N	input	\N	\N	\N	f	f	5	half	[{"language": "es-ES", "translation": "LinkedIn"}]	URL del perfil de LinkedIn	\N	f	\N	\N	\N
566	people	primary_email	\N	input	\N	\N	\N	f	f	6	half	[{"language": "es-ES", "translation": "Email principal"}]	Email principal de contacto	\N	f	\N	\N	\N
567	people	phone_prefix	\N	select-dropdown	{"choices": [{"text": "+57 (Colombia)", "value": "+57"}, {"text": "+54 (Argentina)", "value": "+54"}, {"text": "+55 (Brasil)", "value": "+55"}, {"text": "+56 (Chile)", "value": "+56"}, {"text": "+52 (México)", "value": "+52"}, {"text": "+51 (Perú)", "value": "+51"}, {"text": "+1 (Estados Unidos)", "value": "+1"}, {"text": "+34 (España)", "value": "+34"}]}	\N	\N	f	f	7	quarter	[{"language": "es-ES", "translation": "Teléfono – prefijo"}]	Prefijo telefónico (+E.164)	\N	f	\N	\N	\N
568	people	phone_number	\N	input	\N	\N	\N	f	f	8	quarter	[{"language": "es-ES", "translation": "Teléfono – número"}]	Número telefónico sin prefijo	\N	f	\N	\N	\N
569	people	enterprise_relation_id	m2o	select-dropdown-m2o	\N	\N	\N	f	f	9	half	[{"language": "es-ES", "translation": "Relación con la organización"}]	Empresa u organización relacionada	\N	f	\N	\N	\N
570	people	decision_level	\N	select-dropdown	{"choices": [{"text": "C-Level (CEO, CTO, etc.)", "value": "c_level"}, {"text": "VP / Vicepresidente", "value": "vp"}, {"text": "Director", "value": "director"}, {"text": "Gerente / Manager", "value": "manager"}, {"text": "Coordinador / Supervisor", "value": "coordinator"}, {"text": "Especialista / Analista", "value": "specialist"}, {"text": "Asistente / Junior", "value": "assistant"}, {"text": "Consultor Externo", "value": "consultant"}, {"text": "Otro", "value": "other"}]}	\N	\N	f	f	10	half	[{"language": "es-ES", "translation": "Nivel de decisión"}]	Nivel de decisión en la organización	\N	f	\N	\N	\N
571	people	acquisition_source	\N	select-dropdown	{"choices": [{"text": "Sitio web", "value": "website"}, {"text": "Referido", "value": "referral"}, {"text": "LinkedIn", "value": "linkedin"}, {"text": "Evento / Networking", "value": "event"}, {"text": "Cold outreach", "value": "cold_outreach"}, {"text": "Publicidad", "value": "advertising"}, {"text": "Partner / Socio", "value": "partner"}, {"text": "Inbound", "value": "inbound"}, {"text": "Otro", "value": "other"}]}	\N	\N	f	f	11	half	[{"language": "es-ES", "translation": "Fuente de adquisición"}]	Cómo se adquirió el contacto	\N	f	\N	\N	\N
572	people	internal_owner	\N	input	\N	\N	\N	f	f	12	half	[{"language": "es-ES", "translation": "Propietario interno"}]	Responsable interno del contacto	\N	f	\N	\N	\N
573	people	notes	\N	input-multiline	\N	\N	\N	f	f	13	full	[{"language": "es-ES", "translation": "Notas / comentarios"}]	Notas y comentarios adicionales	\N	f	\N	\N	\N
574	people	created_at	\N	datetime	\N	\N	\N	t	f	14	half	[{"language": "es-ES", "translation": "Fecha de creación"}]	Fecha de creación automática	\N	f	\N	\N	\N
575	people	updated_at	\N	datetime	\N	\N	\N	t	f	15	half	[{"language": "es-ES", "translation": "Última actualización"}]	Fecha de última actualización	\N	f	\N	\N	\N
576	people	communication_consent	\N	boolean	\N	\N	\N	f	f	16	half	[{"language": "es-ES", "translation": "Consentimiento de comunicación (GDPR/LOPD)"}]	Consentimiento para comunicaciones	\N	f	\N	\N	\N
578	people	tags	m2m	list-m2m	\N	\N	\N	f	f	17	full	[{"language": "es-ES", "translation": "Etiquetas / tags"}]	Etiquetas dinámicas (chips)	\N	f	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2025-09-19 16:48:00.386896+00
20201029A	Remove System Relations	2025-09-19 16:48:00.390862+00
20201029B	Remove System Collections	2025-09-19 16:48:00.394065+00
20201029C	Remove System Fields	2025-09-19 16:48:00.401036+00
20201105A	Add Cascade System Relations	2025-09-19 16:48:00.423055+00
20201105B	Change Webhook URL Type	2025-09-19 16:48:00.427931+00
20210225A	Add Relations Sort Field	2025-09-19 16:48:00.434505+00
20210304A	Remove Locked Fields	2025-09-19 16:48:00.437026+00
20210312A	Webhooks Collections Text	2025-09-19 16:48:00.442324+00
20210331A	Add Refresh Interval	2025-09-19 16:48:00.444215+00
20210415A	Make Filesize Nullable	2025-09-19 16:48:00.447998+00
20210416A	Add Collections Accountability	2025-09-19 16:48:00.451372+00
20210422A	Remove Files Interface	2025-09-19 16:48:00.45297+00
20210506A	Rename Interfaces	2025-09-19 16:48:00.464848+00
20210510A	Restructure Relations	2025-09-19 16:48:00.474027+00
20210518A	Add Foreign Key Constraints	2025-09-19 16:48:00.479826+00
20210519A	Add System Fk Triggers	2025-09-19 16:48:00.493412+00
20210521A	Add Collections Icon Color	2025-09-19 16:48:00.495055+00
20210525A	Add Insights	2025-09-19 16:48:00.50462+00
20210608A	Add Deep Clone Config	2025-09-19 16:48:00.506235+00
20210626A	Change Filesize Bigint	2025-09-19 16:48:00.512561+00
20210716A	Add Conditions to Fields	2025-09-19 16:48:00.514112+00
20210721A	Add Default Folder	2025-09-19 16:48:00.518708+00
20210802A	Replace Groups	2025-09-19 16:48:00.52191+00
20210803A	Add Required to Fields	2025-09-19 16:48:00.523718+00
20210805A	Update Groups	2025-09-19 16:48:00.526179+00
20210805B	Change Image Metadata Structure	2025-09-19 16:48:00.52942+00
20210811A	Add Geometry Config	2025-09-19 16:48:00.531038+00
20210831A	Remove Limit Column	2025-09-19 16:48:00.532686+00
20210903A	Add Auth Provider	2025-09-19 16:48:00.542892+00
20210907A	Webhooks Collections Not Null	2025-09-19 16:48:00.546875+00
20210910A	Move Module Setup	2025-09-19 16:48:00.548907+00
20210920A	Webhooks URL Not Null	2025-09-19 16:48:00.553738+00
20210924A	Add Collection Organization	2025-09-19 16:48:00.557557+00
20210927A	Replace Fields Group	2025-09-19 16:48:00.563121+00
20210927B	Replace M2M Interface	2025-09-19 16:48:00.564834+00
20210929A	Rename Login Action	2025-09-19 16:48:00.566264+00
20211007A	Update Presets	2025-09-19 16:48:00.570994+00
20211009A	Add Auth Data	2025-09-19 16:48:00.572597+00
20211016A	Add Webhook Headers	2025-09-19 16:48:00.574058+00
20211103A	Set Unique to User Token	2025-09-19 16:48:00.576454+00
20211103B	Update Special Geometry	2025-09-19 16:48:00.577901+00
20211104A	Remove Collections Listing	2025-09-19 16:48:00.579346+00
20211118A	Add Notifications	2025-09-19 16:48:00.58886+00
20211211A	Add Shares	2025-09-19 16:48:00.5998+00
20211230A	Add Project Descriptor	2025-09-19 16:48:00.602182+00
20220303A	Remove Default Project Color	2025-09-19 16:48:00.606454+00
20220308A	Add Bookmark Icon and Color	2025-09-19 16:48:00.608259+00
20220314A	Add Translation Strings	2025-09-19 16:48:00.609937+00
20220322A	Rename Field Typecast Flags	2025-09-19 16:48:00.61288+00
20220323A	Add Field Validation	2025-09-19 16:48:00.614449+00
20220325A	Fix Typecast Flags	2025-09-19 16:48:00.618463+00
20220325B	Add Default Language	2025-09-19 16:48:00.624109+00
20220402A	Remove Default Value Panel Icon	2025-09-19 16:48:00.628382+00
20220429A	Add Flows	2025-09-19 16:48:00.644965+00
20220429B	Add Color to Insights Icon	2025-09-19 16:48:00.646885+00
20220429C	Drop Non Null From IP of Activity	2025-09-19 16:48:00.6484+00
20220429D	Drop Non Null From Sender of Notifications	2025-09-19 16:48:00.650022+00
20220614A	Rename Hook Trigger to Event	2025-09-19 16:48:00.651919+00
20220801A	Update Notifications Timestamp Column	2025-09-19 16:48:00.655933+00
20220802A	Add Custom Aspect Ratios	2025-09-19 16:48:00.657403+00
20220826A	Add Origin to Accountability	2025-09-19 16:48:00.659323+00
20230401A	Update Material Icons	2025-09-19 16:48:00.663478+00
20230525A	Add Preview Settings	2025-09-19 16:48:00.664981+00
20230526A	Migrate Translation Strings	2025-09-19 16:48:00.672168+00
20230721A	Require Shares Fields	2025-09-19 16:48:00.676162+00
20230823A	Add Content Versioning	2025-09-19 16:48:00.688789+00
20230927A	Themes	2025-09-19 16:48:00.696257+00
20231009A	Update CSV Fields to Text	2025-09-19 16:48:00.700328+00
20231009B	Update Panel Options	2025-09-19 16:48:00.702897+00
20231010A	Add Extensions	2025-09-19 16:48:00.706254+00
20231215A	Add Focalpoints	2025-09-19 16:48:00.708319+00
20240122A	Add Report URL Fields	2025-09-19 16:48:00.709905+00
20240204A	Marketplace	2025-09-19 16:48:00.722081+00
20240305A	Change Useragent Type	2025-09-19 16:48:00.727884+00
20240311A	Deprecate Webhooks	2025-09-19 16:48:00.73356+00
20240422A	Public Registration	2025-09-19 16:48:00.737543+00
20240515A	Add Session Window	2025-09-19 16:48:00.739257+00
20240701A	Add Tus Data	2025-09-19 16:48:00.741061+00
20240716A	Update Files Date Fields	2025-09-19 16:48:00.745299+00
20240806A	Permissions Policies	2025-09-19 16:48:00.767502+00
20240817A	Update Icon Fields Length	2025-09-19 16:48:00.78037+00
20240909A	Separate Comments	2025-09-19 16:48:00.788864+00
20240909B	Consolidate Content Versioning	2025-09-19 16:48:00.791029+00
20240924A	Migrate Legacy Comments	2025-09-19 16:48:00.794727+00
20240924B	Populate Versioning Deltas	2025-09-19 16:48:00.797764+00
20250224A	Visual Editor	2025-09-19 16:48:00.800357+00
20250609A	License Banner	2025-09-19 16:48:00.804326+00
20250613A	Add Project ID	2025-09-19 16:48:00.812016+00
20250718A	Add Direction	2025-09-19 16:48:00.813656+00
20250813A	Add MCP	2025-09-19 21:10:10.357248+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_permissions (id, collection, action, permissions, validation, presets, fields, policy) FROM stdin;
\.


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
8225d704-c297-4fef-9291-148737393e0c	Administrator	verified	$t:admin_description	\N	f	t	t
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
2	\N	9587e47d-af93-4ba4-8de3-3de9831b4305	\N	enterprise_tags	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
1	\N	9587e47d-af93-4ba4-8de3-3de9831b4305	\N	enterprises	\N	tabular	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
31	enterprises_keywords	enterprises_id	enterprises	keywords	\N	\N	keywords_id	\N	nullify
32	enterprises_keywords	keywords_id	keywords	\N	\N	\N	enterprises_id	\N	nullify
33	enterprises_locations	enterprises_id	enterprises	locations	\N	\N	locations_id	\N	nullify
34	enterprises_locations	locations_id	locations	\N	\N	\N	enterprises_id	\N	nullify
35	enterprises_technologies	enterprises_id	enterprises	technologies	\N	\N	technologies_id	\N	nullify
36	enterprises_technologies	technologies_id	technologies	\N	\N	\N	enterprises_id	\N	nullify
37	people_keywords	keywords_id	keywords	\N	\N	\N	people_id	\N	nullify
38	people_keywords	people_id	people	keywords	\N	\N	keywords_id	\N	nullify
39	people_technologies	people_id	people	technologies	\N	\N	technologies_id	\N	nullify
40	people_technologies	technologies_id	technologies	\N	\N	\N	people_id	\N	nullify
41	people	location_id	locations	\N	\N	\N	\N	\N	nullify
42	segments	industry_id	industries	\N	\N	\N	\N	\N	nullify
43	person_employment_history	person_id	people	\N	\N	\N	\N	\N	nullify
44	person_employment_history	enterprise_id	enterprises	\N	\N	\N	\N	\N	nullify
45	person_employment_history	position_id	positions	\N	\N	\N	\N	\N	nullify
46	enterprises_industries	industries_id	industries	\N	\N	\N	enterprises_id	\N	nullify
47	enterprises_industries	enterprises_id	enterprises	industries	\N	\N	industries_id	\N	nullify
50	enterprises_tags	enterprises_id	enterprises	\N	\N	\N	tag_id	\N	nullify
51	enterprises_tags	tag_id	enterprise_tags	\N	\N	\N	enterprises_id	\N	nullify
52	people	enterprise_relation_id	enterprises	\N	\N	\N	\N	\N	nullify
55	people_tags	person_id	people	tags	\N	\N	tag_id	\N	nullify
56	people_tags	tag_id	enterprise_tags	\N	\N	\N	person_id	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	3	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"accepted_terms":true,"project_id":"019962e0-252b-71fa-bdac-8f160d5af4db"}	{"accepted_terms":true}	\N	\N
2	5	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	{"id":"9587e47d-af93-4ba4-8de3-3de9831b4305","first_name":"Admin","last_name":"User","email":"jeholguin@increnta.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"d5a3b569-26d9-4a9c-8213-4d0590840676","token":"**********","last_access":"2025-09-19T17:28:18.057Z","last_page":"/users/9587e47d-af93-4ba4-8de3-3de9831b4305","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"token":"**********"}	\N	\N
3	7	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	{"id":"9587e47d-af93-4ba4-8de3-3de9831b4305","first_name":"Admin","last_name":"User","email":"jeholguin@increnta.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"d5a3b569-26d9-4a9c-8213-4d0590840676","token":"**********","last_access":"2025-09-19T20:40:18.666Z","last_page":"/users/9587e47d-af93-4ba4-8de3-3de9831b4305","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"token":"**********"}	\N	\N
4	8	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	{"id":"9587e47d-af93-4ba4-8de3-3de9831b4305","first_name":"Admin","last_name":"User","email":"jeholguin@increnta.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"d5a3b569-26d9-4a9c-8213-4d0590840676","token":"**********","last_access":"2025-09-19T20:40:18.666Z","last_page":"/users/9587e47d-af93-4ba4-8de3-3de9831b4305","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"token":"**********"}	\N	\N
5	9	directus_collections	Categories	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"Categories","color":null,"display_template":null,"group":null,"hidden":false,"icon":"folder","item_duplication_fields":null,"note":null,"preview_url":null,"singleton":false,"sort":1,"sort_field":null,"translations":null,"unarchive_value":null,"versioning":false}	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"Categories","color":null,"display_template":null,"group":null,"hidden":false,"icon":"folder","item_duplication_fields":null,"note":null,"preview_url":null,"singleton":false,"sort":1,"sort_field":null,"translations":null,"unarchive_value":null,"versioning":false}	\N	\N
6	10	directus_fields	436	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"industries"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"industries"}	\N	\N
7	11	directus_collections	industries	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"industries","color":null,"display_template":"{{name}}","group":"Categories","hidden":false,"icon":"factory","item_duplication_fields":null,"note":"Colección para gestionar industrias del CRM","preview_url":null,"singleton":false,"sort":2,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"industries","color":null,"display_template":"{{name}}","group":"Categories","hidden":false,"icon":"factory","item_duplication_fields":null,"note":"Colección para gestionar industrias del CRM","preview_url":null,"singleton":false,"sort":2,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	\N	\N
8	12	directus_fields	437	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"keywords"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"keywords"}	\N	\N
9	13	directus_collections	keywords	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"keywords","color":"#FFF700","display_template":"{{name}}","group":"Categories","hidden":false,"icon":"label","item_duplication_fields":null,"note":"Colección para gestionar palabras clave del CRM","preview_url":null,"singleton":false,"sort":4,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"keywords","color":"#FFF700","display_template":"{{name}}","group":"Categories","hidden":false,"icon":"label","item_duplication_fields":null,"note":"Colección para gestionar palabras clave del CRM","preview_url":null,"singleton":false,"sort":4,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	\N	\N
10	14	directus_fields	438	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"technologies"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"technologies"}	\N	\N
11	15	directus_collections	technologies	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"technologies","color":null,"display_template":"{{name}}","group":"Categories","hidden":false,"icon":"memory","item_duplication_fields":null,"note":"Colección para gestionar tecnologías del CRM","preview_url":null,"singleton":false,"sort":3,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"technologies","color":null,"display_template":"{{name}}","group":"Categories","hidden":false,"icon":"memory","item_duplication_fields":null,"note":"Colección para gestionar tecnologías del CRM","preview_url":null,"singleton":false,"sort":3,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	\N	\N
154	172	enterprises_industries	2	{"enterprises_id":2,"industries_id":1}	{"enterprises_id":2,"industries_id":1}	\N	\N
12	16	directus_fields	439	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"positions"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"positions"}	\N	\N
13	17	directus_collections	positions	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"positions","color":null,"display_template":"{{name}}","group":"Categories","hidden":false,"icon":"work","item_duplication_fields":null,"note":"Colección para gestionar cargos/posiciones laborales del CRM","preview_url":null,"singleton":false,"sort":1,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"positions","color":null,"display_template":"{{name}}","group":"Categories","hidden":false,"icon":"work","item_duplication_fields":null,"note":"Colección para gestionar cargos/posiciones laborales del CRM","preview_url":null,"singleton":false,"sort":1,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	\N	\N
14	18	directus_fields	440	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"locations"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"locations"}	\N	\N
15	19	directus_collections	locations	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"locations","color":"#E35169","display_template":"{{country}} - {{province}} - {{city}}","group":"Categories","hidden":false,"icon":"location_on","item_duplication_fields":null,"note":"Colección para gestionar ubicaciones geográficas del CRM","preview_url":null,"singleton":false,"sort":5,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"locations","color":"#E35169","display_template":"{{country}} - {{province}} - {{city}}","group":"Categories","hidden":false,"icon":"location_on","item_duplication_fields":null,"note":"Colección para gestionar ubicaciones geográficas del CRM","preview_url":null,"singleton":false,"sort":5,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	\N	\N
16	20	directus_fields	441	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"segments"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"segments"}	\N	\N
17	21	directus_collections	segments	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"segments","color":null,"display_template":"{{name}}","group":null,"hidden":false,"icon":"category","item_duplication_fields":null,"note":"Colección para gestionar segmentos del CRM","preview_url":null,"singleton":false,"sort":3,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"segments","color":null,"display_template":"{{name}}","group":null,"hidden":false,"icon":"category","item_duplication_fields":null,"note":"Colección para gestionar segmentos del CRM","preview_url":null,"singleton":false,"sort":3,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	\N	\N
18	22	directus_fields	442	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"people"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"people"}	\N	\N
19	23	directus_collections	people	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"people","color":null,"display_template":"{{name}}","group":null,"hidden":false,"icon":"group","item_duplication_fields":null,"note":"Colección para gestionar personas del CRM","preview_url":null,"singleton":false,"sort":2,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"people","color":null,"display_template":"{{name}}","group":null,"hidden":false,"icon":"group","item_duplication_fields":null,"note":"Colección para gestionar personas del CRM","preview_url":null,"singleton":false,"sort":2,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	\N	\N
20	24	directus_fields	443	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"enterprises"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"enterprises"}	\N	\N
21	25	directus_collections	enterprises	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"enterprises","color":null,"display_template":"{{name}}","group":null,"hidden":false,"icon":"business","item_duplication_fields":null,"note":"Colección para gestionar empresas del CRM","preview_url":null,"singleton":false,"sort":4,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"enterprises","color":null,"display_template":"{{name}}","group":null,"hidden":false,"icon":"business","item_duplication_fields":null,"note":"Colección para gestionar empresas del CRM","preview_url":null,"singleton":false,"sort":4,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	\N	\N
22	26	directus_fields	444	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"people_keywords"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"people_keywords"}	\N	\N
23	27	directus_collections	people_keywords	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"people_keywords","color":null,"display_template":null,"group":null,"hidden":true,"icon":"import_export","item_duplication_fields":null,"note":null,"preview_url":null,"singleton":false,"sort":9,"sort_field":null,"translations":null,"unarchive_value":null,"versioning":false}	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"people_keywords","color":null,"display_template":null,"group":null,"hidden":true,"icon":"import_export","item_duplication_fields":null,"note":null,"preview_url":null,"singleton":false,"sort":9,"sort_field":null,"translations":null,"unarchive_value":null,"versioning":false}	\N	\N
24	28	directus_fields	445	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"people_technologies"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"people_technologies"}	\N	\N
155	173	keywords	4	{"name":"software development"}	{"name":"software development"}	\N	\N
156	174	enterprises_keywords	1	{"enterprises_id":2,"keywords_id":4}	{"enterprises_id":2,"keywords_id":4}	\N	\N
157	175	technologies	4	{"name":"PHP"}	{"name":"PHP"}	\N	\N
158	176	enterprises_technologies	1	{"enterprises_id":2,"technologies_id":4}	{"enterprises_id":2,"technologies_id":4}	\N	\N
25	29	directus_collections	people_technologies	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"people_technologies","color":null,"display_template":null,"group":null,"hidden":true,"icon":"import_export","item_duplication_fields":null,"note":null,"preview_url":null,"singleton":false,"sort":10,"sort_field":null,"translations":null,"unarchive_value":null,"versioning":false}	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"people_technologies","color":null,"display_template":null,"group":null,"hidden":true,"icon":"import_export","item_duplication_fields":null,"note":null,"preview_url":null,"singleton":false,"sort":10,"sort_field":null,"translations":null,"unarchive_value":null,"versioning":false}	\N	\N
26	30	directus_fields	446	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"enterprises_keywords"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"enterprises_keywords"}	\N	\N
27	31	directus_collections	enterprises_keywords	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"enterprises_keywords","color":null,"display_template":null,"group":null,"hidden":true,"icon":"import_export","item_duplication_fields":null,"note":null,"preview_url":null,"singleton":false,"sort":6,"sort_field":null,"translations":null,"unarchive_value":null,"versioning":false}	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"enterprises_keywords","color":null,"display_template":null,"group":null,"hidden":true,"icon":"import_export","item_duplication_fields":null,"note":null,"preview_url":null,"singleton":false,"sort":6,"sort_field":null,"translations":null,"unarchive_value":null,"versioning":false}	\N	\N
28	32	directus_fields	447	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"enterprises_locations"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"enterprises_locations"}	\N	\N
29	33	directus_collections	enterprises_locations	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"enterprises_locations","color":null,"display_template":null,"group":null,"hidden":true,"icon":"import_export","item_duplication_fields":null,"note":null,"preview_url":null,"singleton":false,"sort":7,"sort_field":null,"translations":null,"unarchive_value":null,"versioning":false}	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"enterprises_locations","color":null,"display_template":null,"group":null,"hidden":true,"icon":"import_export","item_duplication_fields":null,"note":null,"preview_url":null,"singleton":false,"sort":7,"sort_field":null,"translations":null,"unarchive_value":null,"versioning":false}	\N	\N
30	34	directus_fields	448	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"enterprises_technologies"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"enterprises_technologies"}	\N	\N
31	35	directus_collections	enterprises_technologies	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"enterprises_technologies","color":null,"display_template":null,"group":null,"hidden":true,"icon":"import_export","item_duplication_fields":null,"note":null,"preview_url":null,"singleton":false,"sort":8,"sort_field":null,"translations":null,"unarchive_value":null,"versioning":false}	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"enterprises_technologies","color":null,"display_template":null,"group":null,"hidden":true,"icon":"import_export","item_duplication_fields":null,"note":null,"preview_url":null,"singleton":false,"sort":8,"sort_field":null,"translations":null,"unarchive_value":null,"versioning":false}	\N	\N
32	36	directus_fields	449	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"person_employment_history"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"person_employment_history"}	\N	\N
33	37	directus_collections	person_employment_history	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"person_employment_history","color":null,"display_template":"{{id}}","group":null,"hidden":false,"icon":"work_history","item_duplication_fields":null,"note":"Historial laboral de las personas - relación entre persona, empresa y posición","preview_url":null,"singleton":false,"sort":5,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	{"accountability":"all","archive_app_filter":true,"archive_field":null,"archive_value":null,"collapse":"open","collection":"person_employment_history","color":null,"display_template":"{{id}}","group":null,"hidden":false,"icon":"work_history","item_duplication_fields":null,"note":"Historial laboral de las personas - relación entre persona, empresa y posición","preview_url":null,"singleton":false,"sort":5,"sort_field":"id","translations":null,"unarchive_value":null,"versioning":false}	\N	\N
34	38	directus_fields	450	{"sort":12,"collection":"enterprises","conditions":null,"display":"formatted-value","display_options":null,"field":"about","group":null,"hidden":false,"interface":"input-multiline","note":"Descripción de la empresa","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":12,"collection":"enterprises","conditions":null,"display":"formatted-value","display_options":null,"field":"about","group":null,"hidden":false,"interface":"input-multiline","note":"Descripción de la empresa","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
35	39	directus_fields	451	{"sort":13,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"annual_revenue","group":null,"hidden":false,"interface":"input","note":"Ingresos anuales","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":13,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"annual_revenue","group":null,"hidden":false,"interface":"input","note":"Ingresos anuales","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
46	50	directus_fields	462	{"sort":3,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"name","group":null,"hidden":false,"interface":"input","note":"Nombre de la empresa","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":3,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"name","group":null,"hidden":false,"interface":"input","note":"Nombre de la empresa","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
36	40	directus_fields	452	{"sort":15,"collection":"enterprises","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de creación","options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":15,"collection":"enterprises","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de creación","options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
37	41	directus_fields	453	{"sort":5,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"email","group":null,"hidden":false,"interface":"input","note":"Email de la empresa","options":{"iconLeft":"alternate_email"},"readonly":false,"required":false,"special":null,"translations":null,"validation":{"_and":[{"email":{}}]},"validation_message":null,"width":"half"}	{"sort":5,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"email","group":null,"hidden":false,"interface":"input","note":"Email de la empresa","options":{"iconLeft":"alternate_email"},"readonly":false,"required":false,"special":null,"translations":null,"validation":{"_and":[{"email":{}}]},"validation_message":null,"width":"half"}	\N	\N
38	42	directus_fields	454	{"sort":7,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"employs","group":null,"hidden":false,"interface":"input","note":"Número de empleados","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":7,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"employs","group":null,"hidden":false,"interface":"input","note":"Número de empleados","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
39	43	directus_fields	455	{"sort":9,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"facebook","group":null,"hidden":false,"interface":"input","note":"URL de Facebook","options":{"iconLeft":"facebook"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"third"}	{"sort":9,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"facebook","group":null,"hidden":false,"interface":"input","note":"URL de Facebook","options":{"iconLeft":"facebook"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"third"}	\N	\N
40	44	directus_fields	456	{"sort":14,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"founded_year","group":null,"hidden":false,"interface":"input","note":"Año de fundación","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":14,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"founded_year","group":null,"hidden":false,"interface":"input","note":"Año de fundación","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
41	45	directus_fields	457	{"sort":6,"collection":"enterprises","conditions":null,"display":"image","display_options":null,"field":"image","group":null,"hidden":false,"interface":"file-image","note":"Logo de la empresa","options":null,"readonly":false,"required":false,"special":["file"],"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":6,"collection":"enterprises","conditions":null,"display":"image","display_options":null,"field":"image","group":null,"hidden":false,"interface":"file-image","note":"Logo de la empresa","options":null,"readonly":false,"required":false,"special":["file"],"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
42	46	directus_fields	458	{"sort":8,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"industry","group":null,"hidden":false,"interface":"input","note":"Industria de la empresa","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":8,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"industry","group":null,"hidden":false,"interface":"input","note":"Industria de la empresa","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
43	47	directus_fields	459	{"sort":18,"collection":"enterprises","conditions":null,"display":null,"display_options":null,"field":"keywords","group":null,"hidden":false,"interface":"list-m2m","note":null,"options":null,"readonly":false,"required":false,"special":["m2m"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":18,"collection":"enterprises","conditions":null,"display":null,"display_options":null,"field":"keywords","group":null,"hidden":false,"interface":"list-m2m","note":null,"options":null,"readonly":false,"required":false,"special":["m2m"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
44	48	directus_fields	460	{"sort":10,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"linkedin","group":null,"hidden":false,"interface":"input","note":"URL de LinkedIn","options":{"iconLeft":"link"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"third"}	{"sort":10,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"linkedin","group":null,"hidden":false,"interface":"input","note":"URL de LinkedIn","options":{"iconLeft":"link"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"third"}	\N	\N
45	49	directus_fields	461	{"sort":19,"collection":"enterprises","conditions":null,"display":null,"display_options":null,"field":"locations","group":null,"hidden":false,"interface":"list-m2m","note":null,"options":null,"readonly":false,"required":false,"special":["m2m"],"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":19,"collection":"enterprises","conditions":null,"display":null,"display_options":null,"field":"locations","group":null,"hidden":false,"interface":"list-m2m","note":null,"options":null,"readonly":false,"required":false,"special":["m2m"],"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
159	177	people	5	{"name":"TechCorp"}	{"name":"TechCorp"}	\N	\N
160	178	person_employment_history	3	{"person_id":5,"enterprise_id":2,"is_current":true}	{"person_id":5,"enterprise_id":2,"is_current":true}	\N	\N
47	51	directus_fields	463	{"sort":2,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"nit","group":null,"hidden":false,"interface":"input","note":"NIT de la empresa","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":2,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"nit","group":null,"hidden":false,"interface":"input","note":"NIT de la empresa","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
48	52	directus_fields	464	{"sort":4,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"phone","group":null,"hidden":false,"interface":"input","note":"Teléfono de la empresa","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":4,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"phone","group":null,"hidden":false,"interface":"input","note":"Teléfono de la empresa","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
49	53	directus_fields	465	{"sort":17,"collection":"enterprises","conditions":null,"display":null,"display_options":null,"field":"technologies","group":null,"hidden":false,"interface":"list-m2m","note":null,"options":null,"readonly":false,"required":false,"special":["m2m"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":17,"collection":"enterprises","conditions":null,"display":null,"display_options":null,"field":"technologies","group":null,"hidden":false,"interface":"list-m2m","note":null,"options":null,"readonly":false,"required":false,"special":["m2m"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
50	54	directus_fields	466	{"sort":11,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"twitter","group":null,"hidden":false,"interface":"input","note":"URL de Twitter","options":{"iconLeft":"alternate_email"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"third"}	{"sort":11,"collection":"enterprises","conditions":null,"display":"raw","display_options":null,"field":"twitter","group":null,"hidden":false,"interface":"input","note":"URL de Twitter","options":{"iconLeft":"alternate_email"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"third"}	\N	\N
51	55	directus_fields	467	{"sort":16,"collection":"enterprises","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de última actualización","options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":16,"collection":"enterprises","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de última actualización","options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
52	56	directus_fields	468	{"sort":2,"collection":"enterprises_keywords","conditions":null,"display":null,"display_options":null,"field":"enterprises_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":2,"collection":"enterprises_keywords","conditions":null,"display":null,"display_options":null,"field":"enterprises_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
53	57	directus_fields	469	{"sort":3,"collection":"enterprises_keywords","conditions":null,"display":null,"display_options":null,"field":"keywords_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":3,"collection":"enterprises_keywords","conditions":null,"display":null,"display_options":null,"field":"keywords_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
54	58	directus_fields	470	{"sort":2,"collection":"enterprises_locations","conditions":null,"display":null,"display_options":null,"field":"enterprises_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":2,"collection":"enterprises_locations","conditions":null,"display":null,"display_options":null,"field":"enterprises_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
55	59	directus_fields	471	{"sort":3,"collection":"enterprises_locations","conditions":null,"display":null,"display_options":null,"field":"locations_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":3,"collection":"enterprises_locations","conditions":null,"display":null,"display_options":null,"field":"locations_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
56	60	directus_fields	472	{"sort":2,"collection":"enterprises_technologies","conditions":null,"display":null,"display_options":null,"field":"enterprises_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":2,"collection":"enterprises_technologies","conditions":null,"display":null,"display_options":null,"field":"enterprises_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
77	81	directus_fields	493	{"sort":2,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"name","group":null,"hidden":false,"interface":"input","note":null,"options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":2,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"name","group":null,"hidden":false,"interface":"input","note":null,"options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
57	61	directus_fields	473	{"sort":3,"collection":"enterprises_technologies","conditions":null,"display":null,"display_options":null,"field":"technologies_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":3,"collection":"enterprises_technologies","conditions":null,"display":null,"display_options":null,"field":"technologies_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
58	62	directus_fields	474	{"sort":3,"collection":"industries","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de creación","options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":3,"collection":"industries","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de creación","options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
59	63	directus_fields	475	{"sort":2,"collection":"industries","conditions":null,"display":"raw","display_options":null,"field":"name","group":null,"hidden":false,"interface":"input","note":"Nombre de la industria","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":2,"collection":"industries","conditions":null,"display":"raw","display_options":null,"field":"name","group":null,"hidden":false,"interface":"input","note":"Nombre de la industria","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
60	64	directus_fields	476	{"sort":4,"collection":"industries","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de última actualización","options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":4,"collection":"industries","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de última actualización","options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
61	65	directus_fields	477	{"sort":3,"collection":"keywords","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de creación","options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":3,"collection":"keywords","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de creación","options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
62	66	directus_fields	478	{"sort":2,"collection":"keywords","conditions":null,"display":"raw","display_options":null,"field":"name","group":null,"hidden":false,"interface":"input","note":"Nombre de la palabra clave","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":2,"collection":"keywords","conditions":null,"display":"raw","display_options":null,"field":"name","group":null,"hidden":false,"interface":"input","note":"Nombre de la palabra clave","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
63	67	directus_fields	479	{"sort":4,"collection":"keywords","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de última actualización","options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":4,"collection":"keywords","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de última actualización","options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
64	68	directus_fields	480	{"sort":4,"collection":"locations","conditions":null,"display":"raw","display_options":null,"field":"city","group":null,"hidden":false,"interface":"input","note":"Ciudad","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":4,"collection":"locations","conditions":null,"display":"raw","display_options":null,"field":"city","group":null,"hidden":false,"interface":"input","note":"Ciudad","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
65	69	directus_fields	481	{"sort":2,"collection":"locations","conditions":null,"display":"raw","display_options":null,"field":"country","group":null,"hidden":false,"interface":"input","note":"País","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":2,"collection":"locations","conditions":null,"display":"raw","display_options":null,"field":"country","group":null,"hidden":false,"interface":"input","note":"País","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
66	70	directus_fields	482	{"sort":5,"collection":"locations","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de creación","options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":5,"collection":"locations","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de creación","options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
67	71	directus_fields	483	{"sort":3,"collection":"locations","conditions":null,"display":"raw","display_options":null,"field":"province","group":null,"hidden":false,"interface":"input","note":"Provincia/Estado","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":3,"collection":"locations","conditions":null,"display":"raw","display_options":null,"field":"province","group":null,"hidden":false,"interface":"input","note":"Provincia/Estado","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
68	72	directus_fields	484	{"sort":6,"collection":"locations","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de última actualización","options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":6,"collection":"locations","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de última actualización","options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
69	73	directus_fields	485	{"sort":8,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"about","group":null,"hidden":false,"interface":"input-multiline","note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":8,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"about","group":null,"hidden":false,"interface":"input-multiline","note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
70	74	directus_fields	486	{"sort":10,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"age","group":null,"hidden":false,"interface":"input","note":null,"options":{"max":120,"min":0},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":10,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"age","group":null,"hidden":false,"interface":"input","note":null,"options":{"max":120,"min":0},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
71	75	directus_fields	487	{"sort":6,"collection":"people","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":false,"interface":"datetime","note":null,"options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":6,"collection":"people","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":false,"interface":"datetime","note":null,"options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
72	76	directus_fields	488	{"sort":4,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"email","group":null,"hidden":false,"interface":"input","note":null,"options":{"placeholder":"example@domain.com"},"readonly":false,"required":false,"special":null,"translations":null,"validation":{"_and":[{"email":{}}]},"validation_message":"Debe ser un email válido","width":"half"}	{"sort":4,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"email","group":null,"hidden":false,"interface":"input","note":null,"options":{"placeholder":"example@domain.com"},"readonly":false,"required":false,"special":null,"translations":null,"validation":{"_and":[{"email":{}}]},"validation_message":"Debe ser un email válido","width":"half"}	\N	\N
73	77	directus_fields	489	{"sort":3,"collection":"people","conditions":null,"display":"image","display_options":null,"field":"image","group":null,"hidden":false,"interface":"file-image","note":null,"options":null,"readonly":false,"required":false,"special":["file"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":3,"collection":"people","conditions":null,"display":"image","display_options":null,"field":"image","group":null,"hidden":false,"interface":"file-image","note":null,"options":null,"readonly":false,"required":false,"special":["file"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
74	78	directus_fields	490	{"sort":14,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"keywords","group":null,"hidden":false,"interface":"list-m2m","note":null,"options":{},"readonly":false,"required":false,"special":["m2m"],"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":14,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"keywords","group":null,"hidden":false,"interface":"list-m2m","note":null,"options":{},"readonly":false,"required":false,"special":["m2m"],"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
75	79	directus_fields	491	{"sort":7,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"linkedin","group":null,"hidden":false,"interface":"input","note":null,"options":{"placeholder":"https://linkedin.com/in/usuario"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":7,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"linkedin","group":null,"hidden":false,"interface":"input","note":null,"options":{"placeholder":"https://linkedin.com/in/usuario"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
76	80	directus_fields	492	{"sort":12,"collection":"people","conditions":null,"display":"related-values","display_options":{"template":"{{city}}, {{province}}, {{country}}"},"field":"location_id","group":null,"hidden":false,"interface":"select-dropdown-m2o","note":null,"options":{"template":"{{city}}, {{province}}, {{country}}"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":12,"collection":"people","conditions":null,"display":"related-values","display_options":{"template":"{{city}}, {{province}}, {{country}}"},"field":"location_id","group":null,"hidden":false,"interface":"select-dropdown-m2o","note":null,"options":{"template":"{{city}}, {{province}}, {{country}}"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
161	179	enterprises	3	{"nit":"987654321","name":"InnovateSA","phone":"+57602345678","email":"contact@innovate.com","linkedin":"linkedin.com/company/innovate","founded_year":"2015"}	{"nit":"987654321","name":"InnovateSA","phone":"+57602345678","email":"contact@innovate.com","linkedin":"linkedin.com/company/innovate","founded_year":"2015"}	\N	\N
78	82	directus_fields	494	{"sort":6,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"office_number","group":null,"hidden":false,"interface":"input","note":null,"options":{"placeholder":"+1234567890"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":6,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"office_number","group":null,"hidden":false,"interface":"input","note":null,"options":{"placeholder":"+1234567890"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
79	83	directus_fields	495	{"sort":5,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"personal_phone","group":null,"hidden":false,"interface":"input","note":null,"options":{"placeholder":"+1234567890"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":5,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"personal_phone","group":null,"hidden":false,"interface":"input","note":null,"options":{"placeholder":"+1234567890"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
80	84	directus_fields	496	{"sort":5,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"phone","group":null,"hidden":false,"interface":"input","note":null,"options":{"placeholder":"+1234567890"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":5,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"phone","group":null,"hidden":false,"interface":"input","note":null,"options":{"placeholder":"+1234567890"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
81	85	directus_fields	497	{"sort":9,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"sex","group":null,"hidden":false,"interface":"select-dropdown","note":null,"options":{"choices":[{"text":"Masculino","value":"M"},{"text":"Femenino","value":"F"},{"text":"Otro","value":"O"}]},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":9,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"sex","group":null,"hidden":false,"interface":"select-dropdown","note":null,"options":{"choices":[{"text":"Masculino","value":"M"},{"text":"Femenino","value":"F"},{"text":"Otro","value":"O"}]},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
82	86	directus_fields	498	{"sort":13,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"technologies","group":null,"hidden":false,"interface":"list-m2m","note":null,"options":null,"readonly":false,"required":false,"special":["m2m"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":13,"collection":"people","conditions":null,"display":null,"display_options":null,"field":"technologies","group":null,"hidden":false,"interface":"list-m2m","note":null,"options":null,"readonly":false,"required":false,"special":["m2m"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
83	87	directus_fields	499	{"sort":7,"collection":"people","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":false,"interface":"datetime","note":null,"options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":7,"collection":"people","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":false,"interface":"datetime","note":null,"options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
84	88	directus_fields	500	{"sort":3,"collection":"people_keywords","conditions":null,"display":null,"display_options":null,"field":"keywords_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":3,"collection":"people_keywords","conditions":null,"display":null,"display_options":null,"field":"keywords_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
85	89	directus_fields	501	{"sort":2,"collection":"people_keywords","conditions":null,"display":null,"display_options":null,"field":"people_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":2,"collection":"people_keywords","conditions":null,"display":null,"display_options":null,"field":"people_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
86	90	directus_fields	502	{"sort":2,"collection":"people_technologies","conditions":null,"display":null,"display_options":null,"field":"people_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":2,"collection":"people_technologies","conditions":null,"display":null,"display_options":null,"field":"people_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
87	91	directus_fields	503	{"sort":3,"collection":"people_technologies","conditions":null,"display":null,"display_options":null,"field":"technologies_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":3,"collection":"people_technologies","conditions":null,"display":null,"display_options":null,"field":"technologies_id","group":null,"hidden":true,"interface":null,"note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
151	164	enterprises	1	{"id":1,"about":null,"annual_revenue":null,"created_at":"2025-09-19T21:47:31.484Z","email":null,"employs":null,"facebook":null,"founded_year":null,"image":null,"linkedin":null,"name":"Tech Solutions Inc","nit":null,"phone":null,"twitter":null,"updated_at":"2025-09-19T23:00:13.254Z","keywords":[],"locations":[],"technologies":[],"industries":[1]}	{"updated_at":"2025-09-19T23:00:13.254Z"}	\N	\N
162	180	industries	2	{"name":"Consultoría"}	{"name":"Consultoría"}	\N	\N
88	92	directus_fields	504	{"sort":8,"collection":"person_employment_history","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":false,"interface":"datetime","note":null,"options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":8,"collection":"person_employment_history","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":false,"interface":"datetime","note":null,"options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
89	93	directus_fields	505	{"sort":7,"collection":"person_employment_history","conditions":null,"display":"datetime","display_options":{"format":"YYYY-MM-DD"},"field":"end_date","group":null,"hidden":false,"interface":"datetime","note":null,"options":{"includeSeconds":false},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":7,"collection":"person_employment_history","conditions":null,"display":"datetime","display_options":{"format":"YYYY-MM-DD"},"field":"end_date","group":null,"hidden":false,"interface":"datetime","note":null,"options":{"includeSeconds":false},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
90	94	directus_fields	506	{"sort":3,"collection":"person_employment_history","conditions":null,"display":"related-values","display_options":{"template":"{{nit}}"},"field":"enterprise_id","group":null,"hidden":false,"interface":"select-dropdown-m2o","note":null,"options":{"template":"{{name}}"},"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":3,"collection":"person_employment_history","conditions":null,"display":"related-values","display_options":{"template":"{{nit}}"},"field":"enterprise_id","group":null,"hidden":false,"interface":"select-dropdown-m2o","note":null,"options":{"template":"{{name}}"},"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
91	95	directus_fields	507	{"sort":5,"collection":"person_employment_history","conditions":null,"display":"boolean","display_options":null,"field":"is_current","group":null,"hidden":false,"interface":"boolean","note":"Indica si es el trabajo actual","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":5,"collection":"person_employment_history","conditions":null,"display":"boolean","display_options":null,"field":"is_current","group":null,"hidden":false,"interface":"boolean","note":"Indica si es el trabajo actual","options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
92	96	directus_fields	508	{"sort":2,"collection":"person_employment_history","conditions":null,"display":"related-values","display_options":{"template":"{{name}}"},"field":"person_id","group":null,"hidden":false,"interface":"select-dropdown-m2o","note":null,"options":{"template":"{{name}}"},"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":2,"collection":"person_employment_history","conditions":null,"display":"related-values","display_options":{"template":"{{name}}"},"field":"person_id","group":null,"hidden":false,"interface":"select-dropdown-m2o","note":null,"options":{"template":"{{name}}"},"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
93	97	directus_fields	509	{"sort":4,"collection":"person_employment_history","conditions":null,"display":"related-values","display_options":{"template":"{{name}}"},"field":"position_id","group":null,"hidden":false,"interface":"select-dropdown-m2o","note":null,"options":{"template":"{{name}}"},"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":4,"collection":"person_employment_history","conditions":null,"display":"related-values","display_options":{"template":"{{name}}"},"field":"position_id","group":null,"hidden":false,"interface":"select-dropdown-m2o","note":null,"options":{"template":"{{name}}"},"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
94	98	directus_fields	510	{"sort":6,"collection":"person_employment_history","conditions":null,"display":"datetime","display_options":{"format":"YYYY-MM-DD"},"field":"start_date","group":null,"hidden":false,"interface":"datetime","note":null,"options":{"includeSeconds":false},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":6,"collection":"person_employment_history","conditions":null,"display":"datetime","display_options":{"format":"YYYY-MM-DD"},"field":"start_date","group":null,"hidden":false,"interface":"datetime","note":null,"options":{"includeSeconds":false},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
95	99	directus_fields	511	{"sort":9,"collection":"person_employment_history","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":false,"interface":"datetime","note":null,"options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":9,"collection":"person_employment_history","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":false,"interface":"datetime","note":null,"options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
96	100	directus_fields	512	{"sort":3,"collection":"positions","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de creación","options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":3,"collection":"positions","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de creación","options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
163	181	enterprises_industries	3	{"enterprises_id":3,"industries_id":2}	{"enterprises_id":3,"industries_id":2}	\N	\N
164	182	keywords	5	{"name":"digital transformation"}	{"name":"digital transformation"}	\N	\N
165	183	enterprises_keywords	2	{"enterprises_id":3,"keywords_id":5}	{"enterprises_id":3,"keywords_id":5}	\N	\N
166	184	keywords	6	{"name":"consulting"}	{"name":"consulting"}	\N	\N
167	185	enterprises_keywords	3	{"enterprises_id":3,"keywords_id":6}	{"enterprises_id":3,"keywords_id":6}	\N	\N
97	101	directus_fields	513	{"sort":2,"collection":"positions","conditions":null,"display":"raw","display_options":null,"field":"name","group":null,"hidden":false,"interface":"input","note":"Nombre del cargo/posición","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":2,"collection":"positions","conditions":null,"display":"raw","display_options":null,"field":"name","group":null,"hidden":false,"interface":"input","note":"Nombre del cargo/posición","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
98	102	directus_fields	514	{"sort":4,"collection":"positions","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de última actualización","options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":4,"collection":"positions","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de última actualización","options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
99	103	directus_fields	515	{"sort":5,"collection":"segments","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":false,"interface":"datetime","note":null,"options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":5,"collection":"segments","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":false,"interface":"datetime","note":null,"options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
100	104	directus_fields	516	{"sort":3,"collection":"segments","conditions":null,"display":null,"display_options":{"template":null},"field":"industry_id","group":null,"hidden":false,"interface":"select-dropdown-m2o","note":null,"options":{"template":"{{name}}"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":3,"collection":"segments","conditions":null,"display":null,"display_options":{"template":null},"field":"industry_id","group":null,"hidden":false,"interface":"select-dropdown-m2o","note":null,"options":{"template":"{{name}}"},"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
101	105	directus_fields	517	{"sort":2,"collection":"segments","conditions":null,"display":null,"display_options":null,"field":"name","group":null,"hidden":false,"interface":"input","note":null,"options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":2,"collection":"segments","conditions":null,"display":null,"display_options":null,"field":"name","group":null,"hidden":false,"interface":"input","note":null,"options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
102	106	directus_fields	518	{"sort":4,"collection":"segments","conditions":null,"display":null,"display_options":null,"field":"total","group":null,"hidden":false,"interface":"input","note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":4,"collection":"segments","conditions":null,"display":null,"display_options":null,"field":"total","group":null,"hidden":false,"interface":"input","note":null,"options":null,"readonly":false,"required":false,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
103	107	directus_fields	519	{"sort":6,"collection":"segments","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":false,"interface":"datetime","note":null,"options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":6,"collection":"segments","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":false,"interface":"datetime","note":null,"options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
104	108	directus_fields	520	{"sort":3,"collection":"technologies","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de creación","options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":3,"collection":"technologies","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"created_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de creación","options":null,"readonly":true,"required":false,"special":["date-created","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
105	109	directus_fields	521	{"sort":2,"collection":"technologies","conditions":null,"display":"raw","display_options":null,"field":"name","group":null,"hidden":false,"interface":"input","note":"Nombre de la tecnología","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	{"sort":2,"collection":"technologies","conditions":null,"display":"raw","display_options":null,"field":"name","group":null,"hidden":false,"interface":"input","note":"Nombre de la tecnología","options":null,"readonly":false,"required":true,"special":null,"translations":null,"validation":null,"validation_message":null,"width":"full"}	\N	\N
106	110	directus_fields	522	{"sort":4,"collection":"technologies","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de última actualización","options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	{"sort":4,"collection":"technologies","conditions":null,"display":"datetime","display_options":{"relative":true},"field":"updated_at","group":null,"hidden":true,"interface":"datetime","note":"Fecha de última actualización","options":null,"readonly":true,"required":false,"special":["date-updated","cast-timestamp"],"translations":null,"validation":null,"validation_message":null,"width":"half"}	\N	\N
168	186	technologies	5	{"name":"Python"}	{"name":"Python"}	\N	\N
169	187	enterprises_technologies	2	{"enterprises_id":3,"technologies_id":5}	{"enterprises_id":3,"technologies_id":5}	\N	\N
170	188	technologies	6	{"name":"Django"}	{"name":"Django"}	\N	\N
107	111	directus_fields	492	{"id":492,"collection":"people","field":"location_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{country}} - {{province}} - {{city}}"},"display":"related-values","display_options":{"template":"{{country}} - {{province}} - {{city}}"},"readonly":false,"hidden":false,"sort":12,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"people","field":"location_id","interface":"select-dropdown-m2o","options":{"template":"{{country}} - {{province}} - {{city}}"},"display":"related-values","display_options":{"template":"{{country}} - {{province}} - {{city}}"}}	\N	\N
108	112	directus_fields	516	{"id":516,"collection":"segments","field":"industry_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}"},"display":"related-values","display_options":{"template":"{{name}}"},"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"segments","field":"industry_id","interface":"select-dropdown-m2o","options":{"template":"{{name}}"},"display":"related-values","display_options":{"template":"{{name}}"}}	\N	\N
109	113	directus_fields	506	{"id":506,"collection":"person_employment_history","field":"enterprise_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}"},"display":"related-values","display_options":{"template":"{{name}}"},"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"person_employment_history","field":"enterprise_id","interface":"select-dropdown-m2o","options":{"template":"{{name}}"},"display":"related-values","display_options":{"template":"{{name}}"}}	\N	\N
110	114	directus_fields	508	{"id":508,"collection":"person_employment_history","field":"person_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}"},"display":"related-values","display_options":{"template":"{{name}}"},"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"person_employment_history","field":"person_id","interface":"select-dropdown-m2o","options":{"template":"{{name}}"},"display":"related-values","display_options":{"template":"{{name}}"}}	\N	\N
111	115	directus_fields	509	{"id":509,"collection":"person_employment_history","field":"position_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}"},"display":"related-values","display_options":{"template":"{{name}}"},"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"person_employment_history","field":"position_id","interface":"select-dropdown-m2o","options":{"template":"{{name}}"},"display":"related-values","display_options":{"template":"{{name}}"}}	\N	\N
112	117	directus_fields	523	{"interface":"select-dropdown-m2o","display":"related-values","display_options":{"template":"{{country}} - {{province}} - {{city}}"},"options":{"template":"{{country}} - {{province}} - {{city}}","enable_create":false},"special":null,"required":false,"collection":"people","field":"location_id"}	{"interface":"select-dropdown-m2o","display":"related-values","display_options":{"template":"{{country}} - {{province}} - {{city}}"},"options":{"template":"{{country}} - {{province}} - {{city}}","enable_create":false},"special":null,"required":false,"collection":"people","field":"location_id"}	\N	\N
113	118	directus_fields	523	{"id":523,"collection":"people","field":"location_id","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{country}} - {{province}} - {{city}}","enable_create":false},"display":"related-values","display_options":{"template":"{{country}} - {{province}} - {{city}}"},"readonly":false,"hidden":false,"sort":null,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"people","field":"location_id","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{country}} - {{province}} - {{city}}","enable_create":false},"display":"related-values","display_options":{"template":"{{country}} - {{province}} - {{city}}"},"required":false}	\N	\N
114	120	directus_fields	524	{"sort":9,"collection":"people","field":"location_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{country}} - {{province}} - {{city}}"},"display":"related-values","display_options":{"template":"{{country}} - {{province}} - {{city}}"},"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"sort":9,"collection":"people","field":"location_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{country}} - {{province}} - {{city}}"},"display":"related-values","display_options":{"template":"{{country}} - {{province}} - {{city}}"},"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	\N	\N
115	121	directus_fields	516	{"id":516,"collection":"segments","field":"industry_id","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{name}}","enable_create":false},"display":"related-values","display_options":{"template":"{{name}}"},"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"segments","field":"industry_id","special":["m2o"],"interface":"select-dropdown-m2o","options":{"template":"{{name}}","enable_create":false},"display":"related-values","display_options":{"template":"{{name}}"},"readonly":false,"hidden":false,"required":false}	\N	\N
116	123	directus_fields	525	{"sort":3,"collection":"segments","field":"industry_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}"},"display":"related-values","display_options":{"template":"{{name}}"},"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"sort":3,"collection":"segments","field":"industry_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}"},"display":"related-values","display_options":{"template":"{{name}}"},"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	\N	\N
171	189	enterprises_technologies	3	{"enterprises_id":3,"technologies_id":6}	{"enterprises_id":3,"technologies_id":6}	\N	\N
172	190	technologies	7	{"name":"Vue.js"}	{"name":"Vue.js"}	\N	\N
173	191	enterprises_technologies	4	{"enterprises_id":3,"technologies_id":7}	{"enterprises_id":3,"technologies_id":7}	\N	\N
174	192	people	6	{"name":"InnovateSA"}	{"name":"InnovateSA"}	\N	\N
175	193	person_employment_history	4	{"person_id":6,"enterprise_id":3,"is_current":true}	{"person_id":6,"enterprise_id":3,"is_current":true}	\N	\N
117	125	directus_fields	526	{"sort":10,"collection":"person_employment_history","field":"person_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{first_name}} {{last_name}}"},"display":"related-values","display_options":{"template":"{{first_name}} {{last_name}}"},"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"sort":10,"collection":"person_employment_history","field":"person_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{first_name}} {{last_name}}"},"display":"related-values","display_options":{"template":"{{first_name}} {{last_name}}"},"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	\N	\N
118	127	directus_fields	527	{"sort":11,"collection":"person_employment_history","field":"enterprise_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}"},"display":"related-values","display_options":{"template":"{{name}}"},"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"sort":11,"collection":"person_employment_history","field":"enterprise_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}"},"display":"related-values","display_options":{"template":"{{name}}"},"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	\N	\N
119	129	directus_fields	528	{"sort":12,"collection":"person_employment_history","field":"position_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}"},"display":"related-values","display_options":{"template":"{{name}}"},"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"sort":12,"collection":"person_employment_history","field":"position_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}"},"display":"related-values","display_options":{"template":"{{name}}"},"readonly":false,"hidden":false,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	\N	\N
120	130	locations	1	{"country":"Colombia","province":"Caldas","city":"Manizales"}	{"country":"Colombia","province":"Caldas","city":"Manizales"}	\N	\N
121	131	keywords	1	{"name":"Ingeniería"}	{"name":"Ingeniería"}	122	\N
123	133	technologies	1	{"name":"Laravel"}	{"name":"Laravel"}	124	\N
125	135	people	1	{"name":"Juanes","email":"jeholguin@increnta.com","personal_phone":"313254578","phone":"313254578","office_number":"313254578","technologies":{"create":[{"technologies_id":{"name":"Laravel"}}],"update":[],"delete":[]},"keywords":{"create":[{"keywords_id":{"name":"Ingeniería"}}],"update":[],"delete":[]}}	{"name":"Juanes","email":"jeholguin@increnta.com","personal_phone":"313254578","phone":"313254578","office_number":"313254578","technologies":{"create":[{"technologies_id":{"name":"Laravel"}}],"update":[],"delete":[]},"keywords":{"create":[{"keywords_id":{"name":"Ingeniería"}}],"update":[],"delete":[]}}	\N	\N
122	132	people_keywords	1	{"keywords_id":{"name":"Ingeniería"},"people_id":1}	{"keywords_id":{"name":"Ingeniería"},"people_id":1}	125	\N
124	134	people_technologies	1	{"technologies_id":{"name":"Laravel"},"people_id":1}	{"technologies_id":{"name":"Laravel"},"people_id":1}	125	\N
126	136	people	1	{"id":1,"about":null,"age":25,"created_at":"2025-09-19T21:44:52.282Z","email":"jeholguin@increnta.com","image":null,"linkedin":null,"name":"Juanes","office_number":"313254578","personal_phone":"313254578","phone":"313254578","sex":null,"updated_at":"2025-09-19T21:45:07.371Z","location_id":1,"keywords":[1],"technologies":[1]}	{"age":25,"location_id":1,"updated_at":"2025-09-19T21:45:07.371Z"}	\N	\N
127	137	people	3	{"name":"juanes","email":"juanes@example.com","personal_phone":"3001234567","office_number":"6009876","about":"Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas","linkedin":"https://www.linkedin.com/in/analopez","location_id":1}	{"name":"juanes","email":"juanes@example.com","personal_phone":"3001234567","office_number":"6009876","about":"Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas","linkedin":"https://www.linkedin.com/in/analopez","location_id":1}	\N	\N
128	138	enterprises	1	{"name":"Tech Solutions Inc","description":"Empresa de desarrollo de software"}	{"name":"Tech Solutions Inc","description":"Empresa de desarrollo de software"}	\N	\N
129	139	positions	1	{"name":"Senior Developer","description":"Desarrollador senior de software"}	{"name":"Senior Developer","description":"Desarrollador senior de software"}	\N	\N
152	170	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	{"id":"9587e47d-af93-4ba4-8de3-3de9831b4305","first_name":"Admin","last_name":"User","email":"jeholguin@increnta.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"d5a3b569-26d9-4a9c-8213-4d0590840676","token":"**********","last_access":"2025-09-23T03:59:56.835Z","last_page":"/users/9587e47d-af93-4ba4-8de3-3de9831b4305","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"token":"**********"}	\N	\N
130	140	people	4	{"name":"juanes","email":"juanes@example.com","personal_phone":"3001234567","office_number":"6009876","about":"Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas","linkedin":"https://www.linkedin.com/in/analopez","location_id":1}	{"name":"juanes","email":"juanes@example.com","personal_phone":"3001234567","office_number":"6009876","about":"Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas","linkedin":"https://www.linkedin.com/in/analopez","location_id":1}	\N	\N
131	141	person_employment_history	2	{"person_id":4,"position_id":1,"enterprise_id":1,"is_current":true,"start_date":"2021-02-01","end_date":"2023-07-31"}	{"person_id":4,"position_id":1,"enterprise_id":1,"is_current":true,"start_date":"2021-02-01","end_date":"2023-07-31"}	\N	\N
132	144	keywords	2	{"name":"Lider de proyectos"}	{"name":"Lider de proyectos"}	133	\N
134	146	keywords	3	{"name":"Administración de recursos"}	{"name":"Administración de recursos"}	135	\N
136	148	technologies	2	{"name":"Sql"}	{"name":"Sql"}	137	\N
138	150	technologies	3	{"name":"Laravel"}	{"name":"Laravel"}	139	\N
140	152	people	4	{"id":4,"about":"Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas","age":null,"created_at":"2025-09-19T21:47:31.530Z","email":"juanes@example.com","image":null,"linkedin":"https://www.linkedin.com/in/analopez","name":"juanes","office_number":"6009876","personal_phone":"3001234567","phone":null,"sex":null,"updated_at":"2025-09-19T21:50:27.836Z","location_id":1,"keywords":[2,3],"technologies":[2,3]}	{"updated_at":"2025-09-19T21:50:27.836Z"}	\N	\N
133	145	people_keywords	2	{"keywords_id":{"name":"Lider de proyectos"},"people_id":"4"}	{"keywords_id":{"name":"Lider de proyectos"},"people_id":"4"}	140	\N
135	147	people_keywords	3	{"keywords_id":{"name":"Administración de recursos"},"people_id":"4"}	{"keywords_id":{"name":"Administración de recursos"},"people_id":"4"}	140	\N
137	149	people_technologies	2	{"technologies_id":{"name":"Sql"},"people_id":"4"}	{"technologies_id":{"name":"Sql"},"people_id":"4"}	140	\N
139	151	people_technologies	3	{"technologies_id":{"name":"Laravel"},"people_id":"4"}	{"technologies_id":{"name":"Laravel"},"people_id":"4"}	140	\N
141	153	directus_fields	526	{"id":526,"collection":"person_employment_history","field":"person_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}","enable_create":false},"display":"related-values","display_options":{"template":"{{name}}"},"readonly":false,"hidden":false,"sort":10,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"person_employment_history","field":"person_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}","enable_create":false},"display":"related-values","display_options":{"template":"{{name}}"},"required":false}	\N	\N
142	154	directus_fields	527	{"id":527,"collection":"person_employment_history","field":"enterprise_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}","enable_create":false},"display":"related-values","display_options":{"template":"{{name}}"},"readonly":false,"hidden":false,"sort":11,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"person_employment_history","field":"enterprise_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}","enable_create":false},"display":"related-values","display_options":{"template":"{{name}}"},"required":false}	\N	\N
143	155	directus_fields	528	{"id":528,"collection":"person_employment_history","field":"position_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}","enable_create":false},"display":"related-values","display_options":{"template":"{{name}}"},"readonly":false,"hidden":false,"sort":12,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"person_employment_history","field":"position_id","special":null,"interface":"select-dropdown-m2o","options":{"template":"{{name}}","enable_create":false},"display":"related-values","display_options":{"template":"{{name}}"},"required":false}	\N	\N
144	157	directus_fields	529	{"sort":20,"interface":"list-m2m","special":["m2m"],"collection":"enterprises","field":"industries"}	{"sort":20,"interface":"list-m2m","special":["m2m"],"collection":"enterprises","field":"industries"}	\N	\N
145	158	directus_fields	530	{"sort":1,"hidden":true,"field":"id","collection":"enterprises_industries"}	{"sort":1,"hidden":true,"field":"id","collection":"enterprises_industries"}	\N	\N
146	159	directus_collections	enterprises_industries	{"hidden":true,"icon":"import_export","collection":"enterprises_industries"}	{"hidden":true,"icon":"import_export","collection":"enterprises_industries"}	\N	\N
147	160	directus_fields	531	{"sort":2,"hidden":true,"collection":"enterprises_industries","field":"enterprises_id"}	{"sort":2,"hidden":true,"collection":"enterprises_industries","field":"enterprises_id"}	\N	\N
148	161	directus_fields	532	{"sort":3,"hidden":true,"collection":"enterprises_industries","field":"industries_id"}	{"sort":3,"hidden":true,"collection":"enterprises_industries","field":"industries_id"}	\N	\N
149	162	industries	1	{"name":"Tecnología"}	{"name":"Tecnología"}	150	\N
150	163	enterprises_industries	1	{"industries_id":{"name":"Tecnología"},"enterprises_id":"1"}	{"industries_id":{"name":"Tecnología"},"enterprises_id":"1"}	151	\N
153	171	enterprises	2	{"nit":"123456789","name":"TechCorp","phone":"+57601234567","email":"info@techcorp.com","linkedin":"linkedin.com/company/techcorp","founded_year":"2010"}	{"nit":"123456789","name":"TechCorp","phone":"+57601234567","email":"info@techcorp.com","linkedin":"linkedin.com/company/techcorp","founded_year":"2010"}	\N	\N
176	194	enterprises	4	{"nit":"555666777","name":"DataSolutions","phone":"+57603456789","email":"hello@datasolutions.com","linkedin":"linkedin.com/company/datasolutions","founded_year":"2018"}	{"nit":"555666777","name":"DataSolutions","phone":"+57603456789","email":"hello@datasolutions.com","linkedin":"linkedin.com/company/datasolutions","founded_year":"2018"}	\N	\N
177	195	industries	3	{"name":"Analítica"}	{"name":"Analítica"}	\N	\N
178	196	enterprises_industries	4	{"enterprises_id":4,"industries_id":3}	{"enterprises_id":4,"industries_id":3}	\N	\N
179	197	keywords	7	{"name":"data science"}	{"name":"data science"}	\N	\N
180	198	enterprises_keywords	4	{"enterprises_id":4,"keywords_id":7}	{"enterprises_id":4,"keywords_id":7}	\N	\N
181	199	keywords	8	{"name":"machine learning"}	{"name":"machine learning"}	\N	\N
182	200	enterprises_keywords	5	{"enterprises_id":4,"keywords_id":8}	{"enterprises_id":4,"keywords_id":8}	\N	\N
183	201	enterprises_technologies	5	{"enterprises_id":4,"technologies_id":5}	{"enterprises_id":4,"technologies_id":5}	\N	\N
184	202	technologies	8	{"name":"TensorFlow"}	{"name":"TensorFlow"}	\N	\N
185	203	enterprises_technologies	6	{"enterprises_id":4,"technologies_id":8}	{"enterprises_id":4,"technologies_id":8}	\N	\N
186	204	technologies	9	{"name":"React"}	{"name":"React"}	\N	\N
187	205	enterprises_technologies	7	{"enterprises_id":4,"technologies_id":9}	{"enterprises_id":4,"technologies_id":9}	\N	\N
188	206	people	7	{"name":"DataSolutions"}	{"name":"DataSolutions"}	\N	\N
189	207	person_employment_history	5	{"person_id":7,"enterprise_id":4,"is_current":true}	{"person_id":7,"enterprise_id":4,"is_current":true}	\N	\N
190	208	people	8	{"name":"TechCorp"}	{"name":"TechCorp"}	\N	\N
191	209	person_employment_history	6	{"person_id":8,"enterprise_id":2,"is_current":true}	{"person_id":8,"enterprise_id":2,"is_current":true}	\N	\N
192	210	enterprises	5	{"nit":"999888777","name":"TestCompany","phone":"+57604567890","email":"test@company.com","linkedin":"linkedin.com/company/test","founded_year":"2020"}	{"nit":"999888777","name":"TestCompany","phone":"+57604567890","email":"test@company.com","linkedin":"linkedin.com/company/test","founded_year":"2020"}	\N	\N
193	211	industries	4	{"name":"Software"}	{"name":"Software"}	\N	\N
194	212	enterprises_industries	5	{"enterprises_id":5,"industries_id":4}	{"enterprises_id":5,"industries_id":4}	\N	\N
195	213	locations	2	{"city":"Cali","country":"Colombia","province":"N/A"}	{"city":"Cali","country":"Colombia","province":"N/A"}	\N	\N
196	214	enterprises_locations	1	{"enterprises_id":5,"locations_id":2}	{"enterprises_id":5,"locations_id":2}	\N	\N
197	215	keywords	9	{"name":"web development"}	{"name":"web development"}	\N	\N
198	216	enterprises_keywords	6	{"enterprises_id":5,"keywords_id":9}	{"enterprises_id":5,"keywords_id":9}	\N	\N
199	217	technologies	10	{"name":"JavaScript"}	{"name":"JavaScript"}	\N	\N
200	218	enterprises_technologies	8	{"enterprises_id":5,"technologies_id":10}	{"enterprises_id":5,"technologies_id":10}	\N	\N
201	219	technologies	11	{"name":"Node.js"}	{"name":"Node.js"}	\N	\N
202	220	enterprises_technologies	9	{"enterprises_id":5,"technologies_id":11}	{"enterprises_id":5,"technologies_id":11}	\N	\N
203	221	people	9	{"name":"TestCompany"}	{"name":"TestCompany"}	\N	\N
204	222	person_employment_history	7	{"person_id":9,"enterprise_id":5,"is_current":true}	{"person_id":9,"enterprise_id":5,"is_current":true}	\N	\N
205	223	enterprises	6	{"nit":"111222333","name":"EmpresaTest","phone":"+57605551234","email":"test@empresa.com","linkedin":"linkedin.com/empresa","founded_year":"2021"}	{"nit":"111222333","name":"EmpresaTest","phone":"+57605551234","email":"test@empresa.com","linkedin":"linkedin.com/empresa","founded_year":"2021"}	\N	\N
206	224	enterprises_industries	6	{"enterprises_id":6,"industries_id":4}	{"enterprises_id":6,"industries_id":4}	\N	\N
207	225	locations	3	{"city":"Bogotá","country":"Colombia","province":"N/A"}	{"city":"Bogotá","country":"Colombia","province":"N/A"}	\N	\N
208	226	enterprises_locations	2	{"enterprises_id":6,"locations_id":3}	{"enterprises_id":6,"locations_id":3}	\N	\N
209	227	locations	4	{"city":"Medellín","country":"Colombia","province":"N/A"}	{"city":"Medellín","country":"Colombia","province":"N/A"}	\N	\N
210	228	enterprises_locations	3	{"enterprises_id":6,"locations_id":4}	{"enterprises_id":6,"locations_id":4}	\N	\N
211	229	keywords	10	{"name":"desarrollo web"}	{"name":"desarrollo web"}	\N	\N
212	230	enterprises_keywords	7	{"enterprises_id":6,"keywords_id":10}	{"enterprises_id":6,"keywords_id":10}	\N	\N
213	231	keywords	11	{"name":"innovación"}	{"name":"innovación"}	\N	\N
214	232	enterprises_keywords	8	{"enterprises_id":6,"keywords_id":11}	{"enterprises_id":6,"keywords_id":11}	\N	\N
215	233	enterprises_technologies	10	{"enterprises_id":6,"technologies_id":10}	{"enterprises_id":6,"technologies_id":10}	\N	\N
216	234	enterprises_technologies	11	{"enterprises_id":6,"technologies_id":11}	{"enterprises_id":6,"technologies_id":11}	\N	\N
217	235	enterprises_technologies	12	{"enterprises_id":6,"technologies_id":9}	{"enterprises_id":6,"technologies_id":9}	\N	\N
218	254	enterprises	7	{"nit":"900999888","name":"TestFile","phone":"+57607777777","email":"test@file.com","linkedin":"linkedin.com/test","founded_year":"2023"}	{"nit":"900999888","name":"TestFile","phone":"+57607777777","email":"test@file.com","linkedin":"linkedin.com/test","founded_year":"2023"}	\N	\N
219	255	enterprises_industries	7	{"enterprises_id":7,"industries_id":4}	{"enterprises_id":7,"industries_id":4}	\N	\N
220	256	enterprises_locations	4	{"enterprises_id":7,"locations_id":3}	{"enterprises_id":7,"locations_id":3}	\N	\N
221	257	keywords	12	{"name":"testing"}	{"name":"testing"}	\N	\N
222	258	enterprises_keywords	9	{"enterprises_id":7,"keywords_id":12}	{"enterprises_id":7,"keywords_id":12}	\N	\N
223	259	keywords	13	{"name":"file upload"}	{"name":"file upload"}	\N	\N
224	260	enterprises_keywords	10	{"enterprises_id":7,"keywords_id":13}	{"enterprises_id":7,"keywords_id":13}	\N	\N
225	261	enterprises_technologies	13	{"enterprises_id":7,"technologies_id":11}	{"enterprises_id":7,"technologies_id":11}	\N	\N
226	262	technologies	12	{"name":"Express"}	{"name":"Express"}	\N	\N
227	263	enterprises_technologies	14	{"enterprises_id":7,"technologies_id":12}	{"enterprises_id":7,"technologies_id":12}	\N	\N
228	264	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	{"id":"9587e47d-af93-4ba4-8de3-3de9831b4305","first_name":"Admin","last_name":"User","email":"jeholguin@increnta.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"d5a3b569-26d9-4a9c-8213-4d0590840676","token":"**********","last_access":"2025-09-23T04:37:13.945Z","last_page":"/users/9587e47d-af93-4ba4-8de3-3de9831b4305","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"token":"**********"}	\N	\N
229	265	enterprises	8	{"nit":"123456789","name":"TechCorp","phone":"+57601234567","email":"info@techcorp.com","linkedin":"linkedin.com/company/techcorp","founded_year":"2010"}	{"nit":"123456789","name":"TechCorp","phone":"+57601234567","email":"info@techcorp.com","linkedin":"linkedin.com/company/techcorp","founded_year":"2010"}	\N	\N
230	266	enterprises_industries	8	{"enterprises_id":8,"industries_id":1}	{"enterprises_id":8,"industries_id":1}	\N	\N
231	267	enterprises_locations	5	{"enterprises_id":8,"locations_id":3}	{"enterprises_id":8,"locations_id":3}	\N	\N
232	268	enterprises_keywords	11	{"enterprises_id":8,"keywords_id":4}	{"enterprises_id":8,"keywords_id":4}	\N	\N
233	269	enterprises_technologies	15	{"enterprises_id":8,"technologies_id":4}	{"enterprises_id":8,"technologies_id":4}	\N	\N
234	270	directus_users	9587e47d-af93-4ba4-8de3-3de9831b4305	{"id":"9587e47d-af93-4ba4-8de3-3de9831b4305","first_name":"Admin","last_name":"User","email":"jeholguin@increnta.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"d5a3b569-26d9-4a9c-8213-4d0590840676","token":"**********","last_access":"2025-09-23T19:21:15.189Z","last_page":"/users/9587e47d-af93-4ba4-8de3-3de9831b4305","provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"text_direction":"auto","policies":[]}	{"token":"**********"}	\N	\N
235	271	enterprises	9	{"organization_name":"Librerías Gandhi","acquisition_source":"other","notes":"Importado desde CSV Pipedrive","normalized_address":"Av. Miguel Ángel de Quevedo 121, Chimalistac, Coyoacán, 01050 Ciudad de México, CDMX","internal_owner":"Angela Chávez","fiscal_identification":"15762991","commercial_name":"10"}	{"organization_name":"Librerías Gandhi","acquisition_source":"other","notes":"Importado desde CSV Pipedrive","normalized_address":"Av. Miguel Ángel de Quevedo 121, Chimalistac, Coyoacán, 01050 Ciudad de México, CDMX","internal_owner":"Angela Chávez","fiscal_identification":"15762991","commercial_name":"10"}	\N	\N
236	275	enterprises	10	{"organization_name":"Librerías Gandhi","acquisition_source":"other","notes":"Importado desde CSV Pipedrive","normalized_address":"Av. Miguel Ángel de Quevedo 121, Chimalistac, Coyoacán, 01050 Ciudad de México, CDMX","internal_owner":"Angela Chávez","fiscal_identification":"15762991","commercial_name":"10"}	{"organization_name":"Librerías Gandhi","acquisition_source":"other","notes":"Importado desde CSV Pipedrive","normalized_address":"Av. Miguel Ángel de Quevedo 121, Chimalistac, Coyoacán, 01050 Ciudad de México, CDMX","internal_owner":"Angela Chávez","fiscal_identification":"15762991","commercial_name":"10"}	\N	\N
237	277	enterprises	11	{"organization_name":"1"}	{"organization_name":"1"}	\N	\N
238	278	enterprises	12	{"organization_name":"1","commercial_name":"a","linkedin":"a","fiscal_identification_type":"RUT","fiscal_identification":"a","company_size":"201-500","country":"USA","normalized_address":"a","website":"a","phone_prefix":"+54","phone_number":"2333","acquisition_source":"website","internal_owner":"2","notes":"s"}	{"organization_name":"1","commercial_name":"a","linkedin":"a","fiscal_identification_type":"RUT","fiscal_identification":"a","company_size":"201-500","country":"USA","normalized_address":"a","website":"a","phone_prefix":"+54","phone_number":"2333","acquisition_source":"website","internal_owner":"2","notes":"s"}	\N	\N
239	279	enterprises	13	{"organization_name":"Empresa Prueba Admin","notes":"Prueba desde API","acquisition_source":"other"}	{"organization_name":"Empresa Prueba Admin","notes":"Prueba desde API","acquisition_source":"other"}	\N	\N
240	280	enterprises	14	{"organization_name":"Empresa Prueba Admin","notes":"Prueba desde API","acquisition_source":"other"}	{"organization_name":"Empresa Prueba Admin","notes":"Prueba desde API","acquisition_source":"other"}	\N	\N
241	281	enterprises	15	{"organization_name":"1","commercial_name":"a","linkedin":"a","fiscal_identification_type":"RUT","fiscal_identification":"a","company_size":"201-500","country":"USA","normalized_address":"a","website":"a","phone_prefix":"+54","phone_number":"2333","acquisition_source":"website","internal_owner":"2","notes":"s"}	{"organization_name":"1","commercial_name":"a","linkedin":"a","fiscal_identification_type":"RUT","fiscal_identification":"a","company_size":"201-500","country":"USA","normalized_address":"a","website":"a","phone_prefix":"+54","phone_number":"2333","acquisition_source":"website","internal_owner":"2","notes":"s"}	\N	\N
242	287	enterprises	16	{"organization_name":"a","commercial_name":"a","linkedin":"a","fiscal_identification_type":"RUT","fiscal_identification":"a","company_size":"1-10","country":"BRA","normalized_address":"a","website":"a","phone_prefix":"+57","phone_number":"3135624587","acquisition_source":"website","internal_owner":"a","notes":"a"}	{"organization_name":"a","commercial_name":"a","linkedin":"a","fiscal_identification_type":"RUT","fiscal_identification":"a","company_size":"1-10","country":"BRA","normalized_address":"a","website":"a","phone_prefix":"+57","phone_number":"3135624587","acquisition_source":"website","internal_owner":"a","notes":"a"}	\N	\N
243	289	enterprises	17	{"organization_name":"Librerías Gandhi","acquisition_source":"other","notes":"Importado desde CSV Pipedrive","normalized_address":"Av. Miguel Ángel de Quevedo 121, Chimalistac, Coyoacán, 01050 Ciudad de México, CDMX","internal_owner":"Angela Chávez","fiscal_identification":"15762991","commercial_name":"10"}	{"organization_name":"Librerías Gandhi","acquisition_source":"other","notes":"Importado desde CSV Pipedrive","normalized_address":"Av. Miguel Ángel de Quevedo 121, Chimalistac, Coyoacán, 01050 Ciudad de México, CDMX","internal_owner":"Angela Chávez","fiscal_identification":"15762991","commercial_name":"10"}	\N	\N
244	291	people	10	{"full_name":"Juan Pérez García","position_title":"Director Comercial","department":"ventas","primary_email":"juan.perez@empresa.com","phone_prefix":"+57","phone_number":"3001234567","decision_level":"director","acquisition_source":"linkedin","internal_owner":"Ana López","communication_consent":true,"notes":"Contacto clave para expansión en Colombia"}	{"full_name":"Juan Pérez García","position_title":"Director Comercial","department":"ventas","primary_email":"juan.perez@empresa.com","phone_prefix":"+57","phone_number":"3001234567","decision_level":"director","acquisition_source":"linkedin","internal_owner":"Ana López","communication_consent":true,"notes":"Contacto clave para expansión en Colombia"}	\N	\N
245	292	people	11	{"full_name":"Juan Pérez García","position_title":"Director Comercial","department":"ventas","primary_email":"juan.perez@empresa.com","phone_prefix":"+57","phone_number":"3001234567","decision_level":"director","acquisition_source":"linkedin","internal_owner":"Ana López","communication_consent":true,"notes":"Contacto clave para expansión en Colombia"}	{"full_name":"Juan Pérez García","position_title":"Director Comercial","department":"ventas","primary_email":"juan.perez@empresa.com","phone_prefix":"+57","phone_number":"3001234567","decision_level":"director","acquisition_source":"linkedin","internal_owner":"Ana López","communication_consent":true,"notes":"Contacto clave para expansión en Colombia"}	\N	\N
246	295	people	12	{"full_name":"Adrián Herrero Bernabéu","acquisition_source":"other","primary_email":"adrian.herrero@quinton.es","phone_number":"965361101","notes":"Importado desde CSV Pipedrive"}	{"full_name":"Adrián Herrero Bernabéu","acquisition_source":"other","primary_email":"adrian.herrero@quinton.es","phone_number":"965361101","notes":"Importado desde CSV Pipedrive"}	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
d5a3b569-26d9-4a9c-8213-4d0590840676	Administrator	verified	$t:admin_description	\N
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token) FROM stdin;
56A5BXqcOzUITBnXhG914O88RW8bzYcTi66HVyEBh18327jDgt0hMg6E2iaMSY-k	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-26 16:51:41.958+00	172.21.0.1	curl/8.5.0	\N	\N	\N
MpZIpKZ_naIOGDGvucXsw8EW3xoiGaldyqFlrPXyVOEjdsv4lIgtyrTwSpQbbYw_	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-26 17:25:57.852+00	172.21.0.1	curl/8.5.0	\N	\N	\N
7y0wM7_MAXezcPsbkAQGSJDw8-GIOgxLhmTIE6JMFdZygwFV7iqNb9RVCpwpL1fV	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-26 17:49:14.204+00	172.21.0.1	curl/8.5.0	\N	\N	\N
2wCrJ3PMu7_dwooYDL0g99_wWFofJ4hZ78VCNdywz_060yxmIf1VqZQA-GMJT207	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-30 03:45:29.204+00	172.21.0.1	curl/8.5.0	\N	\N	\N
FxAT7tD0EeunHs4T3lwG6HlqwyEXtIzSlnCNCsfY45trz0PtLHYfJIs_fCMqXIF8	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-30 03:57:13.813+00	172.21.0.1	curl/8.5.0	\N	\N	\N
yISOZIliZuEyaTlOxBgvATZhCnvCuuPpd73WHMD4TvG5XWX14qkzDyNBnFudahAz	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-30 03:58:30.095+00	172.21.0.1	curl/8.5.0	\N	\N	\N
G0j9rjeiyH0hgXjHdHi4kDcTSNvkF2JSzjechJZ2ZgdYG-BDTawYCzI5SGtkyzmu	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-30 03:59:56.809+00	172.21.0.1	curl/8.5.0	\N	\N	\N
Gf6uONJ5Wy_vqK1-z5SohA9xS3sFTxU2pKC8aNmCyYheHqoVEth8d82rFwZfhVQt	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-23 20:43:14.988+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	\N	http://localhost:8055	7SMfZWj_0J9naJp6npDAhzIoyGKkO0sraJOMRx5f-dNbvCUL5qFKHcQt52I5FymF
7SMfZWj_0J9naJp6npDAhzIoyGKkO0sraJOMRx5f-dNbvCUL5qFKHcQt52I5FymF	9587e47d-af93-4ba4-8de3-3de9831b4305	2025-09-24 20:43:04.988+00	172.21.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	\N	http://localhost:8055	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter, visual_editor_urls, accepted_terms, project_id, mcp_enabled, mcp_allow_deletes, mcp_prompts_collection, mcp_system_prompt_enabled, mcp_system_prompt) FROM stdin;
1	Directus	\N	#6644FF	\N	\N	\N	\N	25	\N	all	\N	\N	\N	\N	\N	\N	\N	en-US	\N	\N	auto	\N	\N	\N	\N	\N	\N	\N	f	t	\N	\N	\N	t	019962e0-252b-71fa-bdac-8f160d5af4db	f	f	\N	t	\N
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_sync_id_map; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_sync_id_map (id, "table", sync_id, local_id, created_at) FROM stdin;
1	settings	e58217b4-397c-4ee3-9a78-8be4ebdb3c3c	1	2025-09-19 17:26:07.143829+00
2	roles	_sync_default_admin_role	d5a3b569-26d9-4a9c-8213-4d0590840676	2025-09-19 17:26:07.194228+00
3	policies	_sync_default_admin_policy	8225d704-c297-4fef-9291-148737393e0c	2025-09-19 17:26:07.216478+00
4	policies	_sync_default_public_policy	abf8a154-5b1c-4a46-ac9c-7300570f4f17	2025-09-19 17:26:07.229823+00
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides, text_direction) FROM stdin;
9587e47d-af93-4ba4-8de3-3de9831b4305	Admin	User	jeholguin@increnta.com	$argon2id$v=19$m=65536,t=3,p=4$1KBxHKzLzN+11MjtNGKdHQ$gaC5iQekEHYhdgwnXAXcxrCTNheZaX9dZ1Zv1VBZ5aI	\N	\N	\N	\N	\N	\N	\N	active	d5a3b569-26d9-4a9c-8213-4d0590840676	ghsQiEDlu88Px407q_EiQemenA_l7kNK	2025-09-23 20:43:04.994+00	/content/person_employment_history	default	\N	\N	t	\N	\N	\N	\N	\N	auto
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated, delta) FROM stdin;
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers, was_active_before_deprecation, migrated_flow) FROM stdin;
\.


--
-- Data for Name: enterprise_tags; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enterprise_tags (id, name, color, created_at) FROM stdin;
\.


--
-- Data for Name: enterprises; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enterprises (id, notes, created_at, company_size, linkedin, organization_name, fiscal_identification, updated_at, commercial_name, fiscal_identification_type, country, normalized_address, website, phone_prefix, phone_number, acquisition_source, internal_owner) FROM stdin;
\.


--
-- Data for Name: enterprises_industries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enterprises_industries (id, enterprises_id, industries_id) FROM stdin;
1	\N	1
2	\N	1
3	\N	2
4	\N	3
5	\N	4
6	\N	4
7	\N	4
8	\N	1
\.


--
-- Data for Name: enterprises_keywords; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enterprises_keywords (id, enterprises_id, keywords_id) FROM stdin;
1	\N	4
2	\N	5
3	\N	6
4	\N	7
5	\N	8
6	\N	9
7	\N	10
8	\N	11
9	\N	12
10	\N	13
11	\N	4
\.


--
-- Data for Name: enterprises_locations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enterprises_locations (id, enterprises_id, locations_id) FROM stdin;
1	\N	2
2	\N	3
3	\N	4
4	\N	3
5	\N	3
\.


--
-- Data for Name: enterprises_tags; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enterprises_tags (id, enterprises_id, tag_id, created_at) FROM stdin;
\.


--
-- Data for Name: enterprises_technologies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enterprises_technologies (id, enterprises_id, technologies_id) FROM stdin;
1	\N	4
2	\N	5
3	\N	6
4	\N	7
5	\N	5
6	\N	8
7	\N	9
8	\N	10
9	\N	11
10	\N	10
11	\N	11
12	\N	9
13	\N	11
14	\N	12
15	\N	4
\.


--
-- Data for Name: industries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.industries (id, created_at, name, updated_at) FROM stdin;
1	2025-09-19 23:00:13.26+00	Tecnología	2025-09-19 23:00:13.253701+00
2	2025-09-23 04:06:10.167+00	Consultoría	2025-09-23 04:06:10.166002+00
3	2025-09-23 04:06:10.76+00	Analítica	2025-09-23 04:06:10.759595+00
4	2025-09-23 04:19:39.612+00	Software	2025-09-23 04:19:39.61052+00
\.


--
-- Data for Name: keywords; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keywords (id, created_at, name, updated_at) FROM stdin;
1	2025-09-19 21:44:52.287+00	Ingeniería	2025-09-19 21:44:52.281582+00
2	2025-09-19 21:50:27.84+00	Lider de proyectos	2025-09-19 21:50:27.835634+00
3	2025-09-19 21:50:27.854+00	Administración de recursos	2025-09-19 21:50:27.835634+00
4	2025-09-23 04:06:09.922+00	software development	2025-09-23 04:06:09.918435+00
5	2025-09-23 04:06:10.289+00	digital transformation	2025-09-23 04:06:10.286767+00
6	2025-09-23 04:06:10.359+00	consulting	2025-09-23 04:06:10.358323+00
7	2025-09-23 04:06:10.853+00	data science	2025-09-23 04:06:10.851716+00
8	2025-09-23 04:06:10.904+00	machine learning	2025-09-23 04:06:10.903272+00
9	2025-09-23 04:19:39.651+00	web development	2025-09-23 04:19:39.650699+00
10	2025-09-23 04:27:41.988+00	desarrollo web	2025-09-23 04:27:41.987121+00
11	2025-09-23 04:27:42.007+00	innovación	2025-09-23 04:27:42.005063+00
12	2025-09-23 04:37:05.097+00	testing	2025-09-23 04:37:05.095451+00
13	2025-09-23 04:37:05.116+00	file upload	2025-09-23 04:37:05.114944+00
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.locations (id, city, country, created_at, province, updated_at) FROM stdin;
1	Manizales	Colombia	2025-09-19 21:44:27.587+00	Caldas	2025-09-19 21:44:27.583871+00
2	Cali	Colombia	2025-09-23 04:19:39.633+00	N/A	2025-09-23 04:19:39.631635+00
3	Bogotá	Colombia	2025-09-23 04:27:41.948+00	N/A	2025-09-23 04:27:41.944578+00
4	Medellín	Colombia	2025-09-23 04:27:41.969+00	N/A	2025-09-23 04:27:41.96786+00
\.


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.people (id, notes, created_at, primary_email, linkedin, full_name, updated_at, position_title, department, phone_prefix, phone_number, enterprise_relation_id, decision_level, acquisition_source, internal_owner, communication_consent) FROM stdin;
12	Importado desde CSV Pipedrive	\N	adrian.herrero@quinton.es	\N	Adrián Herrero Bernabéu	\N	\N	\N	\N	965361101	\N	\N	other	\N	f
\.


--
-- Data for Name: people_keywords; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.people_keywords (id, keywords_id, people_id) FROM stdin;
1	1	\N
2	2	\N
3	3	\N
\.


--
-- Data for Name: people_tags; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.people_tags (id, person_id, tag_id, created_at) FROM stdin;
\.


--
-- Data for Name: people_technologies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.people_technologies (id, people_id, technologies_id) FROM stdin;
1	\N	1
2	\N	2
3	\N	3
\.


--
-- Data for Name: person_employment_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.person_employment_history (id, created_at, end_date, is_current, start_date, updated_at, person_id, enterprise_id, position_id) FROM stdin;
\.


--
-- Data for Name: positions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.positions (id, created_at, name, updated_at) FROM stdin;
1	2025-09-19 21:47:31.513+00	Senior Developer	2025-09-19 21:47:31.512251+00
\.


--
-- Data for Name: segments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.segments (id, created_at, name, total, updated_at, industry_id) FROM stdin;
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: technologies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.technologies (id, created_at, name, updated_at) FROM stdin;
1	2025-09-19 21:44:52.305+00	Laravel	2025-09-19 21:44:52.281582+00
2	2025-09-19 21:50:27.872+00	Sql	2025-09-19 21:50:27.835634+00
3	2025-09-19 21:50:27.886+00	Laravel	2025-09-19 21:50:27.835634+00
4	2025-09-23 04:06:10.003+00	PHP	2025-09-23 04:06:10.001654+00
5	2025-09-23 04:06:10.437+00	Python	2025-09-23 04:06:10.433217+00
6	2025-09-23 04:06:10.526+00	Django	2025-09-23 04:06:10.524759+00
7	2025-09-23 04:06:10.592+00	Vue.js	2025-09-23 04:06:10.589056+00
8	2025-09-23 04:06:10.989+00	TensorFlow	2025-09-23 04:06:10.988126+00
9	2025-09-23 04:06:11.039+00	React	2025-09-23 04:06:11.038632+00
10	2025-09-23 04:19:39.672+00	JavaScript	2025-09-23 04:19:39.671044+00
11	2025-09-23 04:19:39.688+00	Node.js	2025-09-23 04:19:39.687634+00
12	2025-09-23 04:37:05.143+00	Express	2025-09-23 04:37:05.142519+00
\.


--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: -
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: -
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: -
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: -
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: -
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: -
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 295, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 578, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 1, false);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 3, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 56, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 246, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_sync_id_map_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_sync_id_map_id_seq', 4, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: enterprise_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enterprise_tags_id_seq', 1, false);


--
-- Name: enterprises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enterprises_id_seq', 17, true);


--
-- Name: enterprises_industries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enterprises_industries_id_seq', 8, true);


--
-- Name: enterprises_keywords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enterprises_keywords_id_seq', 11, true);


--
-- Name: enterprises_locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enterprises_locations_id_seq', 5, true);


--
-- Name: enterprises_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enterprises_tags_id_seq', 1, false);


--
-- Name: enterprises_technologies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.enterprises_technologies_id_seq', 15, true);


--
-- Name: industries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.industries_id_seq', 4, true);


--
-- Name: keywords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.keywords_id_seq', 13, true);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.locations_id_seq', 4, true);


--
-- Name: people_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.people_id_seq', 12, true);


--
-- Name: people_keywords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.people_keywords_id_seq', 3, true);


--
-- Name: people_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.people_tags_id_seq', 1, false);


--
-- Name: people_technologies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.people_technologies_id_seq', 3, true);


--
-- Name: person_employment_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.person_employment_history_id_seq', 7, true);


--
-- Name: positions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.positions_id_seq', 1, true);


--
-- Name: segments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.segments_id_seq', 1, false);


--
-- Name: technologies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.technologies_id_seq', 12, true);


--
-- Name: directus_access directus_access_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_comments directus_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_pkey PRIMARY KEY (id);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_policies directus_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_policies
    ADD CONSTRAINT directus_policies_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_sync_id_map directus_sync_id_map_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_sync_id_map
    ADD CONSTRAINT directus_sync_id_map_pkey PRIMARY KEY (id);


--
-- Name: directus_sync_id_map directus_sync_id_map_table_local_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_sync_id_map
    ADD CONSTRAINT directus_sync_id_map_table_local_id_unique UNIQUE ("table", local_id);


--
-- Name: directus_sync_id_map directus_sync_id_map_table_sync_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_sync_id_map
    ADD CONSTRAINT directus_sync_id_map_table_sync_id_unique UNIQUE ("table", sync_id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: enterprise_tags enterprise_tags_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_tags
    ADD CONSTRAINT enterprise_tags_name_key UNIQUE (name);


--
-- Name: enterprise_tags enterprise_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprise_tags
    ADD CONSTRAINT enterprise_tags_pkey PRIMARY KEY (id);


--
-- Name: enterprises_industries enterprises_industries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_industries
    ADD CONSTRAINT enterprises_industries_pkey PRIMARY KEY (id);


--
-- Name: enterprises_keywords enterprises_keywords_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_keywords
    ADD CONSTRAINT enterprises_keywords_pkey PRIMARY KEY (id);


--
-- Name: enterprises_locations enterprises_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_locations
    ADD CONSTRAINT enterprises_locations_pkey PRIMARY KEY (id);


--
-- Name: enterprises enterprises_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises
    ADD CONSTRAINT enterprises_pkey PRIMARY KEY (id);


--
-- Name: enterprises_tags enterprises_tags_enterprise_id_tag_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_tags
    ADD CONSTRAINT enterprises_tags_enterprise_id_tag_id_key UNIQUE (enterprises_id, tag_id);


--
-- Name: enterprises_tags enterprises_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_tags
    ADD CONSTRAINT enterprises_tags_pkey PRIMARY KEY (id);


--
-- Name: enterprises_technologies enterprises_technologies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_technologies
    ADD CONSTRAINT enterprises_technologies_pkey PRIMARY KEY (id);


--
-- Name: industries industries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.industries
    ADD CONSTRAINT industries_pkey PRIMARY KEY (id);


--
-- Name: keywords keywords_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keywords
    ADD CONSTRAINT keywords_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: people_keywords people_keywords_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_keywords
    ADD CONSTRAINT people_keywords_pkey PRIMARY KEY (id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: people_tags people_tags_person_id_tag_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_tags
    ADD CONSTRAINT people_tags_person_id_tag_id_key UNIQUE (person_id, tag_id);


--
-- Name: people_tags people_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_tags
    ADD CONSTRAINT people_tags_pkey PRIMARY KEY (id);


--
-- Name: people_technologies people_technologies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_technologies
    ADD CONSTRAINT people_technologies_pkey PRIMARY KEY (id);


--
-- Name: person_employment_history person_employment_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_employment_history
    ADD CONSTRAINT person_employment_history_pkey PRIMARY KEY (id);


--
-- Name: positions positions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (id);


--
-- Name: segments segments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.segments
    ADD CONSTRAINT segments_pkey PRIMARY KEY (id);


--
-- Name: technologies technologies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.technologies
    ADD CONSTRAINT technologies_pkey PRIMARY KEY (id);


--
-- Name: directus_sync_id_map_created_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX directus_sync_id_map_created_at_index ON public.directus_sync_id_map USING btree (created_at);


--
-- Name: idx_enterprise_tags_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_enterprise_tags_name ON public.enterprise_tags USING btree (name);


--
-- Name: idx_enterprises_company_size; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_enterprises_company_size ON public.enterprises USING btree (company_size);


--
-- Name: idx_enterprises_country; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_enterprises_country ON public.enterprises USING btree (country);


--
-- Name: idx_enterprises_fiscal_identification; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_enterprises_fiscal_identification ON public.enterprises USING btree (fiscal_identification);


--
-- Name: idx_people_department; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_people_department ON public.people USING btree (department);


--
-- Name: idx_people_enterprise_relation; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_people_enterprise_relation ON public.people USING btree (enterprise_relation_id);


--
-- Name: idx_people_full_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_people_full_name ON public.people USING btree (full_name);


--
-- Name: idx_people_primary_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_people_primary_email ON public.people USING btree (primary_email);


--
-- Name: directus_access directus_access_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_comments directus_comments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_comments directus_comments_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_roles directus_roles_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_roles(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_webhooks directus_webhooks_migrated_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_migrated_flow_foreign FOREIGN KEY (migrated_flow) REFERENCES public.directus_flows(id) ON DELETE SET NULL;


--
-- Name: enterprises_industries enterprises_industries_enterprises_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_industries
    ADD CONSTRAINT enterprises_industries_enterprises_id_foreign FOREIGN KEY (enterprises_id) REFERENCES public.enterprises(id) ON DELETE SET NULL;


--
-- Name: enterprises_industries enterprises_industries_industries_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_industries
    ADD CONSTRAINT enterprises_industries_industries_id_foreign FOREIGN KEY (industries_id) REFERENCES public.industries(id) ON DELETE SET NULL;


--
-- Name: enterprises_keywords enterprises_keywords_enterprises_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_keywords
    ADD CONSTRAINT enterprises_keywords_enterprises_id_foreign FOREIGN KEY (enterprises_id) REFERENCES public.enterprises(id) ON DELETE SET NULL;


--
-- Name: enterprises_keywords enterprises_keywords_keywords_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_keywords
    ADD CONSTRAINT enterprises_keywords_keywords_id_foreign FOREIGN KEY (keywords_id) REFERENCES public.keywords(id) ON DELETE SET NULL;


--
-- Name: enterprises_locations enterprises_locations_enterprises_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_locations
    ADD CONSTRAINT enterprises_locations_enterprises_id_foreign FOREIGN KEY (enterprises_id) REFERENCES public.enterprises(id) ON DELETE SET NULL;


--
-- Name: enterprises_locations enterprises_locations_locations_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_locations
    ADD CONSTRAINT enterprises_locations_locations_id_foreign FOREIGN KEY (locations_id) REFERENCES public.locations(id) ON DELETE SET NULL;


--
-- Name: enterprises_tags enterprises_tags_enterprise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_tags
    ADD CONSTRAINT enterprises_tags_enterprise_id_fkey FOREIGN KEY (enterprises_id) REFERENCES public.enterprises(id) ON DELETE CASCADE;


--
-- Name: enterprises_tags enterprises_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_tags
    ADD CONSTRAINT enterprises_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.enterprise_tags(id) ON DELETE CASCADE;


--
-- Name: enterprises_technologies enterprises_technologies_enterprises_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_technologies
    ADD CONSTRAINT enterprises_technologies_enterprises_id_foreign FOREIGN KEY (enterprises_id) REFERENCES public.enterprises(id) ON DELETE SET NULL;


--
-- Name: enterprises_technologies enterprises_technologies_technologies_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enterprises_technologies
    ADD CONSTRAINT enterprises_technologies_technologies_id_foreign FOREIGN KEY (technologies_id) REFERENCES public.technologies(id) ON DELETE SET NULL;


--
-- Name: people fk_people_enterprise_relation; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT fk_people_enterprise_relation FOREIGN KEY (enterprise_relation_id) REFERENCES public.enterprises(id) ON DELETE SET NULL;


--
-- Name: people_keywords people_keywords_keywords_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_keywords
    ADD CONSTRAINT people_keywords_keywords_id_foreign FOREIGN KEY (keywords_id) REFERENCES public.keywords(id) ON DELETE SET NULL;


--
-- Name: people_keywords people_keywords_people_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_keywords
    ADD CONSTRAINT people_keywords_people_id_foreign FOREIGN KEY (people_id) REFERENCES public.people(id) ON DELETE SET NULL;


--
-- Name: people_tags people_tags_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_tags
    ADD CONSTRAINT people_tags_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.people(id) ON DELETE CASCADE;


--
-- Name: people_tags people_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_tags
    ADD CONSTRAINT people_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.enterprise_tags(id) ON DELETE CASCADE;


--
-- Name: people_technologies people_technologies_people_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_technologies
    ADD CONSTRAINT people_technologies_people_id_foreign FOREIGN KEY (people_id) REFERENCES public.people(id) ON DELETE SET NULL;


--
-- Name: people_technologies people_technologies_technologies_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people_technologies
    ADD CONSTRAINT people_technologies_technologies_id_foreign FOREIGN KEY (technologies_id) REFERENCES public.technologies(id) ON DELETE SET NULL;


--
-- Name: person_employment_history person_employment_history_enterprise_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_employment_history
    ADD CONSTRAINT person_employment_history_enterprise_id_foreign FOREIGN KEY (enterprise_id) REFERENCES public.enterprises(id);


--
-- Name: person_employment_history person_employment_history_person_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_employment_history
    ADD CONSTRAINT person_employment_history_person_id_foreign FOREIGN KEY (person_id) REFERENCES public.people(id);


--
-- Name: person_employment_history person_employment_history_position_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_employment_history
    ADD CONSTRAINT person_employment_history_position_id_foreign FOREIGN KEY (position_id) REFERENCES public.positions(id);


--
-- Name: segments segments_industry_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.segments
    ADD CONSTRAINT segments_industry_id_foreign FOREIGN KEY (industry_id) REFERENCES public.industries(id);


--
-- PostgreSQL database dump complete
--

