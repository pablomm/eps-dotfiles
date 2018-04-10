#!/usr/bin/env bash


BACK_UP_FOLDER="../backup"
EXCLUDE="dofiles.bash README.md"

cd "$( dirname "${BASH_SOURCE[0]}" )"

function restore {

	# Borramos archivos añadidos
	for file in $(ls); do
		if ! echo $EXCLUDE | grep -w $file > /dev/null; then
			rm -f "$HOME/.$file"
		fi
	done

	# Restauramos version antigua
	for backup in $(ls -d $BACK_UP_FOLDER/*.backup); do

		filename="$(basename $backup)"
		filename="${filename%.*} "

		cp "$backup" "$HOME/.$filename"
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
			cp "$HOME/.$file" "$BACK_UP_FOLDER/$file.backup"
		fi

		# Copiamos el archivo a la carpeta personal
		cp "$file" "$HOME/.$file"


	fi

done