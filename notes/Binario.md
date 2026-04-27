
# 🔢 SISTEMA BINARIO (OCTETOS)

## El Concepto de "Interruptor"

- En binario, solo existen dos estados. No hay números del 2 al 9, solo:
	- 1 = Encendido (Significa que SUMAS el valor de esa posición).
	- 0 = Apagado (Significa que NO sumas nada, vale cero).

## Los 8 Pesos del Octeto
 
 - Un octeto tiene 8 posiciones. Para saber cuánto vale cada una, empiezas por la derecha con el 1 y vas multiplicando por 2 hacia la izquierda:
	- 8ª posición (izquierda): 128
	- 7ª posición: 64
	- 6ª posición: 32
	- 5ª posición: 16
	- 4ª posición: 8
	- 3ª posición: 4
	- 2ª posición: 2
	- 1ª posición (derecha): 1

## De Binario a Decimal (Traducir a humano)

- Escribe el número binario y suma los valores fijos de arriba donde haya un 1.
	- Ejemplo: 10100000
	- Tienes un 1 en la posición del 128 y un 1 en la del 32.
	- Operación: 128 + 32 = 160.

## De Decimal a Binario (Traducir a máquina)

- Vas restando los pesos de izquierda a derecha (del 128 al 1). Si cabe, pones un 1. Si no cabe, pones un 0.
	- Ejemplo: El número 168
		- ¿Cabe 128? SÍ. (Ponemos un 1). Sobran 40.
		- ¿Cabe 64? NO. (Ponemos un 0).
		- ¿Cabe 32? SÍ. (Ponemos un 1). Sobran 8.
		- ¿Cabe 16? NO. (Ponemos un 0).
		- ¿Cabe 8? SÍ. (Ponemos un 1). Sobra 0.
		- Relleno con 0 el resto.
    	
				- Resultado: 10101000
## El Límite: 255

- Todo apagado (00000000) = 0.
- Todo encendido (11111111) = 255. 

		- Por eso las IPs nunca pasan de 255.
		
### **IPv4**: Versión 4. (32 bits)

  - 4 grupos de 8 bits.
  
		Ejemplo: 192.168.1.1
### **IPv6**: Versión 6. (128 bits)

  - 8 grupos de 16 bits.
  
		Ejemplo: 2001:0db8:85a3:0000:0000:8a2e:0370:7334

IP: 192 . 168 . 1 . 15
    |     |     |    |
    |     |     |    +--- Octeto 4 (8 bits)
    |     |     +-------- Octeto 3 (8 bits)
    |     +-------------- Octeto 2 (8 bits)
    +-------------------- Octeto 1 (8 bits)

TOTAL: 4 Octetos x 8 bits = 32 bits.
# 🔠 HEXADECIMAL (IPv6)

- Se usa porque el decimal normal no llega para 128 bits.
	- Base 16: Números del 0 al 9 + Letras de la A a la F.
	- A=10, B=11, C=12, D=13, E=14, F=15.
	- Ventaja: 1 carácter hexadecimal resume 4 bits.
	- Separador: Se usan dos puntos (:) en lugar de puntos (.).
