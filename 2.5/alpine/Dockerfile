FROM ruby:2.5-alpine

LABEL maintainer="Angel Aviel Domaoan <dev.tenshiamd@gmail.com>"

ENV APP_HOME /var/www
ENV BUNDLE_GEMFILE $APP_HOME/Gemfile
ENV BUNDLE_JOBS 3
ENV BUNDLE_PATH /bundle

## Installs NodeJS
RUN apk update && apk --no-cache add  nodejs-current && echo "NodeJS $(node --version) has been installed."

## Installs NPM
RUN apk update && apk --no-cache add  nodejs-current-npm && echo "NPM $(npm --version) has been installed."

## Installs Yarn
RUN apk update && apk --no-cache add yarn && echo "Yarn $(yarn --version) has been installed."

## Installs MySQL Client
RUN apk update && apk --no-cache add mysql-client && echo "MySQL Client $(mysql --version) has been installed."

## Installs PostgresQL Client
RUN apk update && apk --no-cache add postgresql-client && echo "PostgresQL Client $(psql --version) has been installed."

## Installs utilities
RUN apk update && apk --no-cache add build-base nano git tzdata curl bash

## Install database essentials
RUN apk update && apk --no-cache add mysql-dev postgresql-dev sqlite-dev

## Installs Imagemagick
RUN apk add --no-cache imagemagick imagemagick-dev

COPY ./bin/docker-healthcheck.sh /usr/local/bin/docker-healthcheck.sh
RUN cd /usr/local/bin && chmod 750 docker-healthcheck.sh

HEALTHCHECK --start-period=1m --interval=1m CMD ["docker-healthcheck.sh"]

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
