-- File: 00-setup-schemas.sql
--     Sets up schemas and roles for the Pharmacy Management System.
--
-- # Purpose:
--     This file defines the schema structure for a comprehensive pharmacy management system.
--     It creates separate schemas to organize different aspects of the pharmacy operations,
--     promoting modularity, security, and easier management of the application's data.
--
-- # Note:
--     This version uses hardcoded values for local development.
--     Ensure this script is run by a user with sufficient privileges to create schemas and roles.

-- Enable psql command echoing and stop on error
\set ON_ERROR_STOP on
\set ECHO all

-- Enable necessary extensions in the database
DO $$
DECLARE
    ext TEXT;
    extensions TEXT[] := ARRAY['uuid-ossp', 'pgcrypto', 'pg_trgm'];
BEGIN
    FOREACH ext IN ARRAY extensions
    LOOP
        EXECUTE format('CREATE EXTENSION IF NOT EXISTS %I', ext);
        RAISE NOTICE 'Extension % enabled', ext;
    END LOOP;
END $$;

-- Function to create schemas
CREATE OR REPLACE FUNCTION create_schemas(schema_names TEXT[])
RETURNS VOID AS $$
DECLARE
    schema_name TEXT;
BEGIN
    FOREACH schema_name IN ARRAY schema_names
    LOOP
        EXECUTE format('CREATE SCHEMA IF NOT EXISTS %I', schema_name);
        RAISE NOTICE 'Schema % created or already exists', schema_name;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Function to create role and grant privileges
CREATE OR REPLACE FUNCTION create_and_grant_role(
    role_name TEXT,
    role_password TEXT,
    primary_schemas TEXT[],
    read_schemas TEXT[]
) RETURNS VOID AS $$
DECLARE
    schema_name TEXT;
BEGIN
    -- Create role if it doesn't exist, otherwise update password
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = role_name) THEN
        EXECUTE format('CREATE ROLE %I WITH LOGIN PASSWORD %L', role_name, role_password);
        RAISE NOTICE 'Role % created successfully', role_name;
    ELSE
        EXECUTE format('ALTER ROLE %I WITH PASSWORD %L', role_name, role_password);
        RAISE NOTICE 'Password updated for existing role %', role_name;
    END IF;

    -- Grant full privileges on primary schemas
    FOREACH schema_name IN ARRAY primary_schemas
    LOOP
        EXECUTE format('GRANT ALL PRIVILEGES ON SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL PRIVILEGES ON TABLES TO %I', schema_name, role_name);
        EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT ALL PRIVILEGES ON SEQUENCES TO %I', schema_name, role_name);
    END LOOP;

    -- Grant read privileges on specified schemas
    FOREACH schema_name IN ARRAY read_schemas
    LOOP
        EXECUTE format('GRANT USAGE ON SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('GRANT SELECT ON ALL TABLES IN SCHEMA %I TO %I', schema_name, role_name);
        EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA %I GRANT SELECT ON TABLES TO %I', schema_name, role_name);
    END LOOP;

    RAISE NOTICE 'Privileges granted to % on primary schemas % and read access to %', role_name, primary_schemas, read_schemas;
END;
$$ LANGUAGE plpgsql;


-- Create schemas
DO $$
BEGIN
  RAISE NOTICE 'Starting schema creation...';
  PERFORM create_schemas(ARRAY[
    -- * main schemas
    'pharma',       -- For pharmaceutical-specific information
    'management',    -- For managing stock levels and product information

    -- * aux schemas
    'customer',     -- For managing customer profiles and histories
    'auth'         -- For user authentication and authorization
  ]);
  RAISE NOTICE 'Schema creation completed.';
EXCEPTION WHEN OTHERS THEN
  RAISE NOTICE 'Error creating schemas: %', SQLERRM;
  RAISE;
END $$;

-- * Create roles and grant privileges for each schema
-- * Note: Change the passwords and schema access as needed
SELECT create_and_grant_role(
    'some_admin',
    'some_password',
    ARRAY['pharma', 'management', 'customer'],
    ARRAY['auth']
);

-- SELECT create_and_grant_role(
--     'sales_admin',
--     'sales_password',
--     ARRAY['sales']
--     ARRAY['pharma', 'inventory', 'customer']
-- );

-- SELECT create_and_grant_role(
--     'pharma_admin',
--     'pharma_password',
--     ARRAY['pharma'],
--     ARRAY['inventory', 'sales']
-- );
