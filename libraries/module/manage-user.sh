#!/bin/bash
# Common Functions For Module: Manage User

# Module Functions
manage-user() {
	#####################
	## Check Functions ##
	#####################

	# Check If Array Empty
	manage-user-check-array() {
		if [ $1 = 0 ]; then
			# Print Message
			error "No users in user array. Aborting."

			# Exit Loop
			break
		fi
	}

	# Check If User Exists
	manage-user-check-user() {
		if [ ! -d /home/$1 ]; then
			# Print Message
			echo "Invalid user ($1)."

			# Continue Loop
			continue
		fi
	}

	###########################
	## Interactive Functions ##
	###########################

	# Input Check
	manage-user-input-check() {
		# Check Loop
		while true; do
			# Take Input
			read -p "Please enter a user: " USER

			# Check Input
			if [ -d /home/$USER ]; then
				# Exit Loop
				break
			else
				# Print Error
				echo "Invalid user. Ensure the user exists on the system."
			fi
		done
	}

	# Input User
	manage-user-input-user() {
		# Check Loop
		while true; do
			# Take Input
			read -p "Please enter a user: " USER

			# Check Input
			if grep -q '^[-0-9a-zA-Z]*$' <<< $1 || [[ $1 == "default" || $1 == "system" || $1 == "www-data" ]]; then
				# Exit Loop
				break
			else
				# Print Error
				echo "Invalid user. Ensure the username contains only alphanumeric characters."
			fi
		done
	}

	##########################
	## Management Functions ##
	##########################

	# Add User
	manage-user-manage-add() {
		subheader "Adding User..."
		useradd -m -s /bin/bash $1
	}

	# Remove User
	manage-user-manage-remove() {
		subheader "Removing User..."
		userdel -f -r $1

		subheader "Removing User Home..."
		rm -rf /home/$1

		subheader "Removing User Database..."
		#PLACEHOLDER#

		subheader "Removing User HTTP..."
		rm -rf /etc/nginx/php.d/$1.conf
		rm -rf /etc/nginx/sites-*/$1-*.conf
		rm -rf /etc/php5/fpm/pool.d/$1.conf
	}

	# Set Password
	manage-user-set-password() {
		subheader "Setting Password..."
		# Check Variable Set State
		if [[ -z "$2" ]]; then
			# Set Password
			passwd $1
		else
			# Set Password
			echo "$1:$2" | chpasswd
		fi
	}

	# Set Permissions
	manage-user-set-permissions() {
		subheader "Setting Permissions..."
		chmod -R o= /home/$1
		chown -R $1:$1 /home/$1
	}

	####################
	## Misc Functions ##
	####################

	# Clean Cron
	manage-user-clean-cron() {
		subheader "Cleaning User Cron Entry..."
		echo -n "" > /tmp/cron
		crontab -u $1 /tmp/cron
		rm /tmp/cron
	}

	# HTTP Directory
	manage-user-http-directory() {
		subheader "Creating HTTP Directory..."
		mkdir -p /home/$1/http/{common,host,logs,secure}

		subheader "Changing HTTP Directory Permissions..."
		chown -R $1:$1 /home/$USER/http
		find /home/$1/http -type d -exec chmod 770 {} \;

		subheader "Adding User To WWW Group..."
		gpasswd -a www-data $1
	}
}
