# syntax=docker/dockerfile:1

ARG PYTHON_VERSION=3.9
FROM python:${PYTHON_VERSION}-alpine

# Install poetry
RUN apk add --no-cache gcc musl-dev libffi-dev
RUN python -m pip install --upgrade pip
RUN pip install poetry
RUN apk del gcc musl-dev libffi-dev

WORKDIR /
COPY local.entrypoint.sh .
RUN chmod +x /local.entrypoint.sh
ENTRYPOINT ["/local.entrypoint.sh"]

WORKDIR /app

EXPOSE 9000
ENV PORT 9000

COPY runserver.sh /
RUN chmod +x /runserver.sh
CMD ["/runserver.sh"]
