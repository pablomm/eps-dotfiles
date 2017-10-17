#!/usr/bin/env bash

USER="gituser"
CONFIG="gitconfig"
GITCONFIG=$(echo -n "$HOME"/.gitconfig)
BACK_UP="../backup/gitconfig.backup"
BACK_UP_FOLDER="../backup"


cd "$( dirname "${BASH_SOURCE[0]}" )"

# User information
if [ ! -e $USER ]; then
	echo "Complete your user information to generate the git configuration"
	echo -n "Name: "
	read name

	echo -n "Email: "
	read email

	echo "[user]" > $USER
	echo -e "\tname = "$name >> $USER
	echo -e "\temail = "$email >> $USER
	echo >> $USER

fi

# Backup
if [ -e $GITCONFIG ]; then

	if [ ! -d $BACK_UP_FOLDER ]; then
		mkdir $BACK_UP_FOLDER
	fi

	cp $GITCONFIG $BACK_UP
fi

cat $USER $CONFIG > $GITCONFIG
