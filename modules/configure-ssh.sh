#!/bin/bash
# Configure: SSH Configuration

# Enable Root SSH Login
if question --default yes "Do you want to enable root SSH login? (Y/n)" || [ $(read_var_module root_login) = 1 ]; then
	subheader "Enabling Root SSH Login..."
	# Enable Root SSH Login For Dropbear
	if check_package "dropbear"; then
		sed -i 's/-w //g' /etc/default/dropbear
		sed -i 's/-w//g' /etc/default/dropbear
		daemon_manage dropbear restart
	fi
	# Enable Root SSH Login For OpenSSH
	if check_package "openssh-server"; then
		sed -i "s/PermitRootLogin no/PermitRootLogin yes/g" /etc/ssh/sshd_config
		daemon_manage ssh restart
	fi
# Disable Root SSH Login
else
	subheader "Disabling Root SSH Login..."
	# Disable Root SSH Login For Dropbear
	if check_package "dropbear"; then
		sed -i 's/DROPBEAR_EXTRA_ARGS="-/DROPBEAR_EXTRA_ARGS="-w -/g' /etc/default/dropbear
		sed -i 's/DROPBEAR_EXTRA_ARGS=""/DROPBEAR_EXTRA_ARGS="-w"/g' /etc/default/dropbear
		sed -i 's/-w -w/-w/g' /etc/default/dropbear
		daemon_manage dropbear restart
	fi
	# Disable Root SSH Login For OpenSSH
	if check_package "openssh-server"; then
		sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
		daemon_manage ssh restart
	fi
fi

# Enable SFTP Umask Privacy
if question --default yes "Do you want to enable private SFTP umask settings (umask 0007 on SFTP file uploads/folder creation)? (Y/n)" || [ $(read_var_module sftp_umask) = 1 ]; then
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
