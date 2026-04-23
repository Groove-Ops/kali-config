### POWER SHELL ###

# ¿Qué es realmente? (La base técnica)

 A diferencia de CMD o Bash (que manejan texto), PowerShell es orientado a objetos.
 En Bash/CMD: Si pides una lista de archivos, el sistema te escupe "letras" (texto). Si quieres sacar solo el tamaño, tienes que "cortar" el texto.
 En PowerShell: El sistema te devuelve un objeto vivo. Ese objeto tiene propiedades (Nombre, Tamaño, Fecha de creación). Puedes pedirle directamente: "Dime solo el tamaño" y él sabe exactamente qué dato es, sin errores de lectura.

# Los Cmdlets (El lenguaje)

 PowerShell no usa comandos aleatorios, usa una estructura lógica de Verbo-Sustantivo:
 Get-Help: Para pedir ayuda.
 New-Item: Para crear algo (un archivo o carpeta).
 Stop-Process: Para matar un programa.
 Esta lógica hace que, aunque no sepas el comando exacto, puedas adivinarlo.

# El "Pipe" (|) es más inteligente

 En Linux, el (|) pasa texto de un comando a otro. En PowerShell, el (|) pasa objetos completos.
 Ejemplo de hacker: Puedes buscar todos los procesos del ordenador, pasarlos por el Pipe y decirle: "Filtra los que consuman más de 100MB de RAM y después mátalos". Todo en una sola línea muy limpia.

# ¿Por qué es el "sueño" de un pentester?

 Si hackeas una máquina Windows, PowerShell es tu mejor amigo (y el peor enemigo del administrador) por esto:
 Acceso total: Puede tocar el Registro de Windows, los certificados de seguridad, los usuarios del Active Directory y hasta el hardware.
 Fileless Attacks (Ataques sin archivos): PowerShell puede ejecutar código directamente en la memoria RAM sin descargar nada al disco duro. Esto hace que muchos antivirus no se enteren de que estás ahí metido.
 Administración Remota: Con Invoke-Command, puedes ejecutar comandos en 50 servidores a la vez desde una sola terminal.

# Cmlets utiles

(Cmlet) -Property (Propiedad que queremos) -(comparation operator) (x)

 *Comparation operators*
 -ne: not equal
 -gt: greater than
 -ge: greater than or equal to
 -lt: less than
 -le: less than or equal to
 -like: property match to

 Select-Object selecciona las propiedades que queremos y solo muestra estas

# System and Nework Cmlets

*Get-LocalUser* = Lista todos los usuarios del sistema
*Get-NetIpConfiguration* = Da informacion detallada de la network
*Get-ComputerInfo* = Da informacion sobre el sistema actual
*Get-NetIPAdress* = Da informacion sobre todas las direcciones IP configuradas en el sistema, incluso las q no estan activas

# Real-Time System Analysis

*Get-Process* = Da informacion detalladad sobre los procesos actuales
*Get-Service* = Da informacion sobre los servicios actuales incluyendo si estan pausados, activos o detenidos.
*Get-NetTCPConnection* = Da las conexiones TCP actuales
*Get-Filehas* = Genera file hashes.
*Get-Item -Patch "(el archivo)" -Stream ** = Sirve para ver el ADS (Alternate Data Streams)

# Scripting
 *Invoke-Command* = Sirve para ejectuar comandos en otro sistema .La lógica es: "Toma este código, llévatelo a aquel PC, ejecútalo allí y tráeme el resultado de vuelta a mi pantalla".
  Sintaxis Basica de *Invoke-Command*= Invoke-Command -ComputerName NOMBRE_DEL_PC -ScriptBlock { comando_aquí }
