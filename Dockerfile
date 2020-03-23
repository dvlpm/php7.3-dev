FROM php:7.3-fpm

RUN apt-get update \
    && apt-get install -y \
    libpq-dev \
    zip \
    unzip \
    sqlite3 \
    libsqlite3-dev \
    m4 \
    libpng-dev \
    libjpeg-dev \
    libmagickwand-dev \
    zlib1g-dev \
    libzip-dev \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev libxpm-dev \
    libfreetype6-dev \
    zip

RUN pecl install xdebug-2.9.1
RUN docker-php-ext-enable xdebug

RUN docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-configure gd \
    --with-webp-dir=/usr/lib \
    --with-jpeg-dir=/usr/lib \
    --with-png-dir=/usr/lib \
    --with-freetype-dir=/usr/lib

RUN docker-php-ext-install pdo_mysql pdo_pgsql pdo_sqlite bcmath zip gd

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# allow www-data to write into mapped volume by faking userId
RUN usermod -u 1000 www-data

WORKDIR /var/www/html
