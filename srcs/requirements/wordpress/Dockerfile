FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-mysql \
    wget \
    curl \
    mariadb-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/wordpress
RUN mkdir -p /run/php
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/configure_wordpress.sh /configure_wordpress.sh
RUN chmod +x /configure_wordpress.sh

EXPOSE 9000

# Correct
CMD ["/bin/bash", "/configure_wordpress.sh"]
