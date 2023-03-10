FROM php:8.1-apache

RUN apt update && \
	apt install -y exiftool libxslt1-dev libsqlite3-dev libpng-dev libjpeg-dev libxslt1.1 libsqlite3-0 && \
	docker-php-ext-configure gd --with-jpeg && \
	docker-php-ext-install mysqli pdo pdo_mysql pdo_sqlite xsl gd && \
	apt purge --auto-remove -y libxslt1-dev libsqlite3-dev && \
	apt clean

RUN a2enmod rewrite userdir headers

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

ENV APACHE_DOCUMENT_ROOT /var/www/html
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
