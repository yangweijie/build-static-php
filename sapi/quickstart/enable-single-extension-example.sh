#!/bin/bash

set -exu
__DIR__=$(
  cd "$(dirname "$0")"
  pwd
)
__PROJECT__=$(
  cd ${__DIR__}/../../
  pwd
)
cd ${__PROJECT__}

if [ -f /.dockerenv ]; then
  git config --global --add safe.directory ${__PROJECT__}
fi

# 可用配置参数
# --with-swoole-pgsql=1
# --with-global-prefix=/usr
# --with-dependency-graph=1
# --with-web-ui
# @macos
# --with-build-type=dev
# --with-skip-download

php prepare.php \
  --conf-path="./conf.d.extra" \
  --with-global-prefix=/usr/local/swoole-cli \
  -opcache \
  -curl \
  -iconv \
  -bz2 \
  -bcmath \
  -pcntl \
  -filter \
  -session \
  -tokenizer \
  -mbstring \
  -ctype \
  -zlib \
  -zip \
  -posix \
  -sockets \
  -sqlite3 \
  -phar \
  -mysqlnd \
  -mysqli \
  -intl \
  -fileinfo \
  -pdo_mysql \
  -pdo_sqlite \
  -soap \
  -xsl \
  -gmp \
  -exif \
  -sodium \
  -openssl \
  -readline \
  -xml \
  -gd \
  -redis \
  -swoole \
  -yaml \
  -imagick \
  -mongodb \
  --with-swoole-pgsql=1 \
  +swoole
