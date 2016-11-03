/*--------------------------------------------------------------------*/
/*--                 LCD 2x16 + Ultrasonic Ping Sensor              --*/
/*--------------------------------------------------------------------*/

/*--------------------------------------------------------------------*/
/*--  Proyecto:   Proyecto LED - Encender/Apagar                    --*/
/*--  Autor   :   Iker Burguera                                     --*/
/*--  Email   :   ikerburguera@gmail.com                            --*/
/*--  Date    :   28/07/2013                                        --*/
/*--  Version :   1.0                                               --*/
/*--                                                                --*/
/*--  Description: El proyecto muestra la distancia obtenida desde  --*/
/*--  un sensor de ultrasonidos en un LCD 2x16. El sensor emite un  --*/            
/*--  pulso y mide el tiempo en recibirlo. Calcula el tiempo y lo   --*/ 
/*--  convierte en distancia (340m/s velocidad del sonido en aire)  --*/
/*--------------------------------------------------------------------*/


/* CONEXIONES 
     
   Sensor Ultrasonido:
	*  +V connection of the PING))) -> Arduino +5V
	* GND connection of the PING))) -> Arduino GND
	* SIG connection of the PING))) -> Arduino Digital pin 7
   
   Display LCD:
	* VDD connection of the LCD))) -> Arduino +5V
	* GND connection of the LCD))) -> Arduino GND
	*  RX connection of the LCD))) -> Arduino Digital pin 2
 
 */

#include <SoftwareSerial.h>                                                               // Importamos libreria SoftwareSerial.h

#define txPin     2                                                                       // Definimos el Pin 2 de Arduino para enviar datos al LCD
#define pingPing  7                                                                       // Definismo el Pin 7 de Arduino para recibir datos del sensor Ultrasonido

SoftwareSerial LCD = SoftwareSerial(0, txPin);                                            // Creamos el objeto LCD para comunicarnos con el LCD. Le indicamos que será el PIn 2 de Arduino el emisor de los datos

const int LCDdelay=10;                                                                    // Definimos un pequeño delay para el LCD

long duration,cm;                                                                         // Creamos las variables duration y cm. Duration almacenara el tiempo transcurrido entre el envio y recepcion del pulso ultrasonico. La variable cm alamcenara la distancia en cm del pulso emitido una vez transformado. 


void setup() 
{
  Serial.begin(9600);                                                                     // Inicializamos la comunicacion serial a 9600 baudios
  pinMode(txPin, OUTPUT);                                                                 // Indicamos que el Pin 2 de Arduino, txPin, sera de salida. Lo utilizaremos para enviar datos al LCD
  LCD.begin(9600);                                                                        // Inicializamos la comunicacioens serial con el LCD a 9600 baudios 
  
  clearLCD();                                                                             // Limpiamos el LCD                                                                           
  lcdPosition(0,0);                                                                       // Establecemos posicion del cursor en el display
  backlightOn();                                                                          // Establecemos la luminosidad del display
}

void loop()
{                                                                                         // Creamos un pulso 

    pinMode(pingPin, OUTPUT);                                                             // Ponemos el pin 7 como SALIDA para emitir el pulso
    digitalWrite(pingPin, LOW);
    delayMicroseconds(2);
    digitalWrite(pingPin, HIGH);                                                          // Generamos el pulso poniendo la salida en HIGH durante un tiempo determinado
    delayMicroseconds(5);
    digitalWrite(pingPin, LOW);                                                           // Volvemos a bajar el pin

    pinMode(pingPin, INPUT);                                                              // Ponemos el pin 7 como ENTRADA para recibir el pulso emitido
    
    duration = pulseIn(pingPin, HIGH);                                                    // Recibimos el pulso en el pin 7 y calculamos el tiempo en el que el pin 7 esta en modo HIGH. Solamente permanecera en HIGH el tiempo del pulso emitido y rebotado.

    cm = microsecondsToCentimeters(duration);                                             // Convertimos el tiempo transcurrido en envio y recepcion y lo pasamos a centimetros.
  
    mostrarResultadoDisplay(cm);                                                          // Mostramos resultado en Serial y el en LCD
}

void mostrarResultadoDisplay(long cm)
{
    Serial.print(cm);                                                                     // Mostramos el resultado en Serial
    Serial.print("cm");
    Serial.println();
  
  
    lcdPosition(0,0);                                                                     // Mostramos el resultado en LCD
    LCD.print("SENSOR DISTANCIA");

  
    lcdPosition(1,6); 
    LCD.print(cm+1);
    lcdPosition(1,9); 
    LCD.print("cm");
  
  
    delay(800);
    lcdPosition(1,6); 
    LCD.print("   ");
  //clearLCD();   
}

long microsecondsToCentimeters(long microseconds)                                         // Funcion para convertir el tiempo en distancia
{
    return microseconds / 29 / 2;                                                         // Velocidad del sonido 340m/s o 29 microsegundos por cm. Dividimos el resultado entre 2 porque el pulso tiene el recorrido de ida y vuelta                                                                               
}

void lcdPosition(int row, int col)                                                        // Funcion para establecer las posicion del curso en el LCD 
{
  LCD.write(0xFE);                                                                        // Enviamos el comando 0x73 para dar ordenes al LCD
  LCD.write((col + row*64 + 128));                                                        // Escribimos en posicion LCD segun linea y columna recibida 
  delay(LCDdelay);                                                                        // Metemos un delay para no saturar el micro del LCD
}

void clearLCD()                                                                          //Limpiamos el LCD
{
  LCD.write(0xFE);                                                                       // Enviamos el comando 0x73 para dar ordenes al LCD
  LCD.write(0x01);                                                                       // Escribimos comando para limpiar la pantalla
  delay(LCDdelay);                                                                       // Metemos un delay para no saturar el micro del LCD
}

void backlightOn()                                                                       // Ponemos el display a tope de brillo
{  
  LCD.write(0x7C);                                                                       // Enviamos el comando 0x7C para dar ordenes al LCD de poner el Brillo en el LCD
  LCD.write(157);                                                                        // Nivel de luminosidad maxima 157
  delay(LCDdelay);                                                                       // Metemos un delay para no saturar el micro del LCD
}

void backlightOff()                                                                      // Ponemos el display a tope de brillo
{  
  LCD.write(0x7C);                                                                       // Enviamos el comando 0x7C para dar ordenes al LCD de poner el Brillo en el LCD            
  LCD.write(128);                                                                        // Nivel de luminosidad maxima 128
  delay(LCDdelay);                                                                       // Metemos un delay para no saturar el micro del LCD
}

void serCommand()                                                                        // Una funcion general para enviar al LCD y ejecutar otros comandos disponibles. 
{   
  LCD.write(0xFE);                                                                       // Datasheet: http://fab.cba.mit.edu/classes/863.11/people/joseph.morrow/SerLCD_V2_5.pdf
}
