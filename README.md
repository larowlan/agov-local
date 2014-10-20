Base local agov Vagrant setup
===========================

## Overview

Basic local agov Vagrant setup

## Credits

By @larowlan (drupal.org/u/larowlan)

Vagrant/Puppet manifests: Adapted from github.com/nickshuch/vd8 by Nick Schuch (nick_schuch) (Previous Next)

## Requirements for local dev

### Bundler

Install required gems for theme development with

```
bundle install --path vendor/bundle
```

Build sass with one of
```
phing compass:watch
```
or
```
phing compass:compile
```

### Virtualbox (4.3.6)

Virtualbox can be downloaded and installed from:

https://www.virtualbox.org/wiki/Downloads

### Vagrant (1.3 to 1.5)

Vagrant can be downloaded and installed from:

http://www.vagrantup.com/downloads.html

This also required the autonetwork plugin which can be installed by:

```
vagrant plugin install vagrant-auto_network
```

#### Plugins

These are software versions we know work:

* Vagrant Auto-network: 0.2.1

#### Usage

The machine can can be booted by the following command:

```
vagrant up
```

The host will be provisioned automatically on the first `vagrant up`. If you
wish to rerun the provision that can be done with the following command:

```
vagrant provision
```

More vagrant commands and documenation can be found here:

http://docs.vagrantup.com/v2

## Local DNS

WE REQUIRE THE "Vagrant Auto-network" PLUGIN AS MENTIONED ABOVE.

## Drupal

Adding agov - you need agov alongside this repo - from inside this repo:

```
cd ..
# clone agov
git clone git@github.com:previousnext/agov.git
cd agov
# setup agov
phing
# cd back to this project
cd ../agov-local
# composer install
composer install --prefer-dist
# vagrant
vagrant up
# install drupal
phing install
```

To install (warning will delete all files and database)

```
phing reinstall
```
