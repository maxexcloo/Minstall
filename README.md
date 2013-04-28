Notes
=====

Run on a freshly installed server under root, may not work under an already setup server!

No warranty. For help visit #minstall on Freenode and ask your question (I'm busy with school so response times may be slow...)

Compatibility
=============

**Operating Systems:**

 + Debian 6 (Squeeze) 64 Bit
 + Debian 6 (Squeeze) 32 Bit
 + Debian 7 (Wheezy) 64 Bit (WIP)
 + Debian 7 (Wheezy) 32 Bit (WIP)
 + Ubuntu 12.04 (Precise Pangolin) 32 Bit
 + Ubuntu 12.04 (Precise Pangolin) 64 Bit

**Platforms:**

 + Hardware
 + KVM
 + OpenVZ
 + VirtualBox
 + VMware
 + vServer (Debian Only)
 + Xen HVM

Instructions
============

This script contains several modules designed to help you set up your server how you want it. Simply run the below download command then run "bash minstall.sh help" or "bash minstall.sh modules" to see help or modules respectively.

**Download Minstall**

To download Minstall to your home directory (it's recommended that you download and run as root) use the following command:

	cd ~; rm -rf minstall; mkdir minstall; cd minstall; wget --no-check-certificate -O minstall.tar.gz http://www.github.com/downloads/KnightSwarm/Minstall/Latest.tar.gz; tar zxvf minstall.tar.gz; rm minstall.tar.gz

**Remove Minstall**

To remove the Minstall script run the following command under the same user you installed Minstall under:

	cd ~; rm -rf minstall
