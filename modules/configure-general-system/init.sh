#!/bin/bash
# Configure (General): System Configuration

# Enable BASH History
if question --default no "Do you want to enable BASH history? (y/N)" || [ $(read_var_module bash_history) = 1 ]; then
	subheader "Enabling BASH History..."
	rm /etc/profile.d/disable_history.sh &> /dev/null
# Disable BASH History
else
	subheader "Disabling BASH History..."
	echo "unset HISTFILE" > /etc/profile.d/disable_history.sh
fi

# Enable Additional Getty Instances
if question --default no "Do you want to enable extra getty instances (uneeded on virtual machines, can save memory if disabled)? (y/N)" || [ $(read_var_module getty_extra) = 1 ]; then
	subheader "Enabling Additional Getty Instances..."
	if [ $DISTRIBUTION = "debian" ]; then
		sed -e 's/^#\([2-6].*getty.*\)/\1/' -i /etc/inittab
	elif [ $DISTRIBUTION = "ubuntu" ]; then
		rename.ul .conf.disabled .conf /etc/init/tty{3..6}.conf.disabled &> /dev/null
	fi
# Disable Additional Getty Instances
else
	subheader "Disabling Additional Getty Instances..."
	if [ $DISTRIBUTION = "debian" ]; then
		sed -e "s/\(^[2-6].*getty.*\)/#\1/" -i /etc/inittab
	elif [ $DISTRIBUTION = "ubuntu" ]; then
		rename.ul .conf .conf.disabled /etc/init/tty{3..6}.conf &> /dev/null
	fi
fi

# Change Default System Shell
if question --default yes "Do you want to change the default system shell? (Y/n)" || [ $(read_var_module shell) != 0 ]; then
	subheader "Changing Default System Shell..."
	# Attended Mode
	if [ $UNATTENDED = 0 ]; then
		dpkg-reconfigure dash
	# Unattended Mode
	else
		# Set BASH As Default
		if [ $(read_var_module shell) = "bash" ]; then
			ln -fs bash /bin/sh
			ln -fs dash /bin/sh.distrib
			ln -fs bash.1.gz /usr/share/man/man1/sh.1.gz
			ln -fs dash.1.gz /usr/share/man/man1/sh.distrib.1.gz
		# Set DASH As Default
		elif [ $(read_var_module shell) = "dash" ]; then
			ln -fs dash /bin/sh
			ln -fs bash /bin/sh.distrib
			ln -fs dash.1.gz /usr/share/man/man1/sh.1.gz
			ln -fs bash.1.gz /usr/share/man/man1/sh.distrib.1.gz
		# Unsupported Condition
		else
			warning "Unsupported value for default shell, currently bash and dash are supported."
		fi
	fi
fi

# Change System Timezone
if question --default yes "Do you want to change the system timezone? (Y/n)" || [ $(read_var_module timezone) != 0 ]; then
	subheader "Changing System Timezone..."
	# Attended Mode
	if [ $UNATTENDED = 0 ]; then
		# Set Timezone Manually
		dpkg-reconfigure tzdata
	# Unattended Mode
	else
		# Check Timezone Existance
		if [ -f /usr/share/zoneinfo/$(read_var_module timezone) ]; then
			# Set Timezone From File
			cp /usr/share/zoneinfo/$(read_var_module timezone) /etc/localtime
			echo $(read_var_module timezone) > /etc/timezone
			dpkg-reconfigure -f noninteractive tzdata
		# Unsupported Timezone
		else
			# Show Warning
			warning "Timezone does not exist, please ensure you entered a valid timezone!"
		fi
	fi
fi
