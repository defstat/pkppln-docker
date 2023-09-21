#!/bin/sh

sleep 60

echo "Starting startup.sh script..."

php ./bin/console doctrine:schema:update --force
php ./bin/console nines:user:create admin@example.com test test
php ./bin/console nines:user:promote admin@example.com ROLE_ADMIN
php ./bin/console nines:user:password admin@example.com test
php ./bin/console nines:user:activate admin@example.com

php ./bin/console cache:clear --env=prod

apache2-foreground