

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

int ledPin = 13; // LED conectado al pin 13

void setup() {

  pinMode(ledPin, OUTPUT);      
  // asigna el pin digital pin como output (salida)

}

void loop() {

  digitalWrite(ledPin, HIGH);   // enciende el LED (on)
  delay(1000);                  // espera por un segundo
  digitalWrite(ledPin, LOW);    // apaga el LED (off)
  delay(1000);                  // espera por un segundo

} 
