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

## Images

This repository builds 2 variants of images: a local image and a production image.

All images are configured to log to stdout/stderr.

### Local

The local image variant is used to run python django in an isolated development environment on your local machine.

#### Dev Server

The `local` variant is configured to run the built-in server using the conventional `./manage.py runserver`.
This image does not contain a `manage.py`; this requires a valid `manage.py` located in your repository to work properly.

The server listens on port `9000` by default to align with Nullstone conventions to quickly attach an nginx sidecar (example coming soon)
To change this port, use `PORT` environment variable.

#### Dependencies

This image detects `requirements.txt` or `poetry.lock` files and installs dependencies on boot.
To update dependencies in a container using this image, restart the docker container. 
On boot, the image will run either `pip install -r requirements.txt` or `poetry install`.

#### Databases

Database environment variables are mapped to align with Nullstone conventions.
- If `POSTGRES_URL` is specified, set:
  - `DB_ADAPTER=postgresql`
  - `DATABASE_URL=$POSTGRES_URL`
  - `SQLALCHEMY_DATABASE_URI=$POSTGRES_URL`
- If `MYSQL_URL` is specified, set
  - `DB_ADAPTER=mysql`
  - `DATABASE_URL=$MYSQL_URL`
  - `SQLALCHEMY_DATABASE_URI=$MYSQL_URL`

### Production

The production image variant (any image tags that don't contain `local`) is used to run django in a production environment.

#### App Name

When creating a `Dockerfile` for your app, you will need to set `WSGI_APP` based on your application name.
The format for typical Django projects is `<project-directory>.wsgi:application` where `<project-directory>` is the name of the directory that contains your `wsgi.py`. 

#### Gunicorn

The production variant is configured to run a production server using `gunicorn`.
There is a standard `gunicorn.conf.py` packaged with this image that accepts the following env vars:
- `WSGI_APP` - accepts `<module>:<app>` to run 
- `BINDING` - `<addr>:<port>`
- `WEB_CONCURRENCY` - Sets number of workers; defaults to 2 * CPUs
- `PYTHON_MAX_THREADS` - Sets number of threads; defaults to 1

#### Databases

Database environment variables are mapped to align with Nullstone conventions.
- If `POSTGRES_URL` is specified, set:
    - `DB_ADAPTER=postgresql`
    - `DATABASE_URL=$POSTGRES_URL`
    - `SQLALCHEMY_DATABASE_URI=$POSTGRES_URL`
- If `MYSQL_URL` is specified, set
    - `DB_ADAPTER=mysql`
    - `DATABASE_URL=$MYSQL_URL`
    - `SQLALCHEMY_DATABASE_URI=$MYSQL_URL`
