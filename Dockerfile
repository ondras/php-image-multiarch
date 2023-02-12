FROM php:8-apache

RUN apt update && \
	apt install -y libxslt1-dev libsqlite3-dev libpng-dev libjpeg-dev libxslt1.1 libsqlite3-0 && \
	docker-php-ext-configure gd --with-jpeg && \
	docker-php-ext-install pdo pdo_mysql pdo_sqlite xsl gd && \
	apt purge --auto-remove -y libxslt1-dev libsqlite3-dev && \
	apt clean

RUN a2enmod rewrite

ENV APACHE_DOCUMENT_ROOT /var/www/html
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
