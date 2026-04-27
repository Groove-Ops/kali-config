# 📖DNS (Domain Name System)

	**Capa:** 7 (Aplicación) | **Puerto:** 53 (UDP/TCP) | **Uso:** Resolución de nombres.

## 1. ¿Qué es el DNS?

	Es el "listín telefónico" de Internet. Su función es la **resolución de nombres**: convertir una URL en una dirección IP. 

* Usa **UDP** para consultas rápidas.
* Usa **TCP** cuando los datos de respuesta son muy grandes (transferencias de zona).

## 2. La Jerarquía DNS (El árbol)

	El DNS no es un solo servidor; es una estructura jerárquica que se lee de **derecha a izquierda**:

1. **Root Servers ( . ):** El punto final (invisible). Hay 13 grupos de servidores raíz en el mundo que saben dónde están los TLD.
2. **TLD (Top-Level Domains):** Las extensiones como `.com`, `.net`, `.org`, `.es`.
3. **Domain:** El nombre comprado, ej: `tryhackme`.
4. **Subdomain:** Prefijos como `blog`, `store` o el clásico `www`.



## 3. El Proceso de Consulta (Paso a paso)

	Cuando escribes una web, ocurre lo siguiente:

1. **DNS Cache:** Tu PC mira si ya sabe la IP (en su memoria o en el archivo `hosts`).
2. **Recursive Resolver:** Si no lo sabe, le pregunta al servidor DNS de tu ISP (o a Google 8.8.8.8).
3. **Iterative Search:** El resolver le pregunta al **Root** (¿dónde está el .com?), luego al **TLD** (¿dónde está google.com?) y finalmente al **Authoritative DNS** (el servidor que tiene la respuesta final).

## 4. Tipos de Registros DNS (Vital para Ciberseguridad)

* **A Record:** Mapea un nombre a una dirección **IPv4**.
* **AAAA Record:** Mapea un nombre a una dirección **IPv6**.
* **CNAME (Canonical Name):** Un alias. Dice que `tienda.com` es lo mismo que `servidor1.com`.
* **MX Record (Mail Exchange):** Indica qué servidor gestiona los correos del dominio.
* **TXT Record:** Texto libre. Se usa mucho para verificar propiedad del dominio y para seguridad de correo (SPF, DKIM).

## 5. Ciberseguridad: ¿Por qué importa el DNS?

* **DNS Spoofing/Poisoning:** Engañar al servidor DNS para que guarde una IP falsa. La víctima escribe `mibanco.es` y el DNS le da la IP de un servidor del atacante.
* **Data Exfiltration:** Un hacker puede sacar datos robados de una red escondiéndolos dentro de consultas DNS (ya que el firewall casi nunca bloquea el puerto 53).
* **Reconocimiento:** Listar los subdominios de una empresa (`vpn.empresa.com`, `dev.empresa.com`) permite encontrar puertas traseras.

# 🔍 WHOIS

	**Uso:** Obtener información sobre el registro de un nombre de dominio.

## 1. ¿Qué es WHOIS?

Es un protocolo de consulta y respuesta que se utiliza para buscar en bases de datos que almacenan los usuarios registrados de un recurso de Internet, como un nombre de dominio o un bloque de direcciones IP.

## 2. Información Clave que revela un WHOIS

- Cuando haces una consulta WHOIS, buscas principalmente:
* **Registrar:** La empresa donde se compró el dominio (ej. GoDaddy, Namecheap).
* **Registrant:** La persona o empresa dueña del dominio (Nombre, dirección, email).
* **Contactos:** Contacto administrativo, técnico y de facturación.
* **Fechas:** Cuándo se creó, cuándo se actualizó por última vez y cuándo **caduca**.
* **Name Servers:** Los servidores DNS que utiliza el dominio.

## 3. WHOIS Privacy (El "muro")

