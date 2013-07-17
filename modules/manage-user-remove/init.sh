#!/bin/bash
# Manage: User Remove

# Manage User
manage-user

# Module Function
module() {
	# Check User
	manage-user-check-user $USER

	# Remove User
	manage-user-manage-remove $USER
}

# Attended Mode
if [ $UNATTENDED = 0 ]; then
	# User Check
	manage-user-input-check

	# Module Function
	module
# Unattended Mode
else
	# Define Arrays
	USERLIST=$(read_variable_module user),

	# Loop Through Users
	while echo $USERLIST | grep -q \,; do
		# Define Variables
		USER=${USERLIST%%\,*}

		# Remove Current From List
		USERLIST=${USERLIST#*\,}

		# Check User Array State
		manage-user-check-array $USERLIST

		# Module Function
		module
	done

	# Unset Arrays
	unset USERLIST

	# Unset Variables
	unset USER
fi

# Unset Init
unset -f init
