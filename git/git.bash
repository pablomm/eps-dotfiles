#!/usr/bin/env bash

USER="gituser"
CONFIG="gitconfig"
GITCONFIG=$(echo -n "$HOME"/.gitconfig)
BACK_UP="./backup/gitconfig.backup"
BACK_UP_FOLDER="./backup"

function restore {

	# Borra el archivo de home
	rm -rf $GITCONFIG

	# Si existe backup lo restaura
	if [ -e "$BACK_UP" ]; then
		cp $BACK_UP $GITCONFIG
	fi

}

cd "$( dirname "${BASH_SOURCE[0]}" )"

if [ "$*" == "-r" ]; then
	restore
	exit 0
fi

# User information
if [ ! -e $USER ]; then
	echo "Completa la informacion de tu usuario para la configuacion global de git"
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
