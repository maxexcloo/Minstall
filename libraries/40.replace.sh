#!/bin/bash
# String Replacement

# Escape Input For Sed
escape() {
	# Replace Slash With Escaped Slash
	echo "$1" | sed -e 's/\//\\\//g'
}

# Replace String In File
file_replace() {
	# Search & Replace File
	sed -i "s/$(escape $2)/$(escape $3)/g" $1
}

# Replace String
string_replace() {
	# Search & Replace String
	echo $1 | sed "s/$(escape $2)/$(escape $3)/"
}
