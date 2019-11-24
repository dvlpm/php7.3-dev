FROM php:rc-fpm

RUN apt-get update \
    && apt-get install -y libpq-dev zip unzip sqlite3 libsqlite3-dev m4 libpng-dev zlib1g-dev libzip-dev zip

RUN docker-php-ext-configure zip --with-libzip

RUN pecl install xdebug-2.8.0beta2 \
	&& docker-php-ext-enable xdebug

RUN docker-php-ext-install pdo_mysql pdo_pgsql pdo_sqlite bcmath zip gd

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/html
