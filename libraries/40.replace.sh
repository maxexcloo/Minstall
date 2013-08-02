#!/bin/bash
# String Replacement

# Escape Input For Sed
escape() {
	# Replace Slash With Escaped Slash
	echo "$1" | sed -e 's/\//\\\//g'
}

# Replace String In File
string_replace_file() {
	# Search & Replace File
	sed -i "s/$(escape $2)/$(escape $3)/g" $1
}

# Replace String In Output
string_replace_output() {
	# Search & Replace File
	sed "s/$(escape $3)/$(escape $4)/g" $1 > $2
}

# Replace String
string_replace() {
	# Search & Replace String
	echo $1 | sed "s/$(escape $2)/$(escape $3)/"
}
