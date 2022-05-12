# syntax=docker/dockerfile:1

ARG PYTHON_VERSION=3.9
FROM python:${PYTHON_VERSION}-alpine

# Install poetry
RUN apk add --no-cache gcc musl-dev libffi-dev
RUN python -m pip install --upgrade pip
RUN pip install poetry
RUN apk del gcc musl-dev libffi-dev

RUN pip install gunicorn

WORKDIR /
COPY entrypoint.sh .
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

COPY gunicorn.conf.py /

WORKDIR /app

EXPOSE 80
ENV PORT 80
ENV BINDING "0.0.0.0:80"
ENV WSGI_APP app:application

CMD ["gunicorn", "-c /gunicorn.conf.py"]
