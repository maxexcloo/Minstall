#!/bin/bash
# Pre Clean Commands (Debian 7)

# Debian 7 DPKG Inport Bug Hack
string_replace_output "temp.packages.list" "temp.packages.hack" " install" ""
cat temp.packages.hack | while read line; do package_install $line; done
