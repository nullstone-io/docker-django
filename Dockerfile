# syntax=docker/dockerfile:1

ARG PYTHON_VERSION=3.9
FROM python:${PYTHON_VERSION}-alpine

RUN pip install gunicorn

WORKDIR /
COPY entrypoint.sh .
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
COPY gunicorn.conf.py .

WORKDIR /app

EXPOSE 80
ENV PORT 80
ENV BINDING "0.0.0.0:80"
ENV WSGI_APP app:application

CMD ["gunicorn", "-c", "/gunicorn.conf.py"]
