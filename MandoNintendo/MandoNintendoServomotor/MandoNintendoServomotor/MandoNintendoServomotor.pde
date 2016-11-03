/* ------------------------------------------------------------*/
/*              CONTROL SERVOMOTOR MANDO CONSOLA               */
/* ------------------------------------------------------------*/

/* ------------------------------------------------------------*/
/* Descripcion: Arduino recoge los valores analógicos que le   */
/* proporciona el mando de la videoconsola. Cada tecla del     */
/* control emite un valor analógico comprendido en un rango,   */
/* basando en esa propiedad se pueden interpretar y realizar   */
/* las acciones.                                               */
/* ------------------------------------------------------------*/

/* ------------------------------------------------------------*/
/* Autor: Iker Burguera                                        */
/* Email: ikerburguera@gmail.com                               */
/* Fecha: 12/06/10
/* ------------------------------------------------------------*/



#include <Servo.h> 


int    nintendoPin = 3 ; // LED conectado al pin analogico 3
int    valor;
Servo myservo;          // Creamos un objeto que haga referencia al servomotor
                        
int pos = 90;            // variable para posicionar el servomotor

void setup() 
{
  Serial.begin(9600);
  pinMode(nintendoPin, INPUT);      // Puerto 5 de lectura analogica
  myservo.attach(9);                // Conectamos el servomotor a la entrada numero 9 digital
}

void loop() 
{
    valor = analogRead(nintendoPin);
    
    if((valor>475) and (valor<500))                // Boton A
    {
      Serial.print("TECLA : A  ");
      Serial.print("Valor recibido : ");           // Imprimimos el valor analogico recibido
      Serial.println(valor);
      pos =90;                                     // Devuelve el servo a la posicion inicial
      myservo.write(pos);  
    }
    if((valor>450) and (valor<470))                // Boton B
    {
      Serial.print("TECLA : B  ");
      Serial.print("Valor recibido : ");
      Serial.println(valor);
      pos =90; 
      myservo.write(pos);
    }
    if((valor>400) and (valor<440))                // ARRIBA
    {
      Serial.print("TECLA : ARRIBA  ");
      Serial.print("Valor recibido : ");
      Serial.println(valor);
    }
     if((valor>355) and (valor<399))               // ABAJO
    {
      Serial.print("TECLA : ABAJO  ");
      Serial.print("Valor recibido : ");
      Serial.println(valor);
    }
     if((valor>500) and (valor<600))               // IZQUIERDA
    {
      Serial.print("TECLA : IZQUIERDA  ");
      Serial.print("Valor recibido : ");
      Serial.println(valor);
      pos = pos+2;                                 // Movemos el servo varias posiciones a la izquierda
      myservo.write(pos);
    }
     if((valor>300) and (valor<350))               // DERECHA
    {
      Serial.print("TECLA : DERECHA  ");
      Serial.print("Valor recibido : ");
      Serial.println(valor);
      pos = pos-2;                                 // Movemos el servo varias posiciones a la derecha
      myservo.write(pos);
    }
    
    //Serial.print("Valor recibido : ");
    delay(50);                  
} 
