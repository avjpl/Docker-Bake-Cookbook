FROM postgres:18-alpine

COPY init.sql /docker-entrypoint-initdb.d/

ENV POSTGRES_DB=cookbook4
ENV POSTGRES_USER=appuser
ENV POSTGRES_PASSWORD=devpassword
