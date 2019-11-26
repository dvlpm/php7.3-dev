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

RUN pecl install xdebug-2.8.0beta2
RUN docker-php-ext-enable xdebug

RUN docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-configure gd \
    --with-webp-dir=DIR \
    --with-jpeg-dir=DIR \
    --with-png-dir=DIR \
    --with-zlib-dir=DIR \
    --with-xpm-dir=DIR \
    --with-freetype-dir=DIR \
    --enable-gd-native-ttf

RUN docker-php-ext-install pdo_mysql pdo_pgsql pdo_sqlite bcmath zip gd

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/html
