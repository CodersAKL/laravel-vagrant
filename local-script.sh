#!/usr/bin/env bash

echo ">>> Running setup for Starter Site"
echo ">>>> Creating Laravel Database"

[[ -z $1 ]] && { echo "!!! MariaDB root password not set. Check the Vagrant file."; exit 1; }

MYSQL=`which mysql`
$MYSQL -uroot -p$1 -e "create database laravel;"

echo ">>>> Running migrations and seeders"

# some usefull stuff
sudo apt-get install -qq -y xfce4 virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11 mc
sudo VBoxClient-all

# Install laravel
composer config github-oauth.github.com 39616e715e915750c9bd8926d4f3c31043fd886a
composer create-project laravel/laravel $2-tmp

echo ">>>> Project created - moving files"
sleep 5

# move all files to specified directory https://github.com/composer/composer/issues/1135

# allow in windows host to create symlinks http://superuser.com/questions/124679/how-do-i-create-a-link-in-windows-7-home-premium-as-a-regular-user?answertab=votes#125981
sudo cp -u -r $2-tmp/* $2
php -r "copy('"$2"-tmp/.env.example', '"$2"/.env');"
php -r '$a=parse_ini_file("'$2'/.env");$a["DB_DATABASE"]="laravel";$a["DB_USERNAME"]="root";$a["DB_PASSWORD"]="root";file_put_contents("'$2'/.env",http_build_query($a,"","\n"));'
#php -r "$a = parse_ini_file('"$2"/.env');"

sudo rm -r -f $2-tmp/

sleep 10

cd $2

echo ">>>> Run laravel commands for first run"
composer dump-autoload
php artisan clear-compiled

php artisan migrate
php artisan db:seed

echo ">>>> Creating secret key"
php artisan key:generate

echo ">>>> *************"
echo ">>>> add to hosts file"
echo ">>>> "$3 $4
echo ">>>> *************"
