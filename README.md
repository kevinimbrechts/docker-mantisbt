# Docker image for MantisBT (Alpine)
## Description
This Docker image contains MantisBT 2.19.0, PHP-FPM 7.3 and NginX 1.14.2.

## Installation
There is a `docker-compose.yaml` file then you can run it with `docker-compose up -d` command.
The Docker Compose file run this version of the Docker image and run `Postgres:11.1-alpine`.

## Configuration
### NginX
The configuration file for NginX is in the `./etc/nginx/conf.d/` directory. This file is included in this image and does not require any modification, but you can add a volume in the Docker Compose file or erase the file in the container with this command :
```
docker cp ./etc/nginx/conf.d/mantisbt.conf mantisbt:/etc/nginx/conf.d/mantisbt.conf
```
You MUST restart your container.

### PHP-FPM
The configuration files for PHP-FPM are in the `./etc/php/` directory. You can find :
  * ./etc/php/php-fpm.conf
  * ./etc/php/php-fpm.d/www.conf

These files is included in this image and does not require any modification, but you can add a volume in the Docker Compose file or create your own image by inheriting from this image or erase the file in the container with this command :
```
docker cp ./etc/nginx/conf.d/mantisbt.conf mantisbt:/etc/nginx/conf.d/mantisbt.conf
```
You MUST restart your container.

### Mantis
The configuration file `config_inc.php` is in the `./mantisbt/config/` directory. You MUST edit this file.
You can add a volume in the Docker Compose file or erase the file in the container with this command :
```
docker cp ./mantisbt/config_inc.php mantisbt:/var/www/html/mantisbt/config/config_inc.php
```

### SSMTP
The configuration file `ssmtp.conf`  is in the `./etc/ssmtp/` directory. You MUST edit this file.
You can add a volume in the Docker Compose file or create your own image by inheriting from this image or erase the file in the container with this command :
```
docker cp ./etc/ssmtp/ssmtp.conf mantisbt:/etc/ssmtp/ssmtp.conf
```