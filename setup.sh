#!/usr/bin/env bash

echo "setup docker environement"
cp docker/app/php.ini.example docker/app/php.ini
cp docker/app/supervisord.conf.example docker/app/supervisord.conf
cp docker/app/xdebug.ini.example docker/app/xdebug.ini

echo "setup project environement"
cp .env.example .env

echo "execute docker-compose file"
docker-compose up -d

