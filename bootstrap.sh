#!/usr/bin/env bash


#
# Autor original: Manuel Blanc
# Repositorio original: https://github.com/ManuelBlanc/eps-dotfiles.git 
#

{ # Proteccion ejecuccion parcial

# Colorines
C_NORMAL=$(tput sgr0)
C_BOLD=$(tput bold)
C_RED=$(tput setaf 1)
C_GREEN=$(tput setaf 2)
C_YELLOW=$(tput setaf 3)
C_BLUE=$(tput setaf 4)
C_MAGENTA=$(tput setaf 5)
C_CYAN=$(tput setaf 6)
C_WHITE=$(tput setaf 7)

# Utilidades
info()  { echo "$C_GREEN==> $C_NORMAL$@$C_NORMAL";              	}
infoB() { echo "$C_GREEN==> $C_NORMAL$C_BOLDC_$@$NORMAL";       	}
error() { echo "$C_RED==> $C_NORMAL${C_BOLD}error: $C_NORMAL$@";	}
abort() { error "$@"; exit 1;                                   	}
prompt() {
	read -p "${C_YELLOW}$1 ${C_BOLD}[S/n]${C_NORMAL} " # -n 1 -r
	[[ -z $REPLY || $REPLY =~ ^[YySs]$ ]]
	return $?
}

# ----------------------------------------------------------------------------

infoB "======================================================================"
infoB " eps-dotfiles -- instalacion/reconfiguracion"
infoB "======================================================================"

PREFIX="$HOME/UnidadH"
GITREPO="https://github.com/pablomm/eps-scripts.git"

# Preparacion
test -d "$PREFIX" || abort "La ~/UnidadH/ no esta disponible"

if [ -d "$PREFIX/eps-scripts" ]; then
	info "Encontrada instalacion existente en $PREFIX/eps-scripts, actualizando ..."
	(cd "$PREFIX/eps-scripts" && git pull --ff-only -v origin master && git submodule update)
else
	prompt "Desea instalar en $PREFIX/eps-scripts ($GITREPO)?" || abort "instalacion abortada"

	infoB "Clonando el repositorio"
	git clone --recursive -v "$GITREPO" "$PREFIX/eps-scripts"

fi

bash "$PREFIX/eps-scripts/setup"


}