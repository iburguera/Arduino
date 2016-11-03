 /*
    Programa que lee el valor de un potenciometro.
    Potenciometro 10K en paralelo con una resistencia de 1K2
 */
 
 
 /*---------  VARIABLES --------*/
   
     int IntPot=5;                // Puerto/Interfaz donde conectaremos el arduino
     int valorPot=0;              // Valor  del potenciometro
     
 /*-----------------------------*/
 
 
 void setup() 
 {
  Serial.begin(9600); 
 }
 
 void loop()
 {
   valorPot = analogRead(IntPot);
   //Serial.println("Valor Potenciometro: ");
   Serial.println(valorPot);
   delay(55);
 }
 

