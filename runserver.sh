#!/bin/sh

if [ -f "poetry.lock" ]; then
  exec poetry run ./manage.py runserver "0.0.0.0:${PORT}"
else
  exec python ./manage.py runserver "0.0.0.0:${PORT}"
fi
