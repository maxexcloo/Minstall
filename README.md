Notes
=====

Run on a freshly installed server under root, may not work under an already setup server!

No warranty. Limited support available (although I will try my best to make your experience with the script a good one!)

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
 + Xen PV (WIP)

Instructions
============

This script contains several modules designed to help you set up your server how you want it. Simply run the download command below to install to your server.

**Download Minstall**

To download Minstall run the following command under root:

	wget -O /opt/minstall.tar.gz --no-check-certificate http://www.github.com/KnightSwarm/Minstall/archive/master.tar.gz; mkdir /opt/minstall/; tar -C /opt/minstall -f /opt/minstall.tar.gz --strip-components 1 -v -x -z; ln -s /opt/minstall/libraries/default/launcher.sh /usr/local/bin/minstall

**Remove Minstall**

To remove the Minstall script run the following command under root:

	rm -rf /opt/minstall /opt/minstall.tar.gz /usr/bin/minstall
