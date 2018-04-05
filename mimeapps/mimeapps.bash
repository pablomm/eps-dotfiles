#!/usr/bin/env bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

CONFIG=$mimeappsFile
MIMEAPPS=$(echo -n "$HOME/.local/share/applications/mimeapps.list")
BACK_UP="../backup/mimeapps.list.backup"
BACK_UP_FOLDER="../backup"



# Backup
if [ -e $MIMEAPPS ]; then

	if [ ! -d $BACK_UP_FOLDER ]; then
		mkdir $BACK_UP_FOLDER
	fi

	cp $MIMEAPPS $BACK_UP
fi

if [ ! -d "$HOME/.local" ]; then
	mkdir "$HOME/.local"
fi

if [ ! -d "$HOME/.local/share" ]; then
	mkdir "$HOME/.local/share"
fi

if [ ! -d "$HOME/.local/share/applications" ]; then
	mkdir "$HOME/.local/share/applications"
fi

cat $CONFIG > $MIMEAPPS
