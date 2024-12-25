-- File: 00-setup-db.sql

-- Enable psql command echoing and stop on error
\set ON_ERROR_STOP on
\set ECHO all

-- Set variables for the db_owner and db_owner_password
DO $$
DECLARE
    db_owner TEXT := 'pharmacy_management_owner';
    db_owner_password TEXT := 'secure_pharmacy_pwd'; -- TODO: Use more secure method in production
BEGIN
    -- Create role if it doesn't exist, or update if it does
    IF EXISTS (SELECT FROM pg_roles WHERE rolname = db_owner) THEN
        EXECUTE format('ALTER ROLE %I WITH PASSWORD %L CREATEROLE', db_owner, db_owner_password);
        RAISE NOTICE 'Password updated and CREATEROLE granted for existing role %', db_owner;
    ELSE
        EXECUTE format('CREATE ROLE %I LOGIN PASSWORD %L CREATEROLE', db_owner, db_owner_password);
        RAISE NOTICE 'Role % created successfully with CREATEROLE permission', db_owner;
    END IF;

    -- Grant necessary permissions to the role
    EXECUTE format('ALTER ROLE %I WITH CREATEDB', db_owner);
    RAISE NOTICE 'CREATEDB permission granted to role %', db_owner;
END $$;

-- Terminate existing connections to the database if it exists
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'pharmacy_management';

-- Check if the database exists
SELECT EXISTS(SELECT 1 FROM pg_database WHERE datname = 'pharmacy_management') AS db_exists \gset

-- Create the database if it doesn't exist
\if :db_exists
    \echo 'Database pharmacy_management already exists'
\else
    CREATE DATABASE pharmacy_management
    WITH
    OWNER = pharmacy_management_owner
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TEMPLATE = template0
    CONNECTION LIMIT = -1;

    \echo 'Database pharmacy_management created successfully'
\endif

-- Connect to the new database
\c pharmacy_management

-- Set database parameters and grant permissions
ALTER DATABASE pharmacy_management SET search_path TO public;

-- Grant permissions to the owner role
DO $$
BEGIN
    EXECUTE format('GRANT ALL PRIVILEGES ON DATABASE pharmacy_management TO pharmacy_management_owner');
    EXECUTE format('GRANT ALL PRIVILEGES ON SCHEMA public TO pharmacy_management_owner');
    EXECUTE format('ALTER DEFAULT PRIVILEGES FOR ROLE pharmacy_management_owner IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO pharmacy_management_owner');
    EXECUTE format('ALTER DEFAULT PRIVILEGES FOR ROLE pharmacy_management_owner IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO pharmacy_management_owner');
    EXECUTE format('ALTER DEFAULT PRIVILEGES FOR ROLE pharmacy_management_owner IN SCHEMA public GRANT ALL PRIVILEGES ON FUNCTIONS TO pharmacy_management_owner');
    EXECUTE format('ALTER DEFAULT PRIVILEGES FOR ROLE pharmacy_management_owner IN SCHEMA public GRANT ALL PRIVILEGES ON TYPES TO pharmacy_management_owner');
END $$;

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

\echo 'Pharmacy Management database setup completed successfully'
