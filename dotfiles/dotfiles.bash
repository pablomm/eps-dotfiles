#!/usr/bin/env bash
#
# File: dotfiles.bash
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

BACK_UP_FOLDER="./backup"
EXCLUDE="dofiles.bash README.md backup"

cd "$( dirname "${BASH_SOURCE[0]}" )"

# Funcion para restaurar archivos
function restore {

	# Borramos archivos añadidos
	for file in $(ls); do
		if ! echo $EXCLUDE | grep -w $file > /dev/null; then
			rm -f "$HOME/.$file"
		fi
	done

	# Restauramos version antigua
	for backup in $(ls -d $BACK_UP_FOLDER/*.backup 2>/dev/null); do
		filename="$(basename $backup)"
		filename="${filename%.*} "
		cp -r "$backup" "$HOME/.$filename"
	done


}

# Creamos carpeta backups si no existe
if ! [ -e $BACK_UP_FOLDER ]; then
	mkdir $BACK_UP_FOLDER
fi

# Caso restaurar configuracion anterior
if [[ "$*" == "-r" ]] ; then
	restore
	exit 0
fi

for file in $(ls); do

	# Iteramos
	if ! echo $EXCLUDE | grep -w $file > /dev/null; then

		# Si existe el fichero guardamos la copia en backups
		if [ -e "$HOME/.$file" ]; then
			cp -r "$HOME/.$file" "$BACK_UP_FOLDER/$file.backup"
		fi

		# Copiamos el archivo a la carpeta personal
		cp -r "$file" "$HOME/.$file"

	fi

done
