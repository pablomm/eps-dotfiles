#!/usr/bin/env bash


cd "$( dirname "${BASH_SOURCE[0]}" )"

MIMEAPPS=$(echo -n "$HOME/.local/share/applications/mimeapps.list")
BACK_UP="./backup/mimeapps.list.backup"
BACK_UP_FOLDER="./backup"
CONFIG_ABSOLUTE="$(pwd)/mimeapps.list"
TERMINAL_ABSOLUTE="$(pwd)/gnome-terminal.custom.xml"


if [ -e $BACK_UP_FOLDER ]; then 

	mkdir $BACK_UP_FOLDER
fi

# Configura distribucion de teclado
setxkbmap -query | grep layout: | cut -d ":" -f 2 > $BACK_UP_FOLDER/keyboard.backup


setxkbmap $keyboard_language

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

if [ -f "./gnome-terminal.custom.xml" ]; then
	gconftool-2 --load="./gnome-terminal.custom.xml"
fi


# Funcion para guardar la configuracion de la terminal
echo "eps-save-term() {"  >> $HOME/.bashrc
echo "  gconftool-2 --dump '/' > '$TERMINAL_ABSOLUTE'"  >> $HOME/.bashrc
echo "}"  >> $HOME/.bashrc
