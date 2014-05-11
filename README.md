**Description**  
An all in one script designed to minimize a server install and manage all services.

**Compatibility**  

- **Operating Systems:**
  - Debian 6 (Squeeze) 64 Bit
  - Debian 6 (Squeeze) 32 Bit
  - Debian 7 (Wheezy) 64 Bit (WIP)
  - Debian 7 (Wheezy) 32 Bit (WIP)
- **Platforms:**
  - Hardware
  - KVM
  - OpenVZ
  - VirtualBox
  - VMware
  - Xen HVM

**Minstall Download**

To download Minstall run the following command under root:

	wget -O /opt/minstall.tar.gz --no-check-certificate http://www.github.com/KnightSwarm/Minstall/archive/master.tar.gz; mkdir /opt/minstall/; tar -C /opt/minstall -f /opt/minstall.tar.gz --strip-components 1 -v -x -z; ln -s /opt/minstall/libraries/default/launcher.sh /usr/local/bin/minstall

**Minstall Removal**

To remove the Minstall script run the following command under root:

	rm -rf /opt/minstall /opt/minstall.tar.gz /usr/local/bin/minstall

**Notes**  
Run on a freshly installed server under root, may not work under an already setup server!

**Usage**  
This script contains several modules designed to help you set up your server how you want it. Simply run the download command below to install to your server.

**Warning**  
No warranty. Limited support available (although I will try my best to make your experience with the script a good one!)
