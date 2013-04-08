## Vagrant and Puppet configuration for Python & MongoDB

This is a sample Vagrant configuration with puppet provisioning to create a Virtual Box machine with Ubuntu Server 12
.10 to use Python and MongoDB.

It provides a sample example how to use it and is explained on `Usage` section.

#### Installation

1. Install [Vagrant 1.1.0](http://downloads.vagrantup.com/tags/v1.1.0)
2. Install [Virtual Box 4.2.10](https://www.virtualbox.org/wiki/Downloads)
3. Clone the repository `git clone https://github.com/danielcsgomes/vagrant-puppet-python-mongo.git`
4. Run `vagrant up` on terminal or command line
5. The step 4 should not output any error

**Note:** Vagrant will forward default MongoDB port on the created box to 50004, so if you want to connect from your local machine you can do it: `mongo localhost:500004 -u vagrant`

#### Puppet Manifest will install:

* Python 2.7 (already installed)
* MongoDB 2.4.1
* Easy_install
* Bottle
* pymongo
* wget
* git
* vim

#### Usage

1. Make sure vagrant is running (`vagrant up` or `vagrant reload`)
2. Connect to the box via ssh `vagrant ssh`, if you are on windows you need to connect via PuTTy
3. Run it: `python /vagrant/src/sample.py`
4. The output should be a list of countries.
