# syntax=docker/dockerfile:1

FROM python:3.12-slim

WORKDIR /app

COPY app.py .

ARG VERSION=dev
ENV APP_VERSION=${VERSION}

CMD ["python", "app.py"]
