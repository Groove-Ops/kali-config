

# El modelo OSI (Las 7 capas)

1. Physical Layer
2. Data Link Layer
3. Network Layer
4. Transport Layer
5. Session Layer
6. Presentation Layer
7. Application Layer

- Es el mapa de la red, si algo falla este modelo te dice donde mirar
	- Capas Bajas (1-4): Es el transporte (Cables,IPs,Puertos)	
	- Capas Altas(5-7): Es la aplicacion, lo que ves en el navegador o la aplicacion que se este conectando  a internet

## Capa 1: Fisica (Physical)

- Es el hardware puro. Lo que puedes tocar o el espectro electromagnetico
	- Que hace: Transmite bits (0s y 1s) a traves del medio fisico.
	
			Clave: Cables (Ethernet/Fibra), conectores, voltajes, frecuencias de radio (Wi-Fi)

## Capa 2: Enlace de Datos (Data Link)

- Es la comunicacion entre dos dispositivos que estan en la misma red (conectados al mismo switch)
	- Que hace: Direccionamiento fisico y deteccion de errores en el medio fisico
	- Unidad de datos: Trama (Frame)
	- Disposistivo: El Switch.
	
			Clave: Direccion MAC (el ID fisico de tu tajeta de red) y el protocolo ARP (que asocia IPs con MACs)

## Capa 3: Red (Network)

