# Use an official PHP 8.1 image as the base image
FROM php:8.1-apache

# Install system dependencies and PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN docker-php-ext-install sockets

RUN apt-get update && \
    apt-get install -y libicu-dev

RUN docker-php-ext-install intl

RUN apt-get update && \
    apt-get install -y libzip-dev

RUN docker-php-ext-install zip

# Install required system dependencies
RUN apt-get update && apt-get install -y libmagickwand-dev

# Install the imagick extension
RUN pecl install imagick \
    && docker-php-ext-enable imagick

# Install clamav - start as deamon
RUN apt-get install clamav clamav-daemon -y
RUN freshclam
RUN service clamav-daemon start

# Install setfacl
RUN apt-get update && apt-get install -y acl

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy server code to /var/www/html/
COPY ./pkppln /var/www/html/pn
COPY ./startup.sh /var/www/html/pn/startup.sh

RUN rm -f /var/www/html/pn/.env
COPY ./.env /var/www/html/pn/.env

WORKDIR /var/www/html

RUN mkdir -p ./data
RUN chown -R www-data:www-data ./data && \
    chmod -R 755 ./data

# Set the working directory inside the container
WORKDIR /var/www/html/pn

RUN mkdir -p ./var/logs
# RUN chown -R www-data:www-data ./var/logs && \
#     chmod -R 755 ./var/logs

RUN mkdir -p ./var/cache
# RUN chown -R www-data:www-data ./var/cache && \
#     chmod -R 755 ./var/cache

RUN mkdir -p ./var/sessions
# RUN chown -R www-data:www-data ./var/sessions && \
#     chmod -R 755 ./var/sessions

RUN chown -R www-data:www-data /var/www/html/pn && \
    chmod -R 755 /var/www/html/pn

RUN chmod +x /var/www/html/pn/startup.sh

# RUN sami -vv update --force sami.php

# RUN php-cs-fixer fix

# Other Configurations
RUN apt install -y nodejs
RUN apt install -y npm
RUN npm install -y -g yarn
RUN yarn install
RUN composer install