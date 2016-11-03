/* ------------------------------------------------------------*/
/*           CONTROL 4 SERVOMOTORES CON 4 JOYSTICK             */
/* ------------------------------------------------------------*/
/* ------------------------------------------------------------*/
/* Autor: Iker Burguera                                        */
/* Email: ikerburguera@gmail.com                               */
/* Fecha: 08/04/13
/* ------------------------------------------------------------*/

#include <Servo.h>  
   
Servo servo1,servo2,servo3,servo4;                                                              // Crea un Objeto servo1,servo2,servo3,servo4  
int posXservo1,posYservo1,posXservo2,posYservo2,posXservo3,posYservo3,posXservo4,posYservo4;    // Variables X e Y de la posicion de los servos  
   
void setup()  
{  
  servo1.attach(2);  // Selecionamos el pin 2 como el pin de control para el servo1.Salidas PWM  
  servo1.attach(3);  // Selecionamos el pin 3 como el pin de control para el servo2.Salidas PWM 
  servo1.attach(4);  // Selecionamos el pin 4 como el pin de control para el servo3.Salidas PWM  
  servo1.attach(5);  // Selecionamos el pin 5 como el pin de control para el servo4.Salidas PWM 
}  
   
void loop()  
{  
  
  leerPosicionJoysticks();                   // Aunque leamos los dos valores, en este ejemplo solo vamos a utilizar el valor X para mapear el valor entre 0-180º del servo
  
  servo1.write(posXservo1);                  // Escribimos el valor leido X en el servo1.   
  servo2.write(posXservo2);                  // Escribimos el valor leido X en el servo1. 
  servo3.write(posXservo3);                  // Escribimos el valor leido X en el servo1. 
  servo4.write(posXservo4);                  // Escribimos el valor leido X en el servo1. 
  
  delay(150);                           // Y le damos un tiempo para que sea capaz de moverse  
} 

void leerPosicionJoysticks ()
{
  posXservo1  =  map(analogRead(0), 0, 1023, 0, 179);     // Establecemos la relacion entre los grados de giro y el PWM; Mapeamos el valor analogico comprendido entre 0-1023 a valor de 0-180 para simular los grados     
  posYservo1  =  map(analogRead(1), 0, 1023, 0, 179);     // Establecemos la relacion entre los grados de giro y el PWM;  
  
  posXservo2  =  map(analogRead(2), 0, 1023, 0, 179);     // Establecemos la relacion entre los grados de giro y el PWM;  Mapeamos el valor analogico comprendido entre 0-1023 a valor de 0-180 para simular los grados 
  posYservo2  =  map(analogRead(3), 0, 1023, 0, 179);     // Establecemos la relacion entre los grados de giro y el PWM;  
  
  posXservo3  =  map(analogRead(8), 0, 1023, 0, 179);     // Establecemos la relacion entre los grados de giro y el PWM; Mapeamos el valor analogico comprendido entre 0-1023 a valor de 0-180 para simular los grados  
  posYservo3  =  map(analogRead(9), 0, 1023, 0, 179);     // Establecemos la relacion entre los grados de giro y el PWM;  
  
  posXservo4  =  map(analogRead(10), 0, 1023, 0, 179);     // Establecemos la relacion entre los grados de giro y el PWM; Mapeamos el valor analogico comprendido entre 0-1023 a valor de 0-180 para simular los grados  
  posYservo4  =  map(analogRead(11), 0, 1023, 0, 179);     // Establecemos la relacion entre los grados de giro y el PWM;  
}
