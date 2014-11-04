docker-piwik
============

A runnable Piwik installation in Docker containers and orchestrated by Fig. The infrastructure of containers is pretty straight forward:

```
php+nginx <==> mysql
```

### Requirements

* [Docker](https://docs.docker.com/installation/)
* [Fig](http://www.fig.sh/install.html)


### Getting started

In order to connect to both containers you can create two ssh keys as following:

__For the web server container__
```
$ ssh-keygen -f docker
```
_PS: enter a passphrase or not as your secure mind expects_


__For the database container__

```
$ ssh-keygen -f mysql/docker
```
_PS: enter a passphrase or not as your secure mind expects_

For SSL access of the piwik installation, install your certificate and key inside the `ssl/` directory. You can find documentation on the internet to generate autosigned ones for dev purposes.
Simply make sure your files ends with `.crt` and `.key` for the certificate and the key respectively.

### Launch

Make sure you created a `fig.yml` file (from the `fig.yml.sample` file, the two important changes to make are to replace `/home/ubuntu/piwik` by your local path to your piwik installation and replace `/home/ubuntu/data/mysql` by a local path to store mysql's data)

And start the two containers
```
$ sudo fig up -d
```