- Hoy en día, debido a leyes de privacidad como el **GDPR**, mucha información personal aparece como "Redacted for Privacy" o protegida por servicios como "WhoisGuard". 

		Tip de Hacker: Aunque esté oculto, a veces el email del contacto técnico o los Name Servers dan pistas sobre qué empresa de hosting está usando el objetivo.

## 4. ¿Por qué es vital en Ciberseguridad?

1. **Atribución:** Ayuda a identificar quién está detrás de una web de phishing.
2. **Ingeniería Social:** Conocer el nombre del administrador técnico permite realizar ataques dirigidos más creíbles.
3. **Monitoreo de Caducidad:** Los atacantes vigilan cuándo caduca un dominio importante para comprarlo en cuanto quede libre (Domain Snapping).
4. **Footprinting:** Identificar otros dominios que pertenecen a la misma persona/empresa usando el mismo email o dirección.

## 5. Cómo usarlo

* **Web:** Páginas como `whois.com` o `viewdns.info`.
* **Terminal:** Simplemente escribe `whois <dominio>`.
    * Ejemplo: `whois tryhackme.com`

# 🌐 HTTP(S) - Accessing the Web

	**Capa:** 7 (Aplicación) | **Puertos:** 80 (HTTP) y 443 (HTTPS).

## 1. ¿Qué es HTTP?

	**HyperText Transfer Protocol**. Es un protocolo basado en el modelo **Cliente-Servidor**.

* **Cliente:** Tu navegador (Chrome, Firefox, Safari).
* **Servidor:** El ordenador remoto donde está la web (ej. el servidor de TryHackMe).

## 2. La diferencia Crítica: HTTP vs HTTPS

* **HTTP (Puerto 80):** Los datos viajan en **texto plano**. Si alguien "pincha" el cable (sniffer), puede ver tus contraseñas y mensajes.
* **HTTPS (Puerto 443):** Es HTTP con **TLS/SSL (Cifrado)**. Los datos se encriptan antes de salir de tu PC. Solo tú y el servidor tenéis la llave para leerlos.

## 3. El Ciclo de Vida: Solicitud y Respuesta

- Cuando entras en una web, ocurre esto:
1. **Request (Petición):** Tu navegador envía un mensaje al servidor.
2. **Response (Respuesta):** El servidor te contesta con un código y el contenido.
## 4. Métodos HTTP (Verbos)

- Son las "acciones" que pides al servidor. Los más importantes son:
	* `GET`: Para pedir información (ver una página).
	* `POST`: Para enviar información (subir una foto, enviar un formulario de login).
	* `PUT`: Para actualizar algo que ya existe.
	* `DELETE`: Para borrar algo.

## 5. Códigos de Estado (Status Codes)

	El servidor te responde con un número que indica qué ha pasado. ¡Aprende los rangos!

* **2xx (Success):** Todo ha ido bien. El más famoso es **200 OK**.
* **3xx (Redirection):** La página se ha movido. **301** (Permanente).
* **4xx (Client Error):** Tú has hecho algo mal. **404 Not Found** (no existe) o **403 Forbidden** (no tienes permiso).
* **5xx (Server Error):** El servidor ha petado. **500 Internal Server Error**.

## 6. Anatomía de una Petición (Headers)

- Los **Headers** son metadatos que dan contexto:
	* **User-Agent:** Le dice al servidor si eres un iPhone, un PC Windows o un script de hacking.
	* **Cookie:** Tu "identificación" para que el servidor sepa que eres tú y no tengas que loguearte en cada clic.
	* **Referer:** Indica de qué página vienes.

# 📂FTP (File Transfer Protocol)

	**Capa:** 7 (Aplicación) | **Puertos:** 21 (Control) y 20 (Datos) | **Modelo:** Cliente-Servidor.

## 1. ¿Qué es el FTP?

