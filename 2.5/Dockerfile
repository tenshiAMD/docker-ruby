FROM ruby:2.5

LABEL maintainer="Angel Aviel Domaoan <dev.tenshiamd@gmail.com>"

ENV APP_HOME /var/www
ENV BUNDLE_GEMFILE $APP_HOME/Gemfile
ENV BUNDLE_JOBS 3
ENV BUNDLE_PATH /bundle

## Installs NodeJS and NPM
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update -qq && apt-get install -y build-essential nodejs npm

## Installs Yarn
RUN echo "Installing yarn ..."
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn
RUN echo "Yarn $(yarn --version) has been installed."

## Installs MySQL Client
RUN apt-get update -qq && apt-get install -y mysql-client

## Installs PostgreSQL Client
RUN apt-get update -qq && apt-get install -y postgresql-client

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
