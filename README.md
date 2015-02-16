# laravel-vagrant

## The easy way to install latest laravel and run the vagrant

To configure for your needs please edit Vagrant file.
Simple checkout this repository and then run the command

```vagrant up```

### Windows users
ran this command before ```vagrant up``` in an admin command prompt on windows :

```fsutil behavior set SymlinkEvaluation L2L:1 R2R:1 L2R:1 R2L:1```


This will install
  1. Ubuntu 14.04 x64
  1. Apache
  1. Ruby
  1. SASS
  1. COMPASS
  1. Composer
  1. PHP 5.5
  1. MySQL 5.5
  1. SQLite
  1. Elastic Search and ElasticHQ
  1. Memcached
  1. Nodejs
  
By default this vagrant starting with GUI, so no need to conect to the server via SSH. Default login is 
```
User: vagrant
Pass: vagrant
```
Scripts for installing tools is used from https://github.com/fideloper/Vaprobash
