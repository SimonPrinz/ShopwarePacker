FROM php:7.4-cli

ENV SHOPWARE_VERSION "v6.4.0.0"
ENV APP_URL "http://127.0.0.1"

LABEL maintainer="simon.prinz@live.de"
LABEL org.opencontainers.image.source="https://github.com/SimonPrinz/ShopwarePacker"
LABEL org.opencontainers.image.description="A Docker image for being used in GitLab Pipelines."

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y git wget \
    libzip-dev libpng-dev libicu-dev
RUN docker-php-ext-configure gd && \
    docker-php-ext-configure intl
RUN docker-php-ext-install mysqli pdo pdo_mysql gd intl zip

RUN git clone -b $SHOPWARE_VERSION --depth 1 https://github.com/shopware/production /shopware

RUN wget -O composer-setup.php https://getcomposer.org/installer && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    rm composer-setup.php

WORKDIR /shopware
RUN composer install --no-interaction -o

RUN wget -O nodesource_setup.sh https://deb.nodesource.com/setup_14.x && \
    bash nodesource_setup.sh && \
    rm nodesource_setup.sh && \
    apt-get update && \
    apt-get install -y nodejs

WORKDIR /shopware/custom/plugins/Plugin
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh
ENTRYPOINT ["/startup.sh"]
