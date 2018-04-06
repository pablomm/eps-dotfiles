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

Tras ejecutar el script será necesario cerrar las terminales para que se apliquen completamente
los cambios.

## Cómo instalarlo

### Método 1

Descarga y ejecuta el fichero [boostrap.sh](https://github.com/pablomm/eps-scripts/blob/master/bootstrap.sh) 
el cual descargará el repositorio en la **UnidadH** 

```bash

source <(curl -fsSL https://raw.githubusercontent.com/pablomm/eps-scripts/master/bootstrap.sh)

```

### Método 2

Clona el repositorio directamente en la **UnidadH**

```bash
cd ~/UnidadH/
git clone https://github.com/pablomm/eps-dotfiles.git
cd eps-dotfiles/
bash setup
```

## Características

#### Terminal personalizada

Se carga la configuración de la terminal guardada en el archivo **gnome-terminal.custom.xml**.
Para guardar permanente una nueva personalización basta con cambiar la terminal y ejecutar
en ella el comando `eps-save-term` que actualizará el archivo.

#### Programas por defecto

Se carga la configuración de los archivos por defectos asociados a una extensión.
Para actualizar el programa asociado a una extensión desde `click derecho -> abrir con` y
posteriormente ejecutar el comando `eps-save-apps`.

#### Configuración personalizada

En el archivo [configuration]() se encuentran ajustes globales que pueden ser modificados, como por ejemplo
la distribución del teclado.

#### Configuración de GIT

Se carga el fichero de configuración situado en la carpeta [git](https://github.com/pablomm/eps-scripts/tree/master/git) 
junto con el usuario y correo guardados la primera vez que se ejecuta el script.

#### Bashrc personalizado

Se carga como bashrc del sistema el situado en la carpeta [bashrc](https://github.com/pablomm/eps-scripts/tree/master/bashrc).
El actual bashrc carga los colores de **Linux Mint 17** junto con varias funciones útiles como `extract` o `swap`.

#### Alias personalizados

Se carga el fichero de alias personalizados situado en [alias](https://github.com/pablomm/eps-scripts/tree/master/aliases).

#### Makefiles

En [makefiles](https://github.com/pablomm/eps-scripts/tree/master/makefiles) se incluyen varios **Makefiles** genéricos
para proyectos en **c/c++** . (Aún en construcción)

## Estructura

Los scripts están organizados en carpetas. El fichero setup en caso de encontrar un script con extensión *.bash*.
Desde estos scripts invocados se puede acceder a las variables definidas en el archivo [configuration](), en este archivo 
se guardan variables para configurar los ficheros de forma sencilla.

## Personalización

Por desgracia se borra muy a menudo la UnidadH, por lo que te recomiendo, si vas a personalizar
alguno de los ficheros, que realices un fork del repositorio o crees tu propio repositorio espejo para
no perder los cambios cuando esto suceda.

## Cómo colaborar

Si quieres colaborar en mejorar los scripts cualquier idea es bienvenida, desde abrir una 
[issue](https://github.com/pablomm/eps-scripts/issues/new) hasta escribir nuevos ficheros de configuración y
módulos, para ello realiza un fork del repositorio y crea una pull request.

## Autor

Este y más cosillas interesantes en mi github [pablomm](https://github.com/pablomm).

Basado en el repositorio [eps-dotfiles](https://github.com/ManuelBlanc/eps-dotfiles) 
de [ManuelBlanc](https://github.com/ManuelBlanc).

## Licencia

GPLv3 (véase el fichero [LICENSE]())
