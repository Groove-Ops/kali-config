
# 🆔 DHCP (Dynamic Host Configuration Protocol)
### **Puerto:** 67 (Servidor) y 68 (Cliente) | **Protocolo:** UDP

## 1. Definición

El DHCP es el protocolo encargado de automatizar la configuración de red de los dispositivos. Su función principal es asignar direcciones IP de forma dinámica para evitar conflictos y ahorrar tiempo de administración manual.

## 2. El Proceso D.O.R.A. (Paso a paso)

Para que un cliente obtenga una IP, se realizan 4 intercambios de paquetes:

1.  **D - Discover (Descubrimiento):** El cliente "grita" en la red local buscando un servidor DHCP.
2.  **O - Offer (Oferta):** El servidor responde ofreciendo una configuración (IP, máscara, etc.).
3.  **R - Request (Solicitud):** El cliente confirma que quiere esa IP específica.
4.  **A - Acknowledgment (Reconocimiento):** El servidor finaliza el proceso y reserva la IP para el cliente.

## 3. Anatomía del Paquete (Detalles de Red) CRÍTICO

Durante los pasos 1 (**Discover**) y 3 (**Request**), el cliente aún no tiene una configuración válida. Por ello, los paquetes se envían así:

* **IP de Origen (`0.0.0.0`):** Indica que el cliente no tiene IP asignada todavía.
* **IP de Destino (`255.255.255.255`):** Es una dirección de **Broadcast**. El mensaje se envía a todos los dispositivos de la red local porque el cliente no conoce la IP del servidor DHCP.
* **Dirección MAC:** El servidor usa la MAC del cliente para saber a quién le está respondiendo físicamente.

## 4. ¿Qué información entrega el DHCP?

El "kit" de configuración que recibe el cliente incluye:

* **IP Address:** Tu dirección lógica.
* **Subnet Mask:** Define el tamaño de tu red.
* **Default Gateway:** La IP del router para salir de la red local.
* **DNS Servers:** Direcciones para resolver nombres de dominio (ej. 8.8.8.8).
* **Lease Time (Tiempo de concesión):** Cuánto tiempo puedes usar esa IP antes de tener que renovarla.

## 5. Conceptos Avanzados y Ciberseguridad

* **DHCP Relay:** Los routers no pasan mensajes de "Broadcast". Si el servidor DHCP está en otra red, se necesita un agente (Relay) que reenvíe el mensaje.
* **DHCP Starvation (Ataque):** Un atacante agota todas las IPs del servidor usando MACs falsas, dejando a los usuarios legítimos sin conexión.
* **Rogue DHCP Server:** Un atacante monta un servidor falso para dar configuraciones maliciosas (ej. cambiar el Default Gateway para interceptar tráfico).
* **Conflictos de IP:** Si un cliente detecta que la IP ofrecida ya está en uso (mediante un ARP gratuito), rechazará la oferta.

## 6. Comandos de Consola

* **Windows:** `ipconfig /release` (soltar IP) y `ipconfig /renew` (pedir nueva IP).
* **Linux:** `nmcli device show` o revisar `/var/lib/dhcp/dhclient.leases`.

## Notas

- El proceso D.O.R.A. es extremadamente ligero. Al usar UDP, no hay una "negociación" pesada de conexión. Es un intercambio de 4 paquetes pequeños que se completa en milisegundos para permitir que el dispositivo esté operativo casi al instante de detectar el enlace físico.
- Todo esto ocurre de una forma ultra rapida, un atacante puede programar un script que pida 100 IPs por segundo, entonces puede agotar todas las IPs disponibles de un router pequeño, en ese momento un hacker puede engañar a tu PC con un DHCP falso, pero tiene que ser mas rapido que el router.

# 🔍ARP (Address Resolution Protocol)
### **Capa:** 2 (Enlace de Datos) | **Protocolo:** No usa puertos (trabaja directamente sobre Ethernet).

## 1. ¿Qué es el ARP?

Es el traductor que une el mundo "lógico" (Direcciones **IP**) con el mundo "físico" (Direcciones **MAC**). 
* **El problema:** Tu router sabe que quiere enviar datos a la IP `192.168.1.15`, pero el cable de red y el switch solo entienden de direcciones MAC físicas (`00:1A:2B...`). El ARP descubre quién tiene qué MAC.

## 2. El Proceso de Funcionamiento (Petición y Respuesta)

Cuando un dispositivo quiere hablar con una IP en su misma red local:

1.  **ARP Request (Petición):** El emisor envía un mensaje de **Broadcast** (a todos) diciendo: *"¿Quién tiene la IP 192.168.1.15? Dile a 192.168.1.1 tu dirección MAC"*.
2.  **ARP Reply (Respuesta):** El dispositivo que tiene esa IP responde directamente al emisor (Unicast): *"Yo soy 192.168.1.15 y mi MAC es AA:BB:CC:DD:EE:FF"*.
3.  **ARP Cache:** El emisor guarda esa relación en una tabla temporal (Cache) para no tener que preguntar de nuevo cada segundo.

