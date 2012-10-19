#!/bin/bash
# Pre Clean Commands (Debian)

# Check Package
if check_package "sendmail"; then
	# Hack: Stop Sendmail
	daemon_manage sendmail stop
fi
