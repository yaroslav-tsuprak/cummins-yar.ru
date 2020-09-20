FROM php:7.2-fpm-stretch

RUN apt-get update && apt-get install -y \
        libmcrypt-dev \
        libmcrypt4 \
        zlib1g-dev \
        libfreetype6-dev \
        libfreetype6 \
        libjpeg62-turbo-dev \
        libjpeg62-turbo \
        libpng-dev \
        $PHPIZE_DEPS \
    && docker-php-ext-install zip pdo_mysql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && pecl install mcrypt-1.0.1 \
    && docker-php-ext-enable mcrypt

RUN apt-get remove -y libjpeg62-turbo-dev libmcrypt-dev libfreetype6-dev zlib1g-dev $PHPIZE_DEPS

RUN apt-get autoremove -y
