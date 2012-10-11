Notes
=====

Run on a freshly installed server under root, may not work under an already setup server!

No warranty. For help visit #minstall on Freenode and ask your question (I'm busy with school so repsonse times may be slow...)

Compatibility
=============

**Operating Systems:**

 + Debian 6 (Squeeze) i686
 + Debian 6 (Squeeze) x86_64
 + Ubuntu 12.04 (Precise Pangolin) i686
 + Ubuntu 12.04 (Precise Pangolin) x86_64

**Platforms:**

 + KVM
 + OpenVZ
 + Physical Hardware
 + Virtualbox
 + VMware
 + vServer (Debian Only)
 + Xen HVM
 + Xen PV (Unsupported)

Instructions
============

This script contains several modules designed to help you set up your server how you want it. Simply run the below download command then run "bash minstall.sh help" or "bash minstall.sh modules" to see help or modules respectively.

**Download Minstall**

To download Minstall to your home directory (it's recomended that you download and run as root) use the following command:

`cd ~; rm -rf minstall; mkdir minstall; cd minstall; wget --no-check-certificate -O minstall.tar.gz http://www.github.com/downloads/KnightSwarm/Minstall/Latest.tar.gz; tar zxvf minstall.tar.gz; rm minstall.tar.gz`

**Upgrading Packages**

To upgrade your installed packages regularly and retain Minstall system structure it's recomended that you use the following command:

`bash minstall.sh configure-upgrade`

**Remove Minstall**

To remove the Minstall script run the following command under the same user you installed Minstall under:

`cd ~; rm -rf minstall`

Sample Commands
===============

**Install**

	bash minstall.sh install-extra-repositories
	bash minstall.sh clean-packages
	bash minstall.sh install-ssh
	bash minstall.sh install-extra-packages

**Configure**

	bash minstall.sh configure-general
	bash minstall.sh configure-ssh
	bash minstall.sh configure-upgrade
	bash minstall.sh configure-user

**HTTP**

	bash minstall.sh http-install-exim
	bash minstall.sh http-install-mysql
	bash minstall.sh http-install-nginx
	bash minstall.sh http-install-php
	bash minstall.sh http-install-php-extra
	bash minstall.sh http-configure-mysql
	bash minstall.sh http-configure-nginx

**Manage**

	bash minstall.sh manage-add-user
	bash minstall.sh manage-add-host