## 3. La "Tabla ARP" (ARP Table)

Es la memoria a corto plazo de tu dispositivo. Puedes ver la tuya ahora mismo:
* **En Windows/Linux:** Abre la terminal y escribe `arp -a`.
* Verás una lista de IPs junto a sus correspondientes MACs físicas.

## 4. Detalles Críticos (Lo que no puedes olvidar)

* **Solo funciona en Red Local:** El ARP no viaja por internet. Solo sirve para hablar con dispositivos conectados al mismo switch o Wi-Fi.
* **Es "Stateless" (Sin estado):** Los dispositivos aceptan respuestas ARP **incluso si no han preguntado nada**. Esto es un fallo de diseño masivo.
* **Gratuitous ARP:** Un mensaje que un PC envía al conectarse para anunciar su MAC a todos sin que nadie pregunte. Sirve para detectar conflictos de IP.

## 5. Ciberseguridad: ARP Spoofing (Envenenamiento) ⚠️

Es uno de los ataques más clásicos y potentes en red local:

* **El Ataque:** Un hacker envía mensajes ARP falsos al Router diciendo: *"Yo soy la víctima"*, y a la Víctima diciendo: *"Yo soy el Router"*.
* **Resultado:** Todo el tráfico de la víctima pasa por el ordenador del hacker antes de ir a internet. 
* **Objetivo:** Interceptar contraseñas, ver qué webs visita la víctima o modificar los datos en tiempo real (**Man-in-the-Middle**).

## 6. Comandos útiles

* `arp -a`: Muestra la tabla ARP actual.
* `arp -d *`: Borra la tabla ARP (fuerza a preguntar de nuevo).

## Notas

### ⚠️ Aclaración importante: Alcance de los Protocolos
* **ARP (Local):** Solo vive dentro de la red local (LAN). Sirve para que los dispositivos se encuentren físicamente (MAC). El tráfico ARP nunca sale a Internet.
* **DHCP (Configuración):** El Router actúa como **Servidor** para tus dispositivos locales.
    * El Router actúa como **Cliente** para obtener su IP pública de la operadora de Internet.
* **Internet Real:** Una vez que el paquete sale de tu router, el ARP ya no importa. El tráfico se mueve mediante **Direcciones IP** y tablas de enrutamiento a gran escala.


# 🛠️ ICMP (Internet Control Message Protocol)
### **Capa:** 3 (Red) | **Uso:** Diagnóstico y reporte de errores.

## 1. ¿Qué es el ICMP?

Es el protocolo que utilizan los dispositivos de red para enviarse mensajes de control. No tiene puertos (como TCP/UDP), ya que funciona directamente sobre la capa de IP. 

## 2. Tipos de Mensajes Críticos (Types)

El ICMP usa códigos numéricos para decir qué está pasando. Los más importantes son:

* **Echo Request (Type 8):** *"¿Estás ahí?"* (Es el ping que envías).
* **Echo Reply (Type 0):** *"Sí, aquí estoy"* (La respuesta al ping).
* **Destination Unreachable (Type 3):** *"No puedo llegar ahí"*. Puede ser porque el puerto está cerrado, la red no existe o el router no sabe el camino.
* **Time Exceeded (Type 11):** *"El paquete ha muerto por el camino"*. Se usa cuando el **TTL** llega a 0.

## 3. El concepto de TTL (Time To Live)

Para evitar que un paquete esté dando vueltas por internet para siempre si hay un error de bucle, cada paquete tiene un "contador de vida" llamado TTL.
1. Cada vez que el paquete pasa por un router (un salto), el TTL baja en **1**.
2. Si el TTL llega a **0**, el router descarta el paquete y envía un mensaje **ICMP Type 11** de vuelta al emisor.

## 4. Herramientas de Troubleshooting (Diagnóstico)

* **PING:** Usa el Echo Request/Reply para medir la latencia (ms) y ver si hay conectividad básica.
* **TRACEROUTE (tracert):** Usa de forma ingeniosa el **TTL**. Envía paquetes con TTL=1, luego TTL=2, luego TTL=3... Así, cada router del camino se ve obligado a responder con un ICMP de "Time Exceeded", permitiéndote ver la IP de cada salto hasta el destino.

## 5. Ciberseguridad y Riesgos

* **Ping of Death:** Un ataque antiguo que enviaba paquetes ICMP malformados para colapsar sistemas.
* **ICMP Flooding (DoS):** Inundar una red con pings para saturar el ancho de banda.
* **Reconocimiento:** Los hackers usan ping para saber qué máquinas están "vivas" en una red antes de atacarlas. 
    * *Nota:* Muchos administradores bloquean el ICMP en el Firewall para que sus servidores sean "invisibles" al comando ping.
