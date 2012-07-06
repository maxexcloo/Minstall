#!/bin/bash
# Configure: General Configuration

# Change Default System Shell
if question --default yes "Do you want to change the default system shell? (Y/n)" || [ $(read_var_module shell) = 1 ]; then
	subheader "Changing Default System Shell..."
	# Check Distribution
	if [ $DISTRIBUTION = "debian" ]; then
		# Attended Mode
		if [ $UNATTENDED = 0 ]; then
			dpkg-reconfigure dash
		# Unattended Mode
		else
			# DASH Enabled
			if [ $(read_var_module shell_option_dash) = 1 ]; then
				ln -f -s dash /bin/sh
				ln -f -s bash /bin/sh.distrib
				ln -f -s dash.1.gz /usr/share/man/man1/sh.1.gz
				ln -f -s bash.1.gz /usr/share/man/man1/sh.distrib.1.gz
			# BASH Enabled
			else
				ln -f -s bash /bin/sh
				ln -f -s dash /bin/sh.distrib
				ln -f -s bash.1.gz /usr/share/man/man1/sh.1.gz
				ln -f -s dash.1.gz /usr/share/man/man1/sh.distrib.1.gz
			fi
		fi
	fi
fi

# Change System Timezone
if question --default yes "Do you want to change the system timezone? (Y/n)" || [ $(read_var_module timezone) = 1 ]; then
	subheader "Changing System Timezone..."
	# Check Distribution
	if [ $DISTRIBUTION = "debian" ]; then
		# Attended Mode
		if [ $UNATTENDED = 0 ]; then
			# Set Timezone Manually
			dpkg-reconfigure tzdata
		# Unattended Mode
		else
			# Set Timezone From File
			echo $(read_var_module timezone_option) > /etc/timezone
			dpkg-reconfigure -f noninteractive tzdata
		fi
	fi
fi

# Disable BASH History
if question --default yes "Do you want to disable BASH history? (Y/n)" || [ $(read_var_module bash_history) = 1 ]; then
	subheader "Disabling BASH History..."
	# Check Distribution
	if [ $DISTRIBUTION = "debian" ]; then
		echo -e "\nunset HISTFILE" >> /etc/profile
	fi
fi

# Disable Additional Getty Instances
if question --default yes "Do you want to disable extra getty instances? (Y/n)" || [ $(read_var_module disable_getty) = 1 ]; then
	subheader "Disabling Additional Getty Instances..."
	# Check Distribution
	if [ $DISTRIBUTION = "debian" ]; then
		sed -e "s/\(^[2-6].*getty.*\)/#\1/" -i /etc/inittab
	fi
fi
