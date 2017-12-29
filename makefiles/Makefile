.DEFAULT_GOAL = all
.PHONY: all test debug clean help style folder zip

##########################################################
#                                                        #
#  Makefile generico - pablo.marcosm@estudiante.uam.es   #
#  23-oct-2017                                           #
#                                                        #
# Carpetas del proyecto (definidas en las variables):    #
#                                                        #
#  BDIR - Carpeta donde se crearan los ejecutables       #
#         tanto del objetivo all como de test            #
#                                                        #
#  SDIR - Carpeta con los ficheros fuente con el         #
#         codigo de los modulos                          #
#                                                        #
#  IDIR - Carpeta con todas las cabeceras de los         #
#         modulos                                        #
#                                                        #
#  ODIR - Carpeta con todos los objetos .o compilados    #
#         y las dependencias, al hacer make clean si     #
#         no hay ficheros se borra el directorio tambien #
#                                                        #
#  EDIR - Carpeta con los mains que se van a generar     #
#         al hacer make all, por comodidad se            #
#         permite que esta carpeta sea la misma que      #
#         la de los ficheros fuente (SDIR)               #
#                                                        #
#  TDIR - Carpeta con los mains secundarios de pruebas   #
#                                                        #
#  MDIR - Carpeta con el resto de ficheros del proyecto  #
#                                                        #
##########################################################

## Directorios del proyecto
BDIR := .
SDIR := src
IDIR := include
TDIR := test
ODIR := obj
EDIR := src
MDIR := misc

## Fichero con configuracion de astyle
## Respeta la variable de entorno en caso de estar definida 
ARTISTIC_STYLE_OPTIONS ?= $(MDIR)/.astylerc

## Configuracion de las herramientas
CC       ?= gcc
CFLAGS   := -Iinclude -ansi -pedantic -Wall -Wextra -std=c99
LDFLAGS  := 
RM       := rm -fvd

## Nombre del zip generado
ZIP_NAME := ../nombre_proyecto.zip

## Herramienta para comprimir
ZIP ?= zip
ZFLAGS := -r

## Deteccion automatica de los .c con los main
## No es valida esta forma si estan en el mismo
## directorio que el resto de archivos fuente
# EXES := $(wildcard $(EDIR)/*.c)

## Especificamos manualmente cuales son los archivos objetivo
## de make all (en la carpeta EDIR que puede coincidir con SDIR)
EXES := 

## Ficheros fuente objetivos del make all
EXES := $(patsubst %,$(EDIR)/%,$(EXES))
EOBJ := $(patsubst $(EDIR)/%.c,$(ODIR)/%.o,$(EXES))
EBIN := $(patsubst $(EDIR)/%.c,$(BDIR)/%,$(EXES))

## Fuentes del directorio SDIR
SRCS := $(filter-out $(EXES), $(wildcard $(SDIR)/*.c))
SOBJ := $(patsubst $(SDIR)/%.c,$(ODIR)/%.o,$(SRCS))

## Fuentes del directorio TDIR y sus ejecutables
TEST := $(wildcard $(TDIR)/*.c)
TOBJ := $(patsubst $(TDIR)/%.c,$(ODIR)/%.o,$(TEST))
TBIN := $(patsubst $(TDIR)/%.c,$(BDIR)/%,$(TEST))

## Deteccion de dependencias automatica
DEPEND_FILES := $(wildcard $(ODIR)/*.d)
CFLAGS += -MMD
-include $(DEPEND_FILES)

## Flags especificos por objetivo
all: CFLAGS += -O3 -DNDEBUG
test: CFLAGS += -O3 -DNDEBUG
debug: CFLAGS += -g

## Objetivos
all: folder $(EBIN)
test: folder $(TBIN)
debug: folder $(EBIN)

## Compilacion de .c de src
$(SOBJ):$(ODIR)/%.o: $(SDIR)/%.c
	$(CC) $(CFLAGS) -o $@ -c $<

## Compilacion de .c de exes
$(EOBJ):$(ODIR)/%.o: $(EDIR)/%.c
	$(CC) $(CFLAGS) -o $@ -c $< 

## Linkado de exes
$(EBIN):$(BDIR)/%: $(ODIR)/%.o $(SOBJ)
	$(CC) -o $@ $^ $(LDFLAGS)

## Compilacion de tests
$(TOBJ):$(ODIR)/%.o: $(TDIR)/%.c
	$(CC) $(CFLAGS) -o $@ -c $< 

## Linkado de tests
$(TBIN):$(BDIR)/%: $(ODIR)/%.o $(SOBJ)
	$(CC) -o $@ $^ $(LDFLAGS) $(CFLAGS)

## Borra los ficheros generados (ni uno mas) 
## y la carpeta ODIR si esta vacia
clean:
	@$(RM) $(SOBJ) $(EOBJ) $(EBIN) $(TOBJ) $(TBIN) $(DEPEND_FILES)
	@$(RM) $(ODIR) 2> /dev/null

help:
	@echo "Posibles comandos:"
	@echo "    all      - construye el/los ejecutable/s $(EBIN)"
	@echo "    test     - genera los ejecutables para las pruebas situados en $(TDIR)/"
	@echo "    debug    - compila usando con simbolos de depuracion y sin optimizaciones"
	@echo "    clean    - borra todos los ficheros generados"
	@echo "    style    - estiliza el codigo utilizando el programa astyle"
	@echo "    help     - muestra esta ayuda"

folder:
	@mkdir -p $(ODIR)

style:
	@astyle --options=$(ARTISTIC_STYLE_OPTIONS) $(IDIR)/*.h $(SDIR)/*.c $(TDIR)/*.c

zip: clean
	@$(ZIP) $(ZFLAGS) $(ZIP_NAME) *