- Es un protocolo diseñado exclusivamente para transferir archivos entre un cliente y un servidor. Permite subir, descargar, borrar y renombrar archivos de forma remota.
## 2. El misterio de los dos puertos 🕵️

- A diferencia de HTTP, el FTP usa **dos conexiones** distintas para funcionar:
* **Puerto 21 (Canal de Control):** Se usa para enviar los comandos (ej: "quiero descargar X", "borra Y", "mi usuario es Z").
* **Puerto 20 (Canal de Datos):** Se usa exclusivamente para mover el contenido del archivo. 
## 3. Modos de Conexión 

* **Active Mode (Activo):** El cliente le dice al servidor en qué puerto está escuchando, y el **servidor inicia** la conexión de datos. (Suele dar problemas con los Firewalls).
* **Passive Mode (Pasivo):** El servidor le dice al cliente a qué puerto conectarse, y el **cliente inicia** la conexión. Es el estándar hoy en día porque atraviesa mejor los Firewalls.

## 4. FTP Anónimo (Anonymous FTP)

	Es una configuración donde el servidor permite entrar a cualquiera sin una cuenta personal.

* **Usuario:** `anonymous`
* **Contraseña:** Suele ser cualquier texto o un email ficticio.
* **Riesgo:** Si el administrador permite "escritura", cualquiera puede subir malware al servidor.

## 5. Seguridad: El gran problema ⚠️

* **FTP Estándar:** Todo viaja en **texto plano**. Si capturas el tráfico con Wireshark, verás el usuario y la contraseña del administrador sin ningún esfuerzo.
* **SFTP (Secure FTP):** Usa **SSH** para cifrar todo. Es el que deberías usar siempre.
* **FTPS:** Es FTP sobre **SSL/TLS** (como el HTTPS de las webs).

## 🛠️ Comandos "Raw" del Protocolo FTP

	Cuando usas un cliente (como FileZilla o el comando `ftp`), por debajo se envían estos comandos de texto plano:

* `USER`: Envía el nombre de usuario (ej: `USER anonymous`).
* `PASS`: Envía la contraseña (aunque sea en blanco).
* `RETR`: (Retrieve) El comando real para **descargar** un archivo.
* `STOR`: (Store) El comando real para **subir** un archivo.
* `LIST`: Lo que el cliente traduce cuando tú escribes `ls`.

## 📂 Modos de Transferencia de Datos

- Antes de descargar, el protocolo permite elegir cómo se tratarán los bits:
* **ASCII Mode (`type ascii`):** Optimizado para archivos de texto (`.txt`, `.html`). Ajusta los finales de línea según el sistema operativo.
* **Binary Mode (`type binary`):** El más importante. Para imágenes, ejecutables, ZIPs, etc. Envía el archivo bit a bit sin tocar nada. 
	
		Tip:* Si descargas una imagen en modo ASCII, se corromperá.

## 💻 Ejemplo de Sesión Real (Terminal)

1. `ftp 10.113.140.234` -> Abrir conexión al puerto 21.
2. Login: `anonymous` (sin password).
3. `ls` -> Ver qué hay.
4. `type ascii` -> Preparar la transferencia para texto plano.
5. `get coffee.txt` -> El cliente envía un `RETR coffee.txt` y lo guarda en tu PC.

# 📧SMTP (Simple Mail Transfer Protocol)

	**Capa:** 7 (Aplicación) | **Puerto:** 25 (Texto plano), 465 (SSL/TLS), 587 (Moderno/Cifrado).

## 1. ¿Qué es el SMTP?

Es el protocolo estándar para **enviar** correos electrónicos desde un cliente a un servidor de correo, o entre servidores de correo. 

## 2. Comandos "Raw" del Protocolo (El lenguaje del servidor)

Al igual que con el FTP, el SMTP usa comandos de texto plano muy específicos:

