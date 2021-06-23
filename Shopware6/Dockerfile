FROM php:7.4-cli-alpine3.13

ENV SHOPWARE_VERSION "v6.4.0.0"
ENV APP_URL "http://127.0.0.1"

LABEL maintainer="simon.prinz@live.de"
LABEL org.opencontainers.image.source="https://github.com/SimonPrinz/ShopwarePacker"
LABEL org.opencontainers.image.description="A Docker image for being used in GitLab Pipelines."

RUN apk update && \
    apk upgrade

RUN apk add git build-base jpeg-dev zlib-dev freetype-dev libjpeg-turbo-dev libpng-dev icu-dev libzip-dev
ENV LIBRARY_PATH=/lib:/usr/lib
RUN docker-php-ext-configure gd && \
    docker-php-ext-configure intl
RUN docker-php-ext-install mysqli pdo pdo_mysql gd intl zip

RUN git clone -b $SHOPWARE_VERSION --depth 1 https://github.com/shopware/production /shopware

RUN wget -O composer-setup.php https://getcomposer.org/installer && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    rm composer-setup.php

WORKDIR /shopware
RUN composer install --no-interaction -o

WORKDIR /shopware/custom/plugins
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh
CMD [ "/startup.sh" ]
