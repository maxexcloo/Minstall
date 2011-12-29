#!/bin/bash
# Configure: SSH Configuration

# Disable Root SSH Login
if question --default yes "Do you want to disable root SSH logins? (Y/n)"; then
	subheader "Disabling Root SSH Login..."
	# Disable Root SSH Login For OpenSSH
	if [[ -f /etc/ssh/sshd_config ]]; then
		sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
		/etc/init.d/ssh restart
	fi
	# Disable Root SSH Login For Dropbear
	if [[ -f /etc/default/dropbear ]]; then
		sed -i 's/DROPBEAR_EXTRA_ARGS="/DROPBEAR_EXTRA_ARGS="-w/g' /etc/default/dropbear
		/etc/init.d/dropbear restart
	fi
# Enable Root SSH Login
else
	subheader "Enabling Root SSH Login..."
	# Enable Root SSH Login For OpenSSH
	if [[ -f /etc/ssh/sshd_config ]]; then
		sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
		/etc/init.d/ssh restart
	fi
	# Enable Root SSH Login For Dropbear
	if [[ -f /etc/default/dropbear ]]; then
		sed -i 's/-w//g' /etc/default/dropbear
		/etc/init.d/dropbear restart
	fi
fi

# Enable Additional SSH Ports
if question --default no "Do you want to enable additional SSH ports? (y/N)"; then
	subheader "Enabling Additional SSH Ports..."
	# Take User Input
	read -p "Please enter an additional SSH Port: " -e SSHPORT
	# Add Extra SSH Port To OpenSSH
	if [[ -f /etc/ssh/sshd_config ]]; then
		echo "Incomplete Function."
		#sed -i 's/#Port/Port '$SSHPORT'/g' /etc/ssh/sshd_config
		/etc/init.d/ssh restart
	fi
	# Add Extra SSH Port To Dropbear
	if [[ -f /etc/default/dropbear ]]; then
		echo "Incomplete Function."
		#sed -i 's/DROPBEAR_EXTRA_ARGS="-w/DROPBEAR_EXTRA_ARGS="-w -p '$SSHPORT'/g' /etc/default/dropbear
		/etc/init.d/dropbear restart
	fi
fi
