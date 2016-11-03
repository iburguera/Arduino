/* LED PARPADEANTE

 * ---------------
 *
 * Enciende y Apaga un LED (Diodo Emisor de Luz) conectado a un pin 
 * digital en intervalos de 2 segundos. Usamos el pin 13 de la placa
 * Arduino ya que este usa una resistencia que nos permite conectar
 * un LED directamente.
 *
 * Creado Junio, 1 2005
 * copyleft 2005 DojoDave <http://www.0j0.org>
 * http://arduino.berlios.de
 *
 * basado en un orginal de H. Barragan para la placa Wiring i/o board
 */

char pos=0;

void setup() 
{
     Serial.begin(9600);
}

void loop() 
{
    Serial.println(pos);
    pos++:
    delay(200);  
} 
