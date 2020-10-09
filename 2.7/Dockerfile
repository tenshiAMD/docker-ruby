FROM ruby:2.7

LABEL maintainer="Angel Aviel Domaoan <dev.tenshiamd@gmail.com>"

ENV APP_HOME /var/www
ENV BUNDLE_GEMFILE $APP_HOME/Gemfile
ENV BUNDLE_JOBS 3
ENV BUNDLE_PATH /bundle

RUN gem install bundler

## Installs NodeJS and NPM
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update -qq && apt-get install -y build-essential nodejs

## Installs Yarn
RUN echo "Installing yarn ..."
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn
RUN echo "Yarn $(yarn --version) has been installed."

## Installs database drivers
RUN apt-get update -qq && apt-get install -y libsqlite3-dev libpq-dev libmariadb-dev

## Installs PhantomJS
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar -xvf phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin
RUN chmod +x /usr/local/bin/phantomjs
RUN touch /tmp/openssl.cnf
ENV OPENSSL_CONF=/tmp/openssl.cnf

COPY ./bin/docker-healthcheck.sh /usr/local/bin/docker-healthcheck.sh
RUN cd /usr/local/bin && chmod 750 docker-healthcheck.sh

HEALTHCHECK --start-period=1m --interval=1m CMD ["docker-healthcheck.sh"]

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

EXPOSE 80
