ARG PHP_VERSION=8.0

FROM php:${PHP_VERSION}-cli

ARG DEBUG=0
ARG ZTS=0
ARG CLANG=0

COPY ./configure-php /bin

RUN apt update && apt upgrade -y \
    && apt install -y \
        git \
        vim \
        libsqlite3-dev \
        libpq-dev \
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
        clang \
        clang-format \
        clang-tidy \
        libenchant-2-dev \
        libpng-dev \
        libwebp-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libldap-dev \
    && docker-php-source extract \
    && cd /usr/src/php \
    && /bin/configure-php "${DEBUG}" "${ZTS}" "${CLANG}" \
    && make -j8 \
    && make -j8 install \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/bin --filename=composer
