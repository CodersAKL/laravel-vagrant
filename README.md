# laravel-vagrant

## The easy way to install latest laravel and run the vagrant

To configure for your needs please edit Vagrant file.
Simple checkout this repository and then run the command

```vagrant up```

### Windows users
 [Recommended terminal for windows][1]
 [1]: http://bliker.github.io/cmder/

ran this command before ```vagrant up``` in an **admin** command prompt on windows :

```
fsutil behavior set SymlinkEvaluation L2L:1 R2R:1 L2R:1 R2L:1
```

then go to your project dir and run as **admin**. More info why https://github.com/mitchellh/vagrant/issues/713

```
vagrant up
```

This will install
  1. Ubuntu 14.04 x64
  1. Apache
  1. Ruby
  1. SASS
  1. COMPASS
  1. Bootstrap-sass
  1. Composer
  1. PHP 5.5
  1. MySQL 5.5
  1. SQLite
  1. Elastic Search and ElasticHQ
  1. Memcached
  1. Nodejs
  
By default this vagrant starting with GUI, so no need to connect to the server via SSH. Default login is 

```
User: vagrant
Pass: vagrant
```
Login to the server using SSH

```
user: vagrant
host: 127.0.0.1
port: 2222
ssh url: ssh://vagrant@127.0.0.1:2222
```

#### For COMPASS users
please use the --poll setting in watch command see: https://github.com/Compass/compass/issues/394

```
compass watch /vagrant --poll
```

Scripts for installing tools is used from https://github.com/fideloper/Vaprobash

1. https://github.com/barryvdh/laravel-debugbar
1. https://github.com/mcamara/laravel-localization
1. https://github.com/Zizaco/entrust/tree/laravel-5
