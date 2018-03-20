#!/usr/bin/env bash

CONFIG="bashrc"
BASHRC=$(echo -n "$HOME"/.bashrc)
BACK_UP="../backup/bashrc.backup"
BACK_UP_FOLDER="../backup"


cd "$( dirname "${BASH_SOURCE[0]}" )"

# Backup
if [ -e $BASHRC ]; then

	if [ ! -d $BACK_UP_FOLDER ]; then
		mkdir $BACK_UP_FOLDER
	fi

	cp $BASHRC $BACK_UP
fi

cat $CONFIG > $BASHRC
