/* -------------------------------------------------- */
/* Programa ejemplo para Fer Zizzias Rotación Cámara. */
/* -------------------------------------------------- */

/* -------------------------------------------------- */
/*            Servomotor: GWS S125 1T
/* -------------------------------------------------- */

/* -------------------------------------------------- */
/*      Posiciones: 0º - 90º - 180º - 270º */
/* -------------------------------------------------- */

/* El cliente necesita un aparato que le permita rotar la cámara en 4 posiciones: 0º - 90º - 180º - 270º
/* Para ello vamos a utilizar un servomotor para programar las posiciones y luego le acoplaremos la 

/* Cuando escribes myservo.write(0); myservo.write(90); myservo.write(180); myservo.write(270) va a las posiciones correspodientes de 0,90,180,270.

/* Pero en este servo esa opción no ha servido por lo que hemos optado por ponerlo a mano los valores:
/*
    0º  - 23
   90º  - 47  
  180º  - 72
  270º  - 98
*/

#include <Servo.h> 

Servo myservo;                  // Creamos el objeto para el servomotor

int pos_0       =   24;         // Variable para guardar la posición 0º. En este caso   0º corresponde al valor 23
int pos_90      =   49;         // Variable para guardar la posición 0º. En este caso  00º corresponde al valor 47
int pos_180     =   74;         // Variable para guardar la posición 0º. En este caso 180º corresponde al valor 72
int pos_270     =   100;         // Variable para guardar la posición 0º. En este caso 270º corresponde al valor 98

int delay_Foto  =   3000;       // Variable para guardar el valor entre foto y foto
void setup() 
{ 
  myservo.attach(9);            // Agregamos el PIN  9 como salida PWM para la señal del servomotor 
} 


void loop() 
{
 
  myservo.write(pos_0);         // Le indicamos al servomotor que debe ir a la posicion   0º 
  delay(delay_Foto);            // Esperamos un tiempo para sacar la siguiente foto 
  
  myservo.write(pos_90);        // Le indicamos al servomotor que debe ir a la posicion  90º 
  delay(delay_Foto);            // Esperamos un tiempo para sacar la siguiente foto
  
  myservo.write(pos_180);       // Le indicamos al servomotor que debe ir a la posicion 180º 
  delay(delay_Foto);            // Esperamos un tiempo para sacar la siguiente foto
  
   myservo.write(pos_270);      // Le indicamos al servomotor que debe ir a la posicion 270º 
  delay(delay_Foto);            // Esperamos un tiempo para sacar la siguiente foto

}
