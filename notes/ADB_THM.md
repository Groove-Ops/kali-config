### ACTIVE DIRECTORY BASICS ##

# Comandos utiles

* Para lanzar el RDP desde la terminal linux: 
 xfreerdp /v:(Ip)  /u:(User) /p:(Password) /dynamic-resolution +clipboard

# Metodos de autenticacion

* Kerberos: Es un sistema de tickets, tu solo le enviar una vez la contrase;a y el te envia un ticket, con ese ticket puede ir yendo a los servicios que te hagan falta.
 La contrase;a solo viaja por la red al principio, el resto del tiempo solo se mueven tickets que van caducando. 
 Se ataca con Kerberoasting y Golden Tickets. Es más elegante y difícil de detectar si se hace bien.

* NTLM: Es mas antiguo, el de toda la vida por asi decirlo.
 Se basa en hashes, es sistema de pregunta y respuesta.Es como se guarda tu contraseña en la memoria del ordenador (en un proceso llamado lsass.exe).
 No tiene "sal", por lo que si dos usuarios tienen la misma contraseña, el hash es idéntico.

* El Ticket Granting Ticket (TGT) en Kerberos
 Es el ticket más importante de todos.
 Cuando te logueas, el controlador de dominio te da un TGT. Con ese ticket puedes pedir otros tickets para servicios específicos (como leer archivos o imprimir).

* Kerberoasting (El ataque favorito)

 Este cae siempre en los exámenes.
 A veces, algunos servicios (como una base de datos SQL) están ligados a una cuenta de usuario normal.
 Tú, como usuario raso, puedes pedir un ticket para usar ese servicio.   
 Ese ticket está cifrado con la contraseña del dueño del servicio.
 Tú te llevas ese ticket a tu Kali, y en tu casa, con tu potencia de cálculo (usando herramientas como Hashcat), intentas adivinar la contraseña por fuerza bruta sin que nadie te vea.

* Cuando hagas un escaneo con nmap o estés dentro de una máquina:
 Si ves el puerto 88 abierto, hay Kerberos.
 Si intentas conectar por IP (ej: \\10.10.x.x\share), Windows suele bajar el nivel a NTLM.
 Si conectas por nombre de equipo (ej: \\SERVIDOR\share), Windows intentará usar Kerberos.

* Cuando estés atacando desde la terminal, hay una herramienta de una suite llamada Impacket que usarás mil veces:
 Si el comando acaba en .py y usa -hashes, estás usando NTLM.
 Si usas -k, le estás diciendo que use Kerberos.

* NTLM: Se ataca con Relay y Pass-the-Hash. Es más fácil de explotar pero más ruidoso.
  Kerberos: Se ataca con Kerberoasting y Golden Tickets. Es más elegante y difícil de detectar si se hace bien.
