#!/bin/bash
# Post Clean Commands (Ubuntu)

# Clean GCC
apt-get purge -q -y gcc-4.6-base:i386 libc6:i386 libgcc1:i386

# Clean Python
echo 'Yes, do as I say!' | apt-get purge -q -y --force-yes python2.7-minimal
