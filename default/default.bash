#!/usr/bin/env bash
#
# File: default.bash
# Date: 12/4/2018
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

cd "$( dirname "${BASH_SOURCE[0]}" )"

MIMEAPPS=$(echo -n "$HOME/.local/share/applications/mimeapps.list")
BACK_UP="./backup/mimeapps.list.backup"
BACK_UP_FOLDER="./backup"
CONFIG_ABSOLUTE="$(pwd)/mimeapps.list"
TERMINAL_ABSOLUTE="$(pwd)/gnome-terminal.custom.xml"



function restore {

	# Restaura configuracion de teclado
	if ! [ -z "$(command -v setxkbmap)" ]; then
		if [ -e "$BACK_UP_FOLDER/keyboard.backup" ]; then
			old_keyboard="$(cat $BACK_UP_FOLDER/keyboard.backup)"
			setxkbmap $old_keyboard
		fi
	fi

	# Borramos el nuevo archivo
	rm -f $MIMEAPPS

	if [ -e $BACK_UP ]; then
		cp "$BACK_UP" "$MIMEAPPS"
	fi

	# Si no esta vacia borramos la carpeta creada
	rm -df "$HOME/.local/share/applications" &> /dev/null
	rm -df "$HOME/.local/share" &> /dev/null
	rm -df "$HOME/.local" &> /dev/null

	# Restauramos el aspecto de terminal antiguo
	if ! [ -z "$(command -v gconftool-2)" ]; then
		if [ -e $BACK_UP_FOLDER/gnome-terminal.custom.xml.backup ]; then
			gconftool-2 --load="$BACK_UP_FOLDER/gnome-terminal.custom.xml.backup"
		fi
	fi

}

# Caso restaurar configuracion anterior
if [[ "$*" == "-r" ]] ; then
	restore
	exit 0
fi

if [ ! -e $BACK_UP_FOLDER ]; then
	mkdir $BACK_UP_FOLDER
fi

if ! [ -z "$(command -v setxkbmap)" ]; then
	# Guarda la configuracion anterior
	touch $BACK_UP_FOLDER/keyboard.backup
	setxkbmap -query | grep layout: | cut -d ":" -f 2 > $BACK_UP_FOLDER/keyboard.backup
	# Configura distribucion de teclado
	setxkbmap $keyboard_language
fi

#### Configuracion de programas por defecto
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

cp $CONFIG_ABSOLUTE $MIMEAPPS

echo >> $HOME/.bashrc
echo "function eps-save-defaults {" >> $HOME/.bashrc
echo " cp $MIMEAPPS $CONFIG_ABSOLUTE" >> $HOME/.bashrc
echo "}" >> $HOME/.bashrc
echo >> $HOME/.bashrc

##### Configuracion de estilo terminal

if ! [ -z "$(command -v gconftool-2)" ]; then

	# Guardamos en el backup la configuracion actual para la restauracion
	gconftool-2 --dump '/' > "$BACK_UP_FOLDER/gnome-terminal.custom.xml.backup"

	if [ -f "./gnome-terminal.custom.xml" ]; then
		gconftool-2 --load="./gnome-terminal.custom.xml"
	fi

fi

# Funcion para guardar la configuracion de la terminal
echo "eps-save-term() {"  >> $HOME/.bashrc
echo "  gconftool-2 --dump '/' > '$TERMINAL_ABSOLUTE'"  >> $HOME/.bashrc
echo "}"  >> $HOME/.bashrc
