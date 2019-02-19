#################################
###        PHP-FPM 7.3        ###
###         ALPINE 3.9        ###
#################################

FROM php:fpm-alpine

MAINTAINER Kevin Imbrechts <imbrechts.kevin@protonmail.com>

ARG user=www-data
ARG port=80
ARG MANTIS_FILE=mantisbt.tar.gz

# Variables d'environnement
ENV LASTREFRESH="20190218" \
    MANTIS_VER=2.19.0 \
    MANTIS_MD5=2e9ccefa8be801db09ddd2461b4521c4

WORKDIR /var/www/html/mantisbt

COPY etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf

# General installation
RUN apk add --no-cache --virtual mypack \
            libpng-dev \
            jpeg-dev \
            libxml2-dev \
            nginx \
            supervisor \
            postgresql-libs \
            postgresql-dev \
            ssmtp && \
    docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr && \
    docker-php-ext-install gd mbstring soap && \
    # Install Postgres
    docker-php-ext-install pgsql pdo_pgsql && \
    apk del postgresql-dev && \
    # Timezone config
    rm /etc/localtime && \
    ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
    echo "Europe/Paris" > /etc/timezone && \
    # Install Mantis & md5 checksum
    curl -fSL https://sourceforge.net/projects/mantisbt/files/mantis-stable/${MANTIS_VER}/mantisbt-${MANTIS_VER}.tar.gz/download \
         -o ${MANTIS_FILE} && \
    echo "${MANTIS_MD5}  ${MANTIS_FILE}" | md5sum -c &&  \
    tar -xz --strip-components=1 -f ${MANTIS_FILE} && \
    rm ${MANTIS_FILE} && \
    chown -R www-data:www-data . && \
    # PHP & NginX config
    ln -s /usr/local/etc /etc/php && \
    rm -f /etc/nginx/conf.d/default.conf && \
    rm -f /etc/php/php-fpm.d/www.conf.default && \
    rm -f /etc/php/php-fpm.conf.default && \
    mkdir /var/run/php && \
    chown -R www-data:www-data /var/run/php/ && \
    mkdir /var/run/nginx && \
    chown -R www-data:www-data /var/run/nginx/

COPY etc/php/php-fpm.d/www.conf /etc/php/php-fpm.d/
COPY etc/php/php-fpm.conf /etc/php/php-fpm.conf
COPY etc/nginx/conf.d /etc/nginx/conf.d/
COPY etc/supervisord.conf /etc/supervisord.conf
COPY etc/supervisor/conf.d/* /etc/supervisor/conf.d/
COPY mantisbt/config/config_inc.php ./config/config_inc.php

EXPOSE ${port}

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]