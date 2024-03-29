#!/usr/bin/env bash

SOURCE_PATH=$(chezmoi source-path)
readonly SOURCE_PATH

mkdir -p ~/bin
mkdir -p $SOURCE_PATH/scripts

manage () {
	manage_name="$1"
	source_url="$2"
	curl -s --output "$SOURCE_PATH/scripts/$manage_name" "$source_url"
	# will just automatically copy file and clobber what's there
	src="$SOURCE_PATH/scripts/$manage_name"
	dest="$HOME/bin/$manage_name"
	if cmp --silent "$src" "$dest"; then
		return
	fi
	echo "$manage_name: updating"
	cp -v "$src" "$dest"

}

manage git-sync.sh https://gist.githubusercontent.com/green-leader/862d0ccfc5cf82fc650da54fe14d5ff5/raw/sync.sh
manage tailproxy.sh https://gist.githubusercontent.com/green-leader/76cc65df718342967f3d06592525508a/raw/tailproxy.sh

# scripts to run if they exist
run_if_exist () {
       test -e $1 && bash $1
}

run_if_exist ~/bin/wsl_setup.sh
