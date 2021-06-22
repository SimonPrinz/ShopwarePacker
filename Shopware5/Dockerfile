FROM alpine

LABEL maintainer="simon.prinz@live.de"
LABEL org.opencontainers.image.source https://github.com/SimonPrinz/ShopwarePacker
LABEL org.opencontainers.image.description A Docker image for being used in GitLab Pipelines.

RUN apk update
RUN apk add git
RUN apk add php php-json php-phar php-mbstring php-openssl
RUN wget -O composer-setup.php https://getcomposer.org/installer && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    rm composer-setup.php

VOLUME [ "/srv" ]
WORKDIR /srv