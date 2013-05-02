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
DIRECTORY="mysql"

# Download Link
LINK="http://www.sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/3.5.2.2/phpMyAdmin-3.5.2.2-english.tar.gz/download"

###############
## Functions ##
###############

# Random String Generator
function rand() {
	[ "$2" == "0" ] && CHAR="[:alnum:]" || CHAR="[:graph:]"
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
wget -O script.tar.gz $LINK

# Extract Script
tar xfvz script.tar.gz

# Move Script
mv phpMyAdmin-*/* .

# Remove Temp
rm -rf phpMyAdmin-* script.tar.gz

# Update Config
cat > config.inc.php <<END
<?php
\$cfg['blowfish_secret'] = '$(rand 40 0)';

\$i = 0;
\$i++;
\$cfg['Servers'][\$i]['auth_type'] = 'cookie';
\$cfg['Servers'][\$i]['compress'] = false;
\$cfg['Servers'][\$i]['connect_type'] = 'tcp';
\$cfg['Servers'][\$i]['extension'] = 'mysqli';
\$cfg['Servers'][\$i]['hide_db'] = '^(information_schema|mysql|performance_schema|test)\$';
\$cfg['Servers'][\$i]['host'] = 'localhost';

\$cfg['PmaNoRelation_DisableWarning'] = true;
\$cfg['SaveDir'] = '';
\$cfg['SuhosinDisableWarning'] = true;
\$cfg['UploadDir'] = '';
?>
END

# Clean Useless Files
rm -rf examples setup ChangeLog config.sample.inc.php LICENSE README README.VENDOR RELEASE-DATE-*

# Update Permissions
chmod -R o= /home/$USER/http/hosts/$HOST/$DIRECTORY

# Update Owner
chown -R $USER:$USER /home/$USER/http/hosts/$HOST/$DIRECTORY
