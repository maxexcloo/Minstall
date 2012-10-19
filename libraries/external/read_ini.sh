#!/bin/bash
# Functions For INI Parsing

function read_ini() {
	function check_ini_file() {
		if [ ! -r "$INI_FILE" ]; then
			echo "read_ini: '${INI_FILE}' doesn't exist or not readable" >&2
			return 1
		fi
	}

	function check_prefix() {
		if ! [[ "${VARNAME_PREFIX}" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
			echo "read_ini: invalid prefix '${VARNAME_PREFIX}'" >&2
			return 1
		fi
	}

	function cleanup_bash() {
		shopt -q -u ${SWITCH_SHOPT}
		unset -f check_prefix check_ini_file pollute_bash cleanup_bash
	}

	function pollute_bash() {
		if ! shopt -q extglob; then
			SWITCH_SHOPT="${SWITCH_SHOPT} extglob"
		fi
		if ! shopt -q nocasematch; then
			SWITCH_SHOPT="${SWITCH_SHOPT} nocasematch"
		fi
		shopt -q -s ${SWITCH_SHOPT}
	}

	local INI_FILE=""
	local INI_SECTION=""
	local BOOLEANS=1
	local VARNAME_PREFIX=INI
	local CLEAN_ENV=0
	while [ $# -gt 0 ]; do
		case $1 in
			--clean | -c )
				CLEAN_ENV=1
			;;
			--booleans | -b )
				shift
				BOOLEANS=$1
			;;
			--prefix | -p )
				shift
				VARNAME_PREFIX=$1
			;;
			* )
				if [ -z "$INI_FILE" ]
				then
					INI_FILE=$1
				else
					if [ -z "$INI_SECTION" ]
					then
						INI_SECTION=$1
					fi
				fi
			;;
		esac
		shift
	done
	if [ -z "$INI_FILE" ] && [ "${CLEAN_ENV}" = 0 ]; then
		echo -e "Usage: read_ini [-c] [-b 0| -b 1]] [-p PREFIX] FILE"\
			"[SECTION]\n or read_ini -c [-p PREFIX]" >&2
		cleanup_bash
		return 1
	fi
	if ! check_prefix; then
		cleanup_bash
		return 1
	fi
	local INI_ALL_VARNAME="${VARNAME_PREFIX}__ALL_VARS"
	if [ "${CLEAN_ENV}" = 1 ]; then
		eval unset "\$${INI_ALL_VARNAME}"
	fi
	unset ${INI_ALL_VARNAME}
	if [ -z "$INI_FILE" ]; then
		cleanup_bash
		return 0
	fi
	if ! check_ini_file; then
		cleanup_bash
		return 1
	fi
	if [ "$BOOLEANS" != "0" ]; then
		BOOLEANS=1
	fi

	local LINE_NUM=0
	local SECTION=""
	local IFS=$' \t\n'
	local IFS_OLD="${IFS}"
	local SWITCH_SHOPT=""
	pollute_bash
	while read -r line; do
		((LINE_NUM++))
		if [ -z "$line" -o "${line:0:1}" = ";" -o "${line:0:1}" = "#" ]; then
			continue
		fi
		if [[ "${line}" =~ ^\[[a-zA-Z0-9_]{1,}\]$ ]]; then
			SECTION="${line#[}"
			SECTION="${SECTION%]}"
			continue
		fi
		if [ ! -z "$INI_SECTION" ]; then
			if [ "$SECTION" != "$INI_SECTION" ]; then
				continue
			fi
		fi
		if ! [[ "${line}" =~ ^[a-zA-Z0-9._]{1,}[[:space:]]*= ]]; then
			echo "Error: Invalid line:" >&2
			echo " ${LINE_NUM}: $line" >&2
			cleanup_bash
			return 1
		fi
		IFS="="
		read -r VAR VAL <<< "${line}"
		IFS="${IFS_OLD}"
		VAR="${VAR%%+([[:space:]])}"
		VAL="${VAL##+([[:space:]])}"
		VAR=$(echo $VAR)
		if [ -z "$SECTION" ]; then
			VARNAME=${VARNAME_PREFIX}__${VAR//./_}
		else
			VARNAME=${VARNAME_PREFIX}__${SECTION}__${VAR//./_}
		fi
		eval "${INI_ALL_VARNAME}=\"\$${INI_ALL_VARNAME} ${VARNAME}\""
		if [[ "${VAL}" =~ ^\".*\"$ ]]; then
			VAL="${VAL##\"}"
			VAL="${VAL%%\"}"
		elif [[ "${VAL}" =~ ^\'.*\'$ ]]; then
			VAL="${VAL##\'}"
			VAL="${VAL%%\'}"
		elif [ "$BOOLEANS" = 1 ]; then
			case "$VAL" in
				yes | true | on )
					VAL=1
				;;
				no | false | off )
					VAL=0
				;;
			esac
		fi
		VAL="${VAL//\\/\\\\}"
		VAL="\$'${VAL//\'/\'}'"
		eval "$VARNAME=$VAL"
	done < "${INI_FILE}"
	cleanup_bash
}
