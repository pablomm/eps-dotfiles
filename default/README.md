
# default


* Si existe el archivo wallpaper.jpg lo carga como fondo de pantalla
* Configura la estética de la terminal, utiliza la función `eps-save-term` para guardar la configuración actual.
* Configura los programas usados predeterminados. Utiliza la función `eps-save-defaults` para guardar cambios.
* Cambia la configuración del teclado a la definida en el fichero `configuration`.
* Al ejecutarse escribe las funciones `eps-save-term` y `configuration` en el archivo `~/.bashrc`

### Restauración
Si se ejecuta
```bash
./default.bash -r
```

Se recargará la anterior configuración existente, cargando el anterior fondo de pantalla, distribución de teclado,
aspecto de la terminal y configuración de archivos predeterminado.