- Es el "GPS" o el "Cartero". Se encarga de que el paquete llegue a la direccion correcta a traves de diferentes redes
	- Que hace: Determina la mejor ruta (enrutamiento) y gestiona el direccionamiento logico
	- Unidad de datos: Paquete
	- Dispositivo: El router.
	
			Clave: Direcciones IP (IPv4 / IPv6) ,el protocolo ICMP (el que usa el comando ping, Virtual Private Netwrok (VPN), y protocolos como IPSec y SSL/TLS VPN 

## Capa 4: Transporte (Transport)

- CRUCIAL. Aqui se decide como viaja la info. Es la capa de los puertos
	- Que hace: Segmenta los datos y se encarga del control de errores y flujo
	- Protocolos clave:
		- TCP: Conexion Seguro (saludo previo o handshake). Si algo falla, se reenvia
		- UDP: Envio rapido sin comprobacion. (Ideal para streaming o juegos).
		
				En Ciber: Aqui es donde haces los escaneos de puertos con *nmap*

## Capa 5: Sesion (Session)

- Es el coordinador. Abre, mantiene y cierra la comunicacion entre dos dispositivos
	- Que hace: Gestiona el dialogo. Si estas descargando algo y se corta, esta capa intenta que no tengas que empezar de cero (puntos de control).
	
			Clave: Autenticacion y permisos de sesion

## Capa 6: Presentacion (Presentation)

- Es el traductor de la red. Se encarga de que los datos sean legibles
	- Que hace: Formatea, cifra y comprime los datos. Se asegura dde que si envias un .mp3, el otro lado sepa que es un .mp3.
	
			Clave: Aqui es donde actua el cifrado SSL/TLS

## Capa 7: Aplicacion (Application)

- Es la capa que tocas. No es el programa en si (como el navegador), si no el protocolo que permite que esa aplicacion hable con la red
	- Que hace: Proporciona servicios de red al usuario
	- Protocolos clave: HTTP/HTPS (web), FTP (archivos), SMTP (correo), DS (nombres de dominio)
	
			En Ciber: Aqui es donde ocurren los ataques de inyeccion SQL o Cross-Site Scripting (XSS) 

# El Modelo TCP/IP (RFC 1122) (De arriba a abajo)

- El RFC 1122 es el documento oficial que define cómo debe funcionar una ordeandor en internet
- En este modelo, las capas superiores de OSI se fusionan porque, para internet, lo que importa es que los datos lleguen y se procesen, no tanto la "etiqueta" de cómo se presentan

## Capa 4: Aplicacion (Aplication)

- Equivale a las capas 5,6 y 7 de OSI
	- Que hace: Aqui es donde residen los protocos que usan los programas (navegadores, aplicaciones, la terminal). No se preocupa de como viajan los datos, solo de que datos son
	- Protocolos: HTTP, FTP, SSH, DNS, SMTP
	
			Resumen: Es el "que" estamos enviando

## Capa 3: Transporte (Transport)

- Equivale a la capa 4 de OSI
	- Que hace: Se encarga de la comunicacion de extremo a extremo (de tu PC al servidor). Aqui es donde se decide la fiabilidad
	- Protocolos clave:
		- TCP (Transmission Control Protocol): Fiable, garantiza que los datos lleguen completos y en orden.
		- UDP (User Datagram Protocol): Rápido, no garantiza la llegada.
		    
				Resumen: Es el "como" viajan los datos (Seguro o rapido)

## Capa 2: Internet

- Equivale a la capa 3 de OSI
	- Que hace: Es la capa mas importante de este modelo. Se encarga de ponerle direccion a los paquetes y enviarlos a traves de las redes (routing)
	- Protocolos clave: IP (IPv4/IPv6), ICMP (ping), IGMP
		
			Resumen: Es el "hacia donde" van los datos (Direcciones IP)

## Capa 1: Acceso a la RED (Link/Network Acces)

- Equivale a las capas 1 y 2 de OSI
	- Que hace: Define como se envian fisicamente los datos por el medio (cable, Wi-Fi). Maneja direcciones fisicas (MAC)
		- Clave: Ethernet, Wi-Fi, protocolos de hardware
		
				Resumen: Es el "por donde" fisico pasan los bits.

| Capa OSI        | Capa TCP/IP (RFC 1122) |
| --------------- | ---------------------- |
| 7. Aplicación   |                        |
| 6. Presentación | 4. Aplicación          |
| 5. Sesión       |                        |
| 4. Transporte   | 3. Transporte          |
| 3. Red          | 2. Internet            |
| 2. Enlace       | 1. Acceso a la Red     |
| 1. Física       |                        |
# IP Adresses and Subnets

- ¿Qué es una Dirección IP?
	- Es el identificador lógico de un dispositivo en la red.
		- IPv4: Formada por 32 bits, divididos en 4 octetos (ej: 192.168.1.1).
		- Estructura: Una parte identifica la Red y otra parte identifica al Host (dispositivo).

## Máscara de Subred (Subnet Mask)

- Es lo que le dice al PC qué parte de la IP es "calle" (red) y qué parte es "número de portal" (host).
	- Ejemplo: 255.255.255.0
		- Notación CIDR: Es la forma corta de escribir la máscara (ej: /24). El número indica cuántos bits están "encendidos" para la red.

## Tipos de Direcciones Especiales

- En cada subred, hay dos direcciones que no puedes usar para dispositivos:

	- Network ID: La primera IP de la red (termina en .0 en un /24). Identifica a la red completa.
    - Broadcast Address: La última IP de la red (termina en .255 en un /24). Se usa para enviar datos a todos los dispositivos de esa red a la vez.

## IPs Públicas vs. Privadas

- Públicas: Visibles en todo internet (la que te da tu operadora).
	- Privadas: Solo funcionan dentro de tu casa/oficina (LAN). Los rangos estándar son:
		- 10.0.0.0 - 10.255.255.255 (Grandes empresas)
		- 172.16.0.0 - 172.31.255.255
		- 192.168.0.0 - 192.168.255.255 (Tu casa/router)

## ¿Qué es el Subnetting?

- Es la técnica de dividir una red grande en redes más pequeñas (subredes).
	- Para qué sirve: Seguridad (aislar dispositivos) y eficiencia (reducir el tráfico innecesario).
	- Cómo se hace: Se "roban" bits a la parte del Host para dárselos a la parte de la Red, cambiando la máscara (ej: pasar de un /24 a un /26).
### TIP DE PENTESTING: Si estás en una red con máscara /24 y tu IP es 10.10.10.5, sabes que puedes atacar a cualquier IP entre la 10.10.10.1 y la 10.10.10.254.

