-- File: 02-02-auth.sql
-- Creates authentication-related tables that can be used in any web application

\set ON_ERROR_STOP on
\set ECHO all

-- Create schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS auth;

-- User credentials and authentication info
CREATE TABLE IF NOT EXISTS auth.credentials (
    user_id UUID PRIMARY KEY REFERENCES account.profile(id) ON DELETE CASCADE,
    password_hash TEXT NOT NULL,
    last_password_change TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    force_password_change BOOLEAN DEFAULT false,
    password_reset_token TEXT,
    password_reset_expires TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Session management
CREATE TABLE IF NOT EXISTS auth.sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES account.profile(id) ON DELETE CASCADE,
    token TEXT UNIQUE NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    ip_address INET,
    user_agent TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_active_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Authentication attempts tracking (for rate limiting and security)
CREATE TABLE IF NOT EXISTS auth.login_attempts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username_or_email VARCHAR(255) NOT NULL,
    ip_address INET,
    success BOOLEAN NOT NULL,
    attempt_time TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Two-factor authentication
CREATE TABLE IF NOT EXISTS auth.two_factor (
    user_id UUID PRIMARY KEY REFERENCES account.profile(id) ON DELETE CASCADE,
    enabled BOOLEAN DEFAULT false,
    secret TEXT,
    backup_codes TEXT[],
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- OAuth providers and connections
CREATE TABLE IF NOT EXISTS auth.oauth_providers (
    provider_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(50) UNIQUE NOT NULL,
    enabled BOOLEAN DEFAULT true,
    config JSONB DEFAULT '{}'  -- Provider-specific configuration
);

CREATE TABLE IF NOT EXISTS auth.oauth_accounts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES account.profile(id) ON DELETE CASCADE,
    provider_id UUID NOT NULL REFERENCES auth.oauth_providers(provider_id) ON DELETE CASCADE,
    provider_user_id TEXT NOT NULL,
    access_token TEXT,
    refresh_token TEXT,
    expires_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(provider_id, provider_user_id)
);

-- Update timestamp triggers
CREATE OR REPLACE FUNCTION auth.update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_credentials_timestamp
    BEFORE UPDATE ON auth.credentials
    FOR EACH ROW
    EXECUTE FUNCTION auth.update_timestamp();

CREATE TRIGGER update_two_factor_timestamp
    BEFORE UPDATE ON auth.two_factor
    FOR EACH ROW
    EXECUTE FUNCTION auth.update_timestamp();

CREATE TRIGGER update_oauth_accounts_timestamp
    BEFORE UPDATE ON auth.oauth_accounts
    FOR EACH ROW
    EXECUTE FUNCTION auth.update_timestamp();

-- Indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_sessions_user_id ON auth.sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_sessions_token ON auth.sessions(token);
CREATE INDEX IF NOT EXISTS idx_login_attempts_username ON auth.login_attempts(username_or_email);
CREATE INDEX IF NOT EXISTS idx_login_attempts_ip ON auth.login_attempts(ip_address);
CREATE INDEX IF NOT EXISTS idx_oauth_accounts_user_id ON auth.oauth_accounts(user_id);
CREATE INDEX IF NOT EXISTS idx_oauth_accounts_provider ON auth.oauth_accounts(provider_id);
