## REDES ##

# Gateway

 Imagínate que tu red de casa es una habitación. Puedes hablar con cualquiera que esté dentro de la habitación gritando. Pero si quieres hablar con alguien que está fuera (Internet o TryHackMe), tienes que pasar por la puerta.
 Qué es: Es la dirección IP del router (normalmente 10.x.x.1 o 192.168.x.1).
 En el CMD: Si pones ipconfig, lo verás como Default Gateway. Si esta IP falla, no sales de tu "habitación".

# Mascara de Subred (Subnet Mask)

 Es lo que define qué tan grande es tu "habitación".
 Lo que verás siempre: 255.255.255.0.
 Traducción: Esto le dice a tu ordenador que los primeros tres números de tu IP (ej: 192.168.1.X) son el nombre de tu red, y el último número es tu "asiento" personal.
 Por qué importa: Si intentas hacer ping a una IP que está fuera de tu máscara sin pasar por el Gateway, el paquete se perderá.
 255 es el limite del lenguaje binario, significa esto no se toca
 1
# Protocolo ARP (Quien es quien)

 Este es vital para el hacking. Las IPs son para los humanos, pero las máquinas se hablan por su dirección MAC (el DNI físico de la tarjeta de red).
 Qué hace: Cuando tu Kali quiere hablar con la IP 10.10.x.x, grita en la red: "¿Quién tiene la IP 10.10.x.x? ¡Dime tu MAC!".
 El comando: En el CMD de Windows, pon arp -a. Verás una lista de IPs y sus direcciones físicas.
 Hack: Muchos ataques consisten en engañar a la red diciendo: "¡Yo soy el Gateway! Mandadme vuestras MACs a mí". (ARP Spoofing).

# Puertos y Sockets

 Una IP es la dirección de un edificio. El puerto es el número del piso.
 TCP: Es el protocolo "educado". Envía un paquete, espera confirmación, y si no llega, lo vuelve a enviar. Se usa para webs (80/443), RDP (3389) y SSH (22).
 UDP: Es el protocolo "techno". Lanza paquetes a toda leche y no le importa si se pierden. Se usa para streaming y juegos.
 En el CMD: Pon netstat -ano. Verás qué "ventanas" (puertos) tiene abiertas esa máquina de Windows. Si el puerto 445 está abierto (SMB), ¡tienes una posible entrada!

# DNS

 Es el traductor: Convierte nombres fáciles de recordar (google.com) en números difíciles (142.250.184.46).
 Ahorra memoria: Evita que tengas que ir con una libreta apuntando las IPs de cada web que visitas.
 Funciona por consulta: Tu PC pregunta al servidor DNS ("¿Qué IP tiene X?"), el servidor responde, y tu PC guarda esa respuesta un rato para no preguntar cada segundo.
 Usa el puerto 53: Es su "ventana" estándar para hablar, normalmente bajo el protocolo UDP por ser más rápido.
 Punto de ataque: Si un hacker controla tu DNS, puede decirte que la IP de tu banco es la de su propio servidor y robarte los datos sin que la URL cambie.Es el traductor: Convierte nombres fáciles de recordar (google.com) en números difíciles (142.250.184.46).
