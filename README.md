# nullstone/django

Django Base Image that is configured with different image tags for local and production.
This image is very opinionated; however, not restrictive.

## Quick Reference

- Maintained by
  [Nullstone](https://nullstone.io)
- Where to get help
  [Nullstone Slack](https://join.slack.com/t/nullstone-community/signup)

## Supported Tags and respective `Dockerfile` links

- [local](local.Dockerfile)
- [latest](Dockerfile)

## Variants

This repository builds 2 variants of images: a local image and a production image.

### Local

The local image variant is used to run python flask in an isolated development environment on your local machine.
- All build tools are packaged in the container.
- `CMD` is set to `python manage.py runserver 0.0.0.0:9000` to run a development server with hot reload.
- `PORT` is set to `9000` to align with Nullstone conventions to quickly attach nginx sidecar (example coming soon)
- `ENTRYPOINT` is set to a custom entrypoint script that does the following:
    - Run `poetry install` - Allows developer to run `docker compose restart app` to make changes to dependencies
    - If `POSTGRES_URL` is specified, set:
        - `DB_ADAPTER=postgresql`
        - `DATABASE_URL=$POSTGRES_URL`
        - `SQLALCHEMY_DATABASE_URI=$POSTGRES_URL`
    - If `MYSQL_URL` is specified, set:
        - `DB_ADAPTER=mysql`
        - `DATABASE_URL=$MYSQL_URL`
        - `SQLALCHEMY_DATABASE_URI=$MYSQL_URL`

### Production

The production image variant uses gunicorn to run a python flask app in production mode.
- `PORT` is set to `80`
- `ENTRYPOINT` is set to a custom entrypoint script that does the following:
    - If `POSTGRES_URL` is specified, set:
        - `DB_ADAPTER=postgresql`
        - `DATABASE_URL=$POSTGRES_URL`
        - `SQLALCHEMY_DATABASE_URI=$POSTGRES_URL`
    - If `MYSQL_URL` is specified, set:
        - `DB_ADAPTER=mysql`
        - `DATABASE_URL=$MYSQL_URL`
        - `SQLALCHEMY_DATABASE_URI=$MYSQL_URL`
