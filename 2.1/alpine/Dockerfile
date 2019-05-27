FROM ruby:2.1-alpine

LABEL maintainer="Angel Aviel Domaoan <dev.tenshiamd@gmail.com>"

ENV APP_HOME /var/www
ENV BUNDLE_GEMFILE $APP_HOME/Gemfile
ENV BUNDLE_JOBS 3
ENV BUNDLE_PATH /bundle

## Installs MySQL Client
RUN apk update && apk --no-cache add mysql-client && echo "MySQL Client $(mysql --version) has been installed."

## Installs PostgresQL Client
RUN apk update && apk --no-cache add postgresql-client && echo "PostgresQL Client $(psql --version) has been installed."

## Installs utilities
RUN apk update && apk --no-cache add build-base bash nano git tzdata

## Install database essentials
RUN apk update && apk --no-cache add mysql-dev postgresql-dev sqlite-dev

COPY ./bin/docker-healthcheck.sh /usr/local/bin/docker-healthcheck.sh
RUN cd /usr/local/bin && chmod 750 docker-healthcheck.sh

HEALTHCHECK --start-period=1m --interval=1m CMD ["docker-healthcheck.sh"]

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
