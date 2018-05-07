#!/usr/bin/env bash
#
# File: git.bash
# Date: 10/4/2018
#
# This file is part of eps-dotfiles.
#
#     Foobar is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     Foobar is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with eps-dotfiles.  If not, see <http://www.gnu.org/licenses/>.

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

# Vaciamos la carpeta backups para no obtener
# estado inconsistente
rm -rf $BACK_UP_FOLDER/*

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
