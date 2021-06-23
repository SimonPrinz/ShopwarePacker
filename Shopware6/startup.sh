#!/usr/bin/env sh

if [ ! -e /shopware/inst.lock ]; then
  touch /shopware/inst.lock
  echo 'setting shopware up'
  php /shopware/bin/console system:setup -nq \
    --database-url=mysql://$MYSQL_USER:$MYSQL_PASSWORD@$MYSQL_HOST:3306/$MYSQL_DATABASE \
    --generate-jwt-keys
  echo 'installing shopware'
  php /shopware/bin/console system:install -fnq
fi
