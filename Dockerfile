FROM php:7.4.0RC1-fpm

RUN apt-get install git subversion openssh mercurial tini bash patch zip unzip php-pgsql
RUN pecl install xdebug
RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql xdebug

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/html
