#!/bin/bash
# String Replacement

# Escape Input
escape() {
	# Replace Slash With Escaped Slash
	echo "$1" | sed -e 's/\//\\\//g'
}

# Replace String
string_replace() {
	# Search & Replace String
	echo "$1" | sed "s/$(escape $2)/$(escape $3)/"
}

# Replace String (No Escape)
string_replace_ne() {
	# Search & Replace String
	echo "$1" | sed "s/$2/$3/"
}

# Replace String In File
string_replace_file() {
	# Search & Replace File
	sed -i "s/$(escape $2)/$(escape $3)/g" $1
}

# Replace String In File (No Escape)
string_replace_file_ne() {
	# Search & Replace File
	sed -i "s/$2/$3/g" $1
}

# Replace String In Output
string_replace_output() {
	# Search & Replace Output
	sed "s/$(escape $3)/$(escape $4)/g" $1 > $2
}

# Replace String In Output (No Escape)
string_replace_output_ne() {
	# Search & Replace Output
	sed "s/$3/$4/g" $1 > $2
}