* `HELO / EHLO`: El saludo inicial. El cliente se presenta al servidor.
* `MAIL FROM`: Indica quién envía el correo (ej: `MAIL FROM:<hacker@evil.com>`).
* `RCPT TO`: (Recipient) Indica quién va a recibir el correo.
* `DATA`: Prepara al servidor para recibir el contenido real (Asunto, cuerpo del mensaje).
* `QUIT`: Cierra la conexión.
## 3. El proceso de envío (Paso a paso)

1. El cliente se conecta al puerto 25 del servidor.
2. Se intercambian los comandos `HELO`, `MAIL FROM` y `RCPT TO`.
3. El cliente envía el comando `DATA`.
4. El cliente escribe el mensaje y termina con un **punto solo en una línea** (`.`) para decirle al servidor "he terminado".
5. El servidor acepta el correo y lo pone en la cola para enviarlo al servidor del destinatario.

## 4. Vulnerabilidad: Email Spoofing 🎭

- Como el SMTP básico no requiere autenticación obligatoria para los comandos `MAIL FROM`, un atacante puede conectar por `telnet` al puerto 25 y escribir:
`MAIL FROM:<ceo@tuempresa.com>`
- Si el servidor no tiene protecciones modernas (como SPF o DKIM), el destinatario recibirá un correo que parece totalmente legítimo del jefe.

### 🎭 Email Spoofing (Suplantación)

	El protocolo SMTP (Puerto 25) es **inherentemente inseguro** porque separa la identidad del sobre (envelope) de la identidad del mensaje.

* **Cómo ocurre:** El atacante se conecta por Telnet al servidor de correo de la víctima y usa el comando `MAIL FROM:<identidad_falsa@dominio.com>`.
* **Por qué funciona:** El protocolo original no obliga a verificar que el emisor realmente posee ese dominio.
* **Defensas Modernas:**
    * **SPF:** Lista de IPs autorizadas para enviar correos de un dominio.
    * **DKIM:** Firma criptográfica para asegurar que el mensaje no ha sido alterado.
    * **DMARC:** Política que decide qué hacer con correos que fallan SPF/DKIM.

## 5. SMTP vs POP3/IMAP

* **SMTP:** Solo para SALIDA (Enviar).
* **POP3 / IMAP:** Solo para ENTRADA (Recuperar y leer los correos del servidor).

# 📥 Task 6: POP3 (Post Office Protocol v3)

	**Capa:** 7 (Aplicación) | **Puertos:** 110 (Texto plano) y 995 (Cifrado/SSL).

## 1. ¿Qué es el POP3?

- Es un protocolo unidireccional diseñado para **descargar** correos electrónicos desde un servidor remoto a un cliente local (Outlook, Thunderbird, móvil). 
## 2. Filosofía de Funcionamiento (Download & Delete)

- A diferencia de los protocolos modernos, el POP3 funciona como un buzón de correos real:
1. El cliente se conecta al servidor.
2. Descarga todos los mensajes nuevos al dispositivo.
3. **Borra** los mensajes del servidor original.
4. Se desconecta.
## 3. Comandos "Raw" del Protocolo

- Si te conectas por `telnet` o `nc` al puerto 110, estos son los comandos que usarías:
* `USER`: Identifica al usuario.
* `PASS`: Envía la contraseña.
* `STAT`: Muestra el número de mensajes y el tamaño total del buzón.
* `LIST`: Lista los mensajes disponibles con su número de ID.
* `RETR [n]`: (Retrieve) Descarga el mensaje número *n*.
* `DELE [n]`: Marca el mensaje *n* para ser borrado al cerrar la sesión.
* `QUIT`: Confirma los cambios (borra los marcados) y cierra la conexión.

## 4. Ventajas y Desventajas

* **Ventaja:** No necesitas estar conectado a internet para leer tus correos una vez descargados. No ocupas espacio en el servidor de la empresa.
* **Desventaja:** **Cero sincronización.** Si descargas un correo en tu PC, no lo verás en tu móvil porque ya no existe en el servidor. Si tu PC explota, pierdes tus correos.
## 5. Seguridad ⚠️

