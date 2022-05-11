ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION

ARG NODE_MAJOR_VERSION=16

LABEL org.opencontainers.image.source "https://github.com/tenshiamd/docker-ruby"

LABEL maintainer="Angel Aviel Domaoan <dev.tenshiamd@gmail.com>"

ENV APP_HOME /var/www
ENV BUNDLE_GEMFILE $APP_HOME/Gemfile
ENV BUNDLE_JOBS 3
ENV BUNDLE_PATH /bundle
ENV NODE_MAJOR_VERSION ${NODE_MAJOR_VERSION}

RUN gem install bundler -v "~>1.0"
RUN gem install bundler-audit

## Installs NodeJS and NPM
RUN curl -sL "https://deb.nodesource.com/setup_${NODE_MAJOR_VERSION}.x" | bash -
RUN apt-get update -qq && apt-get install -y build-essential nodejs

## Installs Yarn
RUN echo "Installing yarn ..."
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y yarn
RUN echo "Yarn $(yarn --version) has been installed."

## Installs database drivers
RUN apt-get update -qq && apt-get install -y libsqlite3-dev libpq-dev libmariadb-dev

COPY ./bin/docker-healthcheck.sh /usr/local/bin/docker-healthcheck.sh
RUN cd /usr/local/bin && chmod 750 docker-healthcheck.sh

HEALTHCHECK --start-period=1m --interval=1m CMD ["docker-healthcheck.sh"]

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

EXPOSE 80
