#!/usr/bin/env bash

set -exu
__DIR__=$(
  cd "$(dirname "$0")"
  pwd
)
__PROJECT__=$(
  cd ${__DIR__}/../../../
  pwd
)
cd ${__PROJECT__}

REDIS_VERSION=5.3.7
MONGODB_VERSION=1.14.2
YAML_VERSION=2.2.2
IMAGICK_VERSION=3.7.0

mkdir -p pool/ext
mkdir -p pool/lib
mkdir -p pool/php-tar

WORK_DIR=${__PROJECT__}/var/cygwin-build/
EXT_TEMP_CACHE_DIR=${WORK_DIR}/pool/ext/
mkdir -p ${WORK_DIR}
mkdir -p ${EXT_TEMP_CACHE_DIR}
test -d ${WORK_DIR}/ext/ && rm -rf ${WORK_DIR}/ext/
mkdir -p ${WORK_DIR}/ext/

cd ${__PROJECT__}/pool/ext
if [ ! -f redis-${REDIS_VERSION}.tgz ]; then
  curl -fSLo ${EXT_TEMP_CACHE_DIR}/redis-${REDIS_VERSION}.tgz https://pecl.php.net/get/redis-${REDIS_VERSION}.tgz
  mv ${EXT_TEMP_CACHE_DIR}/redis-${REDIS_VERSION}.tgz ${__PROJECT__}/pool/ext
fi
mkdir -p ${WORK_DIR}/ext/redis/
tar --strip-components=1 -C ${WORK_DIR}/ext/redis/ -xf redis-${REDIS_VERSION}.tgz

: <<EOF
# mongodb 扩展 不支持 cygwin 环境下构建
# 详见： https://github.com/mongodb/mongo-php-driver/issues/1381

cd ${__PROJECT__}/pool/ext
if [ ! -f mongodb-${MONGODB_VERSION}.tgz ]; then
  curl -fSLo ${EXT_TEMP_CACHE_DIR}/mongodb-${MONGODB_VERSION}.tgz https://pecl.php.net/get/mongodb-${MONGODB_VERSION}.tgz
  mv ${EXT_TEMP_CACHE_DIR}/redis-${REDIS_VERSION}.tgz ${__PROJECT__}/pool/ext
fi
mkdir -p ${WORK_DIR}/ext/mongodb/
tar --strip-components=1 -C ${WORK_DIR}/ext/mongodb/ -xf redis-${REDIS_VERSION}.tgz

EOF

cd ${__PROJECT__}/pool/ext
if [ ! -f yaml-${YAML_VERSION}.tgz ]; then
  curl -fSLo ${EXT_TEMP_CACHE_DIR}/yaml-${YAML_VERSION}.tgz https://pecl.php.net/get/yaml-${YAML_VERSION}.tgz
  mv ${EXT_TEMP_CACHE_DIR}/yaml-${YAML_VERSION}.tgz ${__PROJECT__}/pool/ext
fi
mkdir -p ${WORK_DIR}/ext/yaml/
tar --strip-components=1 -C ${WORK_DIR}/ext/yaml/ -xf yaml-${YAML_VERSION}.tgz

cd ${__PROJECT__}/pool/ext
if [ ! -f imagick-${IMAGICK_VERSION}.tgz ]; then
  curl -fSLo ${EXT_TEMP_CACHE_DIR}/imagick-${IMAGICK_VERSION}.tgz https://pecl.php.net/get/imagick-${IMAGICK_VERSION}.tgz
  mv ${EXT_TEMP_CACHE_DIR}/imagick-${IMAGICK_VERSION}.tgz ${__PROJECT__}/pool/ext
fi
mkdir -p ${WORK_DIR}/ext/imagick/
tar --strip-components=1 -C ${WORK_DIR}/ext/imagick/ -xf imagick-${IMAGICK_VERSION}.tgz

# cp -rf var/cygwin-build/ext/* var/
cp -rf ${WORK_DIR}/ext/* ${__PROJECT__}/ext/

cd ${__PROJECT__}
