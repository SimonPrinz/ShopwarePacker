#!/usr/bin/env bash

if [ ! -e /shopware/inst.lock ]; then
  echo 'setting shopware up'
  php /shopware/bin/console system:setup -nq \
    --database-url=mysql://$MYSQL_USER:$MYSQL_PASSWORD@$MYSQL_HOST:3306/$MYSQL_DATABASE \
    --generate-jwt-keys
  echo 'installing shopware'
  php /shopware/bin/console system:install -fnq
  touch /shopware/inst.lock
fi

command="$@"
if [ "x$command" = "x" ];
then
  tail -f /dev/null
else
  bash -c "$command"
fi
