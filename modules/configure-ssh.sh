#!/bin/bash
# Configure: SSH Configuration

# Disable Root SSH Login
if question --default yes "Do you want to disable root SSH logins? (Y/n)" || [ $(read_var_module root_login) = 0 ]; then
	subheader "Disabling Root SSH Login..."
	# Disable Root SSH Login For Dropbear
	if check_package "dropbear"; then
		sed -i "s/DROPBEAR_EXTRA_ARGS="/DROPBEAR_EXTRA_ARGS="-w/g" /etc/default/dropbear
		daemon_manage dropbear restart
	fi
	# Disable Root SSH Login For OpenSSH
	if check_package "openssh-server"; then
		sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
		daemon_manage ssh restart
	fi
# Enable Root SSH Login
else
	subheader "Enabling Root SSH Login..."
	# Enable Root SSH Login For Dropbear
	if check_package "dropbear"; then
		sed -i "s/-w//g" /etc/default/dropbear
		daemon_manage dropbear restart
	fi
	# Enable Root SSH Login For OpenSSH
	if check_package "openssh-server"; then
		sed -i "s/PermitRootLogin no/PermitRootLogin yes/g" /etc/ssh/sshd_config
		daemon_manage ssh restart
	fi
fi

# Enable SFTP Umask Privacy
if question --default yes "Do you want to enable more private SFTP Umask Settings? (Y/n)" || [ $(read_var_module private_umask) = 1 ]; then
	subheader "Enabling SFTP Umask Privacy..."
	if check_package "openssh-server"; then
		sed -i "s/sftp-serve.*/sftp-server -u 0007/g" /etc/ssh/sshd_config
		daemon_manage ssh restart
	fi
# Disable SFTP Umask Privacy
else
	subheader "Disabling SFTP Umask Privacy..."
	if check_package "openssh-server"; then
		sed -i "s/sftp-serve.*/sftp-server/g" /etc/ssh/sshd_config
		daemon_manage ssh restart
	fi
fi
