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

**Notes**  
Run on a freshly installed server under root, may not work under an already setup server!

**Installation**

To download Minstall run the following command under root:

	wget -O /opt/minstall.tar.gz --no-check-certificate http://www.github.com/KnightSwarm/Minstall/archive/master.tar.gz; mkdir /opt/minstall; tar -C /opt/minstall -f /opt/minstall.tar.gz --strip-components 1 -x -z; ln -s /opt/minstall/libraries/default/launcher.sh /usr/local/bin/minstall; chmod +x /usr/local/bin/minstall

To remove Minstall run the following command under root:

	rm -rf /opt/minstall /opt/minstall.tar.gz /usr/local/bin/minstall

**Examples**

	minstall -m install-extra-repositories
	minstall -m clean-packages
	minstall -m install-terminal-openssh
	minstall -m install-extra-packages

	minstall -m configure-general-system
	minstall -m configure-terminal-ssh
	minstall -m clean-upgrade
	minstall -m configure-general-user

**Warning**  
No warranty. Limited support available (although I will try my best to make your experience with the script a good one!)
