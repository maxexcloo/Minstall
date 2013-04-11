#!/bin/bash
# Basic phpMyAdmin Installer.

###############
## Variables ##
###############

# User (Owner Of Virtual Host)
USER="main"

# Virtual Host
HOST="host.example.com"

# Directory Under Virtual Host Where Script Will Be Installed, Leave Empty For Installation Into Virtual Host Root
DIRECTORY="phpmyadmin"

# Script URL
URL="http://www.sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/3.5.7/phpMyAdmin-3.5.7-english.tar.gz/download"

###############
## Functions ##
###############

# Random String Generator
function rand() {
	[ "$2" = "0" ] && CHAR="[:alnum:]" || CHAR="[:graph:]"
	cat /dev/urandom | tr -cd "$CHAR" | head -c ${1:-48}
	echo
}

############
## Script ##
############

# Change File Settings
shopt -s dotglob

# Change Directory
cd /home/$USER/http/hosts/$HOST

# Check If Directory Variable Empty
if [[ $DIRECTORY != "" ]]; then
	# Make Script Directory
	mkdir $DIRECTORY

	# Change Directory
	cd $DIRECTORY
fi

# Download Script
wget -O phpmyadmin.tar.gz "$URL"

# Extract Script
tar xfvz phpmyadmin.tar.gz

# Move Script
mv phpMyAdmin-*/* .

# Update Config
cat > config.inc.php <<END
<?php
\$cfg['blowfish_secret'] = '$(rand 40 0)';

\$i = 0;
\$i++;
\$cfg['Servers'][\$i]['auth_type'] = 'cookie';
\$cfg['Servers'][\$i]['connect_type'] = 'tcp';
\$cfg['Servers'][\$i]['extension'] = 'mysqli';
\$cfg['Servers'][\$i]['host'] = 'localhost';

\$cfg['PmaNoRelation_DisableWarning'] = true;
\$cfg['SaveDir'] = '';
\$cfg['SuhosinDisableWarning'] = true;
\$cfg['UploadDir'] = '';
?>
END

# Clean Useless Files
rm -rf ChangeLog config.sample.inc.php examples LICENSE phpMyAdmin-* phpmyadmin.tar.gz README README.VENDOR RELEASE-DATE-* setup

# Update Owner
chown -R $USER:$USER .

# Update Permissions
chmod -R o= .
