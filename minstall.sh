#!/bin/bash
# Loads libraries and runs specified modules.

# Loop Through Libraries


while [ $# -ge 1 ]; do
	case $1 in
		--help)
			usage
		;;
		--home=?*)
			SUBSONIC_HOME=${1#--home=}
		;;
		--host=?*)
			SUBSONIC_HOST=${1#--host=}
		;;
		--port=?*)
			SUBSONIC_PORT=${1#--port=}
		;;
		--https-port=?*)
			SUBSONIC_HTTPS_PORT=${1#--https-port=}
		;;
		--context-path=?*)
			SUBSONIC_CONTEXT_PATH=${1#--context-path=}
		;;
		--max-memory=?*)
			SUBSONIC_MAX_MEMORY=${1#--max-memory=}
		;;
		--pidfile=?*)
			SUBSONIC_PIDFILE=${1#--pidfile=}
		;;
		--quiet)
			quiet=1
		;;
		--default-music-folder=?*)
			SUBSONIC_DEFAULT_MUSIC_FOLDER=${1#--default-music-folder=}
		;;
		--default-podcast-folder=?*)
			SUBSONIC_DEFAULT_PODCAST_FOLDER=${1#--default-podcast-folder=}
		;;
		--default-playlist-folder=?*)
			SUBSONIC_DEFAULT_PLAYLIST_FOLDER=${1#--default-playlist-folder=}
		;;
		*)
			usage
		;;
	esac
	shift
done