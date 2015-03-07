#!/usr/bin/env bash

echo ">>> Running setup for Starter Site"
echo ">>>> Creating Laravel Database"

[[ -z $1 ]] && { echo "!!! MariaDB root password not set. Check the Vagrant file."; exit 1; }

MYSQL=`which mysql`
$MYSQL -uroot -p$1 -e "create database laravel;"

echo ">>>> Running migrations and seeders"

# some usefull stuff
#sudo su
apt-get install -qq -y xfce4 virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
VBoxClient-all
#

# Install laravel
composer init --name "Laravel-vagrant" --description "Easy way to run laravel environment" --author "FDiskas" --homepage "https://github.com/FDiskas/laravel-vagrant"
if [ ! -z "$5" ]
  then
    echo ">>>> Seting up GitHub Auth key"
	composer config github-oauth.github.com $5
fi
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

composer require barryvdh/laravel-ide-helper
composer require barryvdh/laravel-debugbar
composer require mcamara/laravel-localization

# install SASS, Compass and setup a project
echo ">>>> Setup SASS, COMPASS and Bootstrap and create a project for this"
apt-get install -qq mc
apt-get install -qq ruby-dev
gem install bootstrap-sass
gem install sass
gem install compass
compass create --sass-dir "resources/assets/sass" --css-dir "public/css" --javascripts-dir "public/js" --images-dir "public/img" --fonts-dir "public/fonts" --config settings.rb -r bootstrap-sass --using bootstrap
#compass watch --pull

echo ">>>> Run laravel commands for first run"
composer dump-autoload
php artisan clear-compiled

php artisan migrate
php artisan db:seed

echo ">>>> Creating secret key"
php artisan key:generate

echo ">>> Generating IDE helper"
php artisan ide-helper:generate
php artisan ide-helper:models

echo ">>>> *************"
echo ">>>> All done now add to hosts file"
echo ">>>> "$3 $4
echo ">>>> *************"
echo ">>>> If you using SASS/compass now you can run in terminal: compass compile or compass watch --pull"
echo ">>>> *************"
