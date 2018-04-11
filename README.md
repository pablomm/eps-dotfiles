# eps-dotfiles

Ficheros de configuración para los laboratorios de la EPS
basado en el repositorio [eps-dotfiles](https://github.com/ManuelBlanc/eps-dotfiles) 
de [ManuelBlanc](https://github.com/ManuelBlanc)

## Funcionamiento

El repositorio está pensado para guardarlo en la **UnidadH** y ejecutar el script 
[setup](https://github.com/pablomm/eps-scripts/blob/master/setup) al iniciar un
ordenador de la **EPS** para restaurar la configuración personalizada.

El script **setup** debe ejecutarse la primera vez desde una terminal pues se solicitará
información para la configuración de github, el resto de veces puede ejecutarse simplemente 
clicando sobre él.

Puedes colocar tus propios ficheros de configuración en la carpeta dotfiles en lugar de los actuales


## Cómo instalarlo

### Método 1

Descarga y ejecuta el fichero [boostrap.sh](https://github.com/pablomm/eps-scripts/blob/master/bootstrap) 
el cual descargará el repositorio en la **UnidadH** y en caso de no estar montada en la carpeta personal.

```bash

source <(curl -fsSL https://raw.githubusercontent.com/pablomm/eps-dotfiles/master/bootstrap)

```

### Método 2

Clona el repositorio directamente en la **UnidadH** o en otra ubicación.

```bash
cd ~/UnidadH/
git clone https://github.com/pablomm/eps-dotfiles.git
cd eps-dotfiles/
bash setup
```

## Características

#### Terminal personalizada

Se carga la configuración de la terminal guardada en el archivo **gnome-terminal.custom.xml**.
Para guardar permanente una nueva personalización basta con cambiar la terminal desde su propio menu
de preferencias y ejecutar en ella el comando `eps-save-term` que actualizará el archivo.

#### Programas por defecto

Se carga la configuración de los archivos por defectos asociados a una extensión.
Para actualizar el programa asociado a una extensión basta con fijar un nuevo programa
predeterminado al abrir el archivo en `click derecho -> abrir con` y
posteriormente ejecutar el comando `eps-save-defaults` para guardar los cambios.

#### Configuración personalizada

En el archivo **configuration** se encuentran ajustes globales que pueden ser modificados, como por ejemplo
la distribución del teclado.

#### Configuración de GIT

Se carga el fichero de configuración situado en la carpeta [git](https://github.com/pablomm/eps-dotfiles/tree/master/git) 
junto con el usuario y correo guardados la primera vez que se ejecuta el script.

#### Ficheros de configuración personalizados

Todos los ficheros y carpetas existentes en la carpeta [dotfiles](https://github.com/pablomm/eps-dotfiles/tree/master/dotfiles) son movidos al directorio personal añadiendo un `.` al principio del nombre.
Si existían previamente ficheros de configuración se guardarán en la carpeta `backup` y podrá ser restaurada la
cofiguración anterior con el argumento `-r`.

Ficheros actuales:
* El actual `bashrc` carga los colores de **Linux Mint 17** junto con varias funciones útiles como `extract` o `swap`.
* El fichero `bash_aliases` contiene alias útiles como `ll`,`la`,`..` , ...
* Fichero `vimrc` con la configuración de vim sacado del repositorio [eps-dotfiles](https://github.com/ManuelBlanc/eps-dotfiles) de [ManuelBlanc](https://github.com/ManuelBlanc)
* Fichero `bash_profile` que invoca a `bashrc`.

## Estructura

Los scripts están organizados en carpetas. El fichero setup en caso de encontrar un script con extensión *.bash* 
en una carpeta de `eps-dotfiles`lo ejecuta.
Desde estos scripts invocados se puede acceder a las variables definidas en el archivo **configuration**, en este archivo 
se guardan variables para configurar los ficheros de forma sencilla.
Siempre se ejecuta en primer lugar el módulo `dotfiles`, el resto alfabeticamente.
Si se ejecutan con el argumento `-r` restaurarán la configuración anterior.

## Personalización

Por desgracia se borra muy a menudo la UnidadH, por lo que te recomiendo, si vas a personalizar
alguno de los ficheros, realizar un fork del repositorio o crear tu propio repositorio espejo para
no perder los cambios cuando esto suceda.

## Borrado (En proceso 70%)

Si se ejecuta el comando `eps-restore` se restaurará la configuración original del ordenador y con el comando `eps-clean`
además de restaurar la configuración se eliminará completamente el repositorio sin dejar rastro de su paso :trollface:.

## Cómo colaborar

Si quieres colaborar en mejorar los scripts cualquier idea es bienvenida, desde abrir una 
[issue](https://github.com/pablomm/eps-dotfiles/issues/new) hasta escribir nuevos ficheros de configuración y
módulos, para ello realiza un fork del repositorio y crea una pull request.

## Autor

Realizado por [pablomm](https://github.com/pablomm) y basado en el repositorio [eps-dotfiles](https://github.com/ManuelBlanc/eps-dotfiles) 
de [ManuelBlanc](https://github.com/ManuelBlanc).

## Licencia

GPLv3 (véase el fichero [LICENSE](https://github.com/pablomm/eps-dotfiles/blob/master/LICENSE))