* **Exfiltración de datos:** Es posible ocultar datos robados dentro de los paquetes ICMP (ICMP Tunneling) para sacarlos de una empresa sin levantar sospechas, ya que a menudo este tráfico no se vigila.

### 📝 Resumen Ejecutivo: ICMP (El Operario)

* **¿Cuándo aparece?** Principalmente cuando hay errores o cuando hacemos pruebas manuales.
* **¿Qué transporta?** Mensajes de control y estado de la red (no datos de usuario).
* **Visibilidad:** Baja. Es un protocolo de "background" (segundo plano).
* **Diferencia clave:** * El usuario normal usa **TCP/UDP** para "hablar" con apps.
    * Los routers y admins usan **ICMP** para "hablar" con la infraestructura.

# 🛣️Routing (Enrutamiento)
### **Capa:** 3 (Red) | **Dispositivo clave:** Router

## 1. ¿Qué es el Routing?

Es el proceso de seleccionar el mejor camino para enviar paquetes a través de diferentes redes. Si el Switch es el portero de tu edificio (red local), el **Router** es el cartero que sabe cómo llegar a otras ciudades.

## 2. El "Cerebro" del Router: La Tabla de Enrutamiento

Cada router tiene una **Routing Table**. Es una base de datos que le dice: "Si el paquete va a la Red X, envíalo por la Salida Y". 

Contiene 3 elementos clave:

* **Destination Network:** La red a la que quieres llegar.
* **Next Hop (Siguiente Salto):** La IP del siguiente router en el camino.
* **Interface:** Por qué cable físico (puerto) debe salir el paquete.
  
## 3. Tipos de Rutas

* **Directly Connected:** Redes que están enchufadas físicamente al router. No necesita preguntar a nadie, sabe que están ahí.
* **Static Routes (Rutas Estáticas):** El administrador las escribe a mano. *"Para ir a la oficina B, vete por aquí"*. Son seguras pero no cambian si un cable se rompe.
* **Dynamic Routes (Rutas Dinámicas):** Los routers "hablan" entre ellos mediante protocolos (como OSPF o BGP) para aprender los caminos automáticamente. Si un camino se corta, ellos solos buscan una alternativa.
* **Default Route (Ruta por defecto):** La "ruta del último recurso". Si el router no encuentra el destino en su tabla, envía el paquete aquí (normalmente hacia tu proveedor de Internet/ISP). Se representa como `0.0.0.0/0`.

## 4. El Proceso de Decisión (Paso a paso)

1. Llega un paquete al Router.
2. El Router mira la **IP de Destino**.
3. Busca en su **Routing Table** la coincidencia más específica.
4. Si la encuentra, lo reenvía al **Next Hop**.
5. Si NO la encuentra, lo envía por la **Default Route**.
6. Si no hay Default Route, descarta el paquete y envía un **ICMP Destination Unreachable**.

## 5. Ciberseguridad: Riesgos en Routing

* **Route Poisoning:** Un atacante engaña a los routers para que crean que un camino es mejor que otro, desviando el tráfico hacia su propia máquina.
* **Puertas de enlace maliciosas:** Si logras que un PC use tu IP como "Default Gateway" (mediante ARP Spoofing), te conviertes en el router de esa víctima y ves todo su tráfico.


## 🌐 El Viaje de un Paquete (End-to-End Routing)

El routing no es un solo paso, es una carrera de relevos:

1. **Host Routing:** Tu PC decide si el destino es local o remoto. Si es remoto, lo envía al **Default Gateway**.
2. **Edge Routing:** Tu router de casa decide enviarlo a la red de tu proveedor (ISP).
3. **Core Routing:** Los routers de internet (BGP) mueven el paquete entre países y continentes basándose en las mejores rutas posibles.

**Concepto Clave: Hop (Salto)**
Cada vez que un paquete pasa por un router, se considera un "salto". Puedes ver todos los saltos de tu conexión actual usando:
* `tracert google.com` (Windows)
* `traceroute google.com` (Linux)

### 🔬 Caso de estudio: Traceroute a Google
Al realizar un `tracert google.com`, se observan los siguientes niveles de enrutamiento:
1. **Salto 1 (Gateway Local):** `mygpon.ip` -> Mi router doméstico.
2. **Saltos 2-8 (ISP Core):** Routers de mi proveedor de internet moviendo el paquete por su red nacional.
3. **Salto Final (Destino):** Red de Google (`1e100.net`).

**Dato técnico:** Cada salto incrementa ligeramente la latencia (ms). Si un salto muestra `* * *`, significa que ese router tiene el ICMP bloqueado por seguridad (es "tímido").