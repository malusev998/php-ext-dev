ARG PHP_VERSION=8.0

FROM php:${PHP_VERSION}

ARG DEBUG=0
ARG ZTS=0
ARG DMALLOC=0

COPY ./configure-php /bin

RUN apt update && apt upgrade -y \
    && apt install -y \
        libxslt-dev \
        libargon2-dev \
        libsodium-dev \
        libreadline-dev \
        libonig-dev \
        libgmp-dev \
        libffi-dev \
        libcurl4-openssl-dev \
        zlib1g-dev \
        libssl-dev \
        libxml2-dev \
        valgrind \
    && docker-php-source extract \
    && cd /usr/src/php \
    && /bin/configure-php "${DEBUG}" "${ZTS}" "${DMALLOC}" \
    && make -j8 \
    && make install
