#!/bin/bash
# Installs basic benchmarking utilities.

###########
## Setup ##
###########

# Change File Settings
shopt -s dotglob

# Update Package List
apt-get update

# Install Essential Build Utilities
apt-get -q -y install build-essential

# Make Tool Directory
mkdir ~/benchmark

# Change To Directory
cd ~/benchmark

###############
## Geekbench ##
###############

# Create Directory
mkdir geekbench

# Change To Directory
cd geekbench

# Download Geekbench
wget http://www.primatelabs.ca/download/Geekbench-2.1.13-Linux.tar.gz

# Extract Executables
tar xfvz Geekbench-*.tar.gz

# Move Executables
mv dist/*/* .

# Remove Temp
rm -rf dist Geekbench-*.tar.gz

# Create Shell Script (x32)
echo -e '#!/bin/bash\ncd $(dirname $0)/geekbench\n./geekbench_x86_32' > ../geekbench32.sh

# Create Shell Script (x32)
echo -e '#!/bin/bash\ncd $(dirname $0)/geekbench\n./geekbench_x86_64' > ../geekbench64.sh

# Exit Directory
cd ..

############
## IOPing ##
############

# Create Directory
mkdir ioping

# Change To Directory
cd ioping

# Download Source
wget https://ioping.googlecode.com/files/ioping-0.6.tar.gz

# Extract Source
tar xfvz ioping-*.tar.gz

# Move Source
mv ioping-*/* .

# Remove Temp
rm -rf ioping-*

# Compile
make

# Create Shell Script
echo -e '#!/bin/bash\ncd $(dirname $0)/ioping\n./ioping -c 10 .' > ../ioping.sh

# Exit Directory
cd ..

##############
## Packages ##
##############

# lshw Hardware Info
apt-get -q -y install lshw

# lshw Hardware Info Script
echo -e '#!/bin/bash\nlshw' > lshw.sh

# sysbench Benchmark
apt-get -q -y install sysbench

# sysstat Performance Monitoring
apt-get -q -y install sysstat

####################
## Scripts (Info) ##
####################

# CPU Info
echo -e '#!/bin/bash\ncat /proc/cpuinfo' > cpuinfo.sh

# Memory Info
echo -e '#!/bin/bash\ncat /proc/meminfo' > meminfo.sh

# Inode Allocation Info
echo -e '#!/bin/bash\ndf -i' > inode.sh

# vmstat Info
echo -e '#!/bin/bash\nvmstat' > vmstat.sh

#####################
## Scripts (Tests) ##
#####################

# Cachefly Network Download Test
echo -e '#!/bin/bash\nwget -O /dev/null http://cachefly.cachefly.net/100mb.test' > wget.sh

# DD Disk Test Script
echo -e '#!/bin/bash\ndd if=/dev/zero of=test bs=64k count=16k conv=fdatasync; rm test' > dd.sh

# Ping Tests
echo -e '#!/bin/bash\nping -c 5 google.com' > ping.sh

# Ping Tests
echo -e '#!/bin/bash\nping6 -c 5 google.com' > ping6.sh

################
## UNIX Bench ##
################

# Create Directory
mkdir unixbench

# Change To Directory
cd unixbench

# Download Source
wget https://byte-unixbench.googlecode.com/files/UnixBench5.1.3.tgz

# Extract Source
tar xfvz UnixBench*.tgz

# Move Source
mv UnixBench/* .

# Remove Temp
rm -rf UnixBench UnixBench*.tgz

# Create Shell Script
echo -e '#!/bin/bash\ncd $(dirname $0)/unixbench\n./Run' > ../unixbench.sh

# Exit Directory
cd ..

##################
## Finalisation ##
##################

# Change Permissions
chmod +x *.sh
