## Windows Command Line (CMD) ###

# Comandos de Movimiento
 *cd* es para ver donde estamos, en Linux seria el equivalente a *pwd*, tambien funciona como el *cd* normal de Linux si despues a;adimos un destino.
 *dir* muestra archivos y carpetas del directorio actual, en Linux seria el equivalente (mas o menos) a *ls*. Con *dir /a* ves archivos de sistema y ocultos. Con *dir /s* ense;a archivos del directorio y de los subdirectorios.
 *tree* igual que *dir* pero lo ense;a con forma de arbol.

 Listar contenido: En Linux usas ls, en Windows usas dir.
 
 Cambiar de directorio: En ambos es cd. (Ojo: en CMD, para cambiar de unidad, escribe la letra y dos puntos, ej: D:).
 
 Limpiar la terminal: En Linux es clear, en Windows es cls (Clear Screen).
 
 Crear carpetas: En ambos puedes usar mkdir. (Windows también acepta el atajo md).
 
 Borrar archivos: En Linux es rm, en Windows es del o erase.
 
 Ver el contenido de un archivo: En Linux usas cat, en Windows usas type.
 
 Mover archivos: En Linux es mv, en Windows es move.
 
 Renombrar archivos: En Linux usas mv, en Windows tienes el comando específico ren o rename.
 
 Copiar archivos: En Linux es cp, en Windows es copy. (Para carpetas enteras usa xcopy o robocopy).
 
 Información de red: En Linux es ip a, en Windows es ipconfig.
 
 Ruta de red (Saltos): En Linux es traceroute, en Windows es tracert

# Manejo de procesos

 *tasklist* para abrir el Task Manager de la terminal. Con *tasklist /FI* filtras el contenido con lo q quieras.
 *taskkill /PID target* para matar un proceso

# Otros Comandos
 *chkdsk*: checks the file system and disk volumes for errors and bad sectors.
 *driverquery*: displays a list of installed device drivers.
 *sfc /scannow*: scans system files for corruption and repairs them if possible.
