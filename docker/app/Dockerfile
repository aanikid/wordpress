FROM php:7.4-cli-alpine

LABEL maintainer="Adrien DELHOM <adrien.delhom@outlook.com>"

WORKDIR /var/www/app

ARG USER=www-data
ARG UID=1000
ARG GROUP=www-data
ARG GID=1000

ENV TZ=UTC
ENV DEBIAN_FRONTEND noninteractive

# Default system packets
RUN apk add --no-cache --update --repository http://nl.alpinelinux.org/alpine/edge/testing/ $PHPIZE_DEPS \
    git \
    tzdata \
    gnupg \
    su-exec \
    supervisor \
    libcap \
    nodejs \
    npm \
    make \
    curl \
    zip \
    unzip \
    patch

RUN npm install --global yarn

# Php extensions manager
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN set -eux;
RUN chmod +x /usr/local/bin/install-php-extensions

# Install PHP extensions
RUN install-php-extensions \
    intl \
    opcache \
    mysqli \
    pdo_mysql \
    gd \
    bcmath \
    gettext \
    zip \
    xmlrpc \
    xdebug \
    @composer

COPY start-container /usr/local/bin/start-container

# Composer configuration
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_ALLOW_XDEBUG=0
ENV COMPOSER_DISABLE_XDEBUG_WARN=1

# Miscellany
RUN setcap "cap_net_bind_service=+ep" /usr/local/bin/php
RUN chmod +x /usr/local/bin/start-container
RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories
RUN chown -R $USER:$GROUP /var/www
RUN chown -R $USER:$GROUP /usr/local/bin/start-container

# Add UID and GID
RUN apk add shadow \
    && usermod -u $UID $USER

COPY php.ini /usr/local/etc/php/conf.d/99-php.ini
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENTRYPOINT ["start-container"]
