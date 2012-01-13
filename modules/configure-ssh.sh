#!/bin/bash
# Configure: SSH Configuration

# Disable Root SSH Login
if question --default yes "Do you want to disable root SSH logins? (Y/n)"; then
	subheader "Disabling Root SSH Login..."
	# Disable Root SSH Login For Dropbear
	if check_package "dropbear"; then
		sed -i 's/DROPBEAR_EXTRA_ARGS="/DROPBEAR_EXTRA_ARGS="-w/g' /etc/default/dropbear
		daemon_manage dropbear restart
	fi
	# Disable Root SSH Login For OpenSSH
	if check_package "openssh-server"; then
		sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
		daemon_manage ssh restart
	fi
# Enable Root SSH Login
else
	subheader "Enabling Root SSH Login..."
	# Enable Root SSH Login For Dropbear
	if check_package "dropbear"; then
		sed -i 's/-w//g' /etc/default/dropbear
		daemon_manage dropbear restart
	fi
	# Enable Root SSH Login For OpenSSH
	if check_package "openssh-server"; then
		sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
		daemon_manage ssh restart
	fi
fi

# Enable Additional SSH Ports
if question --default no "Do you want to enable additional SSH ports? (y/N)"; then
	subheader "Enabling Additional SSH Ports..."
	# Take User Input
	SSHPORT=$(question_number)
	# Add Additional SSH Port To Dropbear
	if check_package "dropbear"; then
		echo "Incomplete Function."
		#sed -i 's/DROPBEAR_EXTRA_ARGS="-w/DROPBEAR_EXTRA_ARGS="-w -p '$SSHPORT'/g' /etc/default/dropbear
		#daemon_manage dropbear restart
	fi
	# Add Additional SSH Port To OpenSSH
	if check_package "openssh-server"; then
		echo "Incomplete Function."
		#sed -i 's/#Port/Port '$SSHPORT'/g' /etc/ssh/sshd_config
		#daemon_manage ssh restart
	fi
fi

# Enable SFTP Umask Privacy
if question --default no "Do you want to enable more private SFTP Umask Settings? (y/N)"; then
	subheader "Enabling SFTP Umask Privacy..."
	if check_package "openssh-server"; then
		sed -i 's/sftp-server/sftp-server -u o=/g' /etc/ssh/sshd_config
		daemon_manage ssh restart
	fi
# Disable SFTP Umask Privacy
else
	subheader "Disabling SFTP Umask Privacy..."
	if check_package "openssh-server"; then
		sed -i 's/sftp-server -u o=/sftp-server/g' /etc/ssh/sshd_config
		daemon_manage ssh restart
	fi
fi
