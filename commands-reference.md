# Docker Commands Reference

## Containers

### Database

```bash
# Build and run DB container individually (name: gwa/db)
docker build -t gwa/db:pgsql -f ./server/db/db.Dockerfile ./server/db
# add --no-cache to rebuild from scratch
docker run --env-file ./.env gwa/db:pgsql  # Run container in foreground

# * Run in background w/ a name (gwa-db)
docker run --env-file ./.env --rm -d --name gwa-db gwa/db:pgsql

# Using docker-compose (recommended)
docker-compose up db
```

#### DB Management
To handle the database you must load the environment variables and connect to the database.

```pwsh
#! pwsh
$env_vars = Get-Content .env | ConvertFrom-StringData  # load environment variables
docker exec -it gwa-db psql -U $env_vars.DB_OWNER_ADMIN -d $env_vars.DB_NAME
```

```bash
#! bash
env_vars=$(cat .env | xargs)  # load environment variables
docker exec -it gwa-db psql -U $DB_OWNER_ADMIN -d $DB_NAME
```

### API

```bash
# Build and run API container individually
docker build -t api-image -f ./server/api/api.Dockerfile ./server/api
docker run --env-file ./.env api-image

# Using docker-compose (recommended)
docker-compose up api
```

### Frontend

```bash
# Build and run Frontend container individually
docker build -t frontend-image -f ./frontend/Dockerfile ./frontend
docker run -p 5173:5173 frontend-image

# Using docker-compose (recommended)
docker-compose up frontend
```

## Full Stack Development

```bash
# Start all services
docker-compose up

# Start in detached mode
docker-compose up -d

# View logs
docker-compose logs -f

# Stop all services
docker-compose down

# Rebuild containers
docker-compose up --build
```

----
----
----

## Useful Docker Commands

```bash
# List all containers
docker ps -a

# List all images
docker images

# Remove all stopped containers
docker container prune

# Remove all unused images
docker image prune

# Remove all unused volumes
docker volume prune

# Clean up everything
docker system prune -a --volumes
```
