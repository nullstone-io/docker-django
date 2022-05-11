#!/bin/sh

exec poetry run ./manage.py runserver "0.0.0.0:${PORT}"
