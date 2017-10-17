#!/usr/bin/env bash

USER="gituser"
CONFIG="gitconfig"
GITCONFIG=$(echo -n "$HOME"/.gitconfig)

cd "$( dirname "${BASH_SOURCE[0]}" )"

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

cat $USER $CONFIG > $GITCONFIG

