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
RUN echo -e 'http://dl-cdn.alpinelinux.org/alpine/edge/main\nhttp://dl-cdn.alpinelinux.org/alpine/edge/community\nhttp://dl-cdn.alpinelinux.org/alpine/edge/testing' > /etc/apk/repositories
RUN apk update && apk --no-cache add yarn && echo "Yarn $(yarn --version) has been installed."

## Installs MySQL Client
RUN apk update && apk --no-cache add mysql-client && echo "MySQL Client $(mysql --version) has been installed."

## Installs PostgresQL Client
RUN apk update && apk --no-cache add postgresql-client && echo "PostgresQL Client $(psql --version) has been installed."

## Installs utilities
RUN apk update && apk --no-cache add build-base bash nano git tzdata

## Install database essentials
RUN apk update && apk --no-cache add mysql-dev postgresql-dev sqlite-dev

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
