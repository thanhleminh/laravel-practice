FROM php:7.4-fpm

RUN apt-get update -y \
    && apt-get install -y nginx git libzip-dev zip libicu-dev libpng-dev

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs \
    && npm install --global --save-exact yarn \
    && npm install --global --save-exact prettier \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ENV PHP_CPPFLAGS="$PHP_CPPFLAGS -std=c++11"

RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && docker-php-ext-install opcache \
    && apt-get install libicu-dev -y \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-install gd \
    && apt-get remove libicu-dev icu-devtools -y
RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/php-opocache-cfg.ini

RUN curl -s https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

COPY ./conf/nginx/nginx-site.conf /etc/nginx/sites-enabled/default

COPY --chown=www-data:www-data . /var/www/html
