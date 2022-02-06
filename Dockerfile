ARG PHP_VERSION=8.0

FROM php:${PHP_VERSION}

ARG DEBUG=0
ARG ZTS=0
ARG CLANG=0

COPY ./configure-php /bin
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN apt update && apt upgrade -y \
    && apt install -y \
        git \
        vim \
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
    && docker-php-source extract \
    && cd /usr/src/php \
    && /bin/configure-php "${DEBUG}" "${ZTS}" "${CLANG}" \
    && make -j8 \
    && make -j8 install \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/bin --filename=composer \
    && install-php-extensions \
        intl zip bcmath pcntl \
        gmp opcache amqp apcu igbinary \
        ast redis mongodb ds decimal json_post
