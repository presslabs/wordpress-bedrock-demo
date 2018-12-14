FROM quay.io/presslabs/wordpress-runtime:php72-base

COPY --chown=www-data:www-data site /var/www/site/

RUN chown www-data:www-data /var/www/site \
    && su-exec www-data:www-data composer -n install --no-dev --prefer-dist --optimize-autoloader