- Al igual que SMTP y FTP, el POP3 básico (puerto 110) envía el **USER** y el **PASS** en **texto plano**. Cualquiera que esté escuchando en la misma red WiFi puede robarte la cuenta de correo fácilmente.

# 📬 Task 7: IMAP (Internet Message Access Protocol)

	**Capa:** 7 (Aplicación) | **Puertos:** 143 (Texto plano) y 993 (Cifrado/SSL).

## 1. ¿Qué es el IMAP?

- Es el protocolo de recepción de correo moderno. A diferencia de POP3, IMAP está diseñado para la **Sincronización**.
## 2. Filosofía: El servidor es la "Verdad"

- En IMAP, los correos **no se descargan y borran**. Se quedan en el servidor y tú los "miras" desde tu dispositivo.
* **Multidispositivo:** Si lees un correo en el móvil, aparece como "leído" en el PC. 
* **Carpetas:** Puedes crear carpetas en el servidor y verlas en todos lados.
## 3. Comandos "Raw" (Son más complejos que POP3)

- IMAP usa "etiquetas" (letras o números) antes de cada comando para rastrear la conversación:
* **A1 `LOGIN` usuario password:** Para entrar.
* **A2 `LIST` "" "*":** Lista todas las carpetas (Inbox, Sent, etc.).
* **A3 `SELECT INBOX`:** Entra en la bandeja de entrada.
* **A4 `FETCH 1 BODY[TEXT]`:** Descarga solo el cuerpo del mensaje número 1.
* **A5 `LOGOUT`:** Cierra sesión.
## 4. Comparativa Final: POP3 vs IMAP

| Característica        | POP3                              | IMAP                        |
| :-------------------- | :-------------------------------- | :-------------------------- |
| **Ubicación correos** | Local (Tu PC)                     | Servidor                    |
| **Sincronización**    | No existe                         | Total                       |
| **Velocidad**         | Rápido al leer (ya está en tu PC) | Necesita internet para leer |
| **Espacio**           | Ahorra espacio en servidor        | Consume espacio en servidor |

# Resumen y Tabla

## 🎯 Tabla Maestra: Protocolos y Puertos Core

Esta tabla resume los protocolos fundamentales vistos en el módulo de Core Protocols. Memorizar estos puertos es vital para identificar servicios durante la fase de enumeración.

| Protocolo  | Transporte | Puerto  | Descripción / Uso Principal                              |
| :--------- | :--------- | :------ | :------------------------------------------------------- |
| **TELNET** | TCP        | **23**  | Administración remota (Inseguro, texto plano).           |
| **DNS**    | UDP / TCP  | **53**  | Resolución de nombres (Nombres <-> IPs).                 |
| **HTTP**   | TCP        | **80**  | Navegación web estándar (Inseguro).                      |
| **HTTPS**  | TCP        | **443** | Navegación web segura (Cifrado con TLS/SSL).             |
| **FTP**    | TCP        | **21**  | Transferencia de archivos (Control). Datos en puerto 20. |
| **SMTP**   | TCP        | **25**  | Envío de correos electrónicos.                           |
| **POP3**   | TCP        | **110** | Recepción de correos (Descarga y borra del servidor).    |
| **IMAP**   | TCP        | **143** | Recepción de correos (Sincronización con el servidor).   |

---

## 🛡️ Notas de Seguridad

* **Puertos de Correo Seguros:** * **SMTPS:** 465 / 587
    * **POP3S:** 995
    * **IMAPS:** 993
* **DNS:** Usa **UDP** para consultas normales (más rápido) y **TCP** para transferencias de zona (grandes cantidades de datos).
* **FTP:** Recuerda que aunque el puerto de escucha sea el 21, la transferencia real de datos ocurre por el puerto 20 (Modo Activo).