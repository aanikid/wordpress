FROM php:7.4-fpm-alpine

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
    mysql-client \
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

# Composer configuration
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_ALLOW_XDEBUG=0
ENV COMPOSER_DISABLE_XDEBUG_WARN=1

# Miscellany
RUN setcap "cap_net_bind_service=+ep" /usr/local/bin/php

RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories
RUN chown -R $USER:$GROUP /var/www

# Add UID and GID
RUN apk add shadow \
    && usermod -u $UID $USER

RUN mkdir /home/www-data/.wp-cli
ADD xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
ADD php-fpm.conf /etc/php/php-fpm.d/
ADD php.ini /etc/php/conf.d/
ADD php.ini /etc/php/cli/conf.d/
ADD wp-cli.yaml /home/www-data/.wp-cli/config.yml

# Install wp cli
RUN curl -o wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output-dir /usr/local/bin
RUN chmod +x /usr/local/bin/wp

EXPOSE 9000
CMD ["php-fpm", "-F"]
