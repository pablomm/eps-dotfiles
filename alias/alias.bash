#!/usr/bin/env bash

CONFIG="bash_aliases"
ALIASES=$(echo -n "$HOME"/.bash_aliases)
BACK_UP="../backup/bash_aliases.backup"
BACK_UP_FOLDER="../backup"


cd "$( dirname "${BASH_SOURCE[0]}" )"

# Backup
if [ -e $ALIASES ]; then

	if [ ! -d $BACK_UP_FOLDER ]; then
		mkdir $BACK_UP_FOLDER
	fi

	cp $ALIASES $BACK_UP
fi

cat $CONFIG > $ALIASES
