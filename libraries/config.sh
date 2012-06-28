#!/bin/bash
# Functions For Config Parsing

# INI Variable Tester
read_var() {
	# Check If Variable Exists
	if [[ $(eval "echo \$\{INI__$1\}") == ""]]; then
		# Echo False
		echo 0
	else
		# Echo Variable
		echo $(eval "echo \$\{INI__$1\}")
	fi
}

# INI Variable Tester
read_var_module() {
	# Check If Variable Exists
	if [[ $(eval "echo \$\{INI__$MODULE\__$1\}") == ""]]; then
		# Echo False
		echo 0
	else
		# Echo Variable
		echo $(eval "echo \$\{INI__$MODULE\__$1\}")
	fi
}
