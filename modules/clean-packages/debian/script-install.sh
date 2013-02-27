#!/bin/bash
# Pre Clean Commands (Debian)

# Check Package
if check_package "sendmail"; then
	# Stop Sendmail
	daemon_manage sendmail stop
fi
