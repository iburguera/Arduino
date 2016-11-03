 /*
    Programa que lee el valor de un potenciometro.
    Potenciometro 10K en paralelo con una resistencia de 1K2
 */
 
 
 /*---------  VARIABLES --------*/
   
     int X_Joystick_Port  = 4;                 // Puerto/Interfaz X donde conectaremos el arduino
     int Y_Joystick_Port  = 5;                 // Puerto/Interfaz Y donde conectaremos el arduino
     int X_Joystick_value = 0;                // Valor X del potenciometro del Joystick PS2 
     int Y_Joystick_value = 0;                // Valor Y del potenciometro del Joystick PS2
     
     
 /*-----------------------------*/
 
 
 void setup() 
 {
  Serial.begin(9600); 
 }
 
 void loop()
 {
   X_Joystick_value = analogRead(X_Joystick_Port);
   Y_Joystick_value = analogRead(Y_Joystick_Port);
   
   Serial.print(" (X,Y): (");
   Serial.println(XJoystick_Value);
   Serial.println(",");
   Serial.println(YJoystick_Value);
   Serial.println(")");
   delay(10);
 }
 

