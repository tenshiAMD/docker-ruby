FROM ruby:2.6

LABEL maintainer="Angel Aviel Domaoan <dev.tenshiamd@gmail.com>"

ENV APP_USER app
ENV APP_HOME /home/${APP_USER}

ENV BUNDLE_GEMFILE $APP_HOME/Gemfile
ENV BUNDLE_JOBS 3
ENV BUNDLE_PATH /var/${APP_USER}/bundle

ENV PORT 80

ENV HEALTHCHECK_URL http://localhost:$PORT/health/all

RUN apt-get update -qq && apt-get install -y build-essential wget

## Installs database drivers
RUN apt-get update -qq && apt-get install -y libsqlite3-dev libpq-dev libmariadb-dev

## Installs NodeJS and NPM
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -
RUN apt-get update -qq && apt-get install -y nodejs

## Installs Yarn
RUN echo "Installing yarn ..."
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn
RUN echo "Yarn $(yarn --version) has been installed."

## Installs PhantomJS
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar -xvf phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin
RUN chmod +x /usr/local/bin/phantomjs
RUN touch /tmp/openssl.cnf
ENV OPENSSL_CONF=/tmp/openssl.cnf

## Installs `dockerize`
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN gem uninstall bundler
RUN gem install bundler

## Create user and group
RUN mkdir -p ${APP_HOME} \
    mkdir -p ${BUNDLE_PATH}
RUN groupadd --gid 9999 ${APP_USER} \
  && useradd --uid 9999 --gid ${APP_USER} ${APP_USER} \
  && chmod -R 775 \
    ${APP_HOME} \
    /var/${APP_USER} \
  && chown -R ${APP_USER}:${APP_USER} \
    ${APP_HOME} \
    /var/${APP_USER}
VOLUME ["/var/${APP_USER}"]

COPY ./bin/* /usr/local/bin/
RUN chmod 750 /usr/local/bin/docker-entrypoint.sh && chown -R ${APP_USER}:${APP_USER} /usr/local/bin/docker-entrypoint.sh

WORKDIR $APP_HOME

USER ${APP_USER}

EXPOSE ${PORT}

HEALTHCHECK --interval=1m --start-period=3m --retries=3 CMD [ "curl -f ${HEALTHCHECK_URL}" ]

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD [ "bundle", "exec", "foreman", "start" ]
