/*
  Programa que leer un caracter de la linea serie y lo escribe por la linea serie
 
  Iker Burguera
  12/06/2010 14:32
 
 */
 
 void setup() 
 {
  Serial.begin(9600); 
 }

 void loop()
 {
   char aukera = Serial.read();
   delay(20);
   if(aukera!=-1)
   {
      if(aukera=0)
      {
        Serial.println("-----------------------------------------------");
        Serial.println("-----------     A R D U I N O     -------------");
        Serial.println("-----------------------------------------------");
        Serial.println("----            Iker Burguera              ----");
        Serial.println("---               09/09/86                  ---");
        Serial.println("--        iker_burguera@hotmail.com          --");
        Serial.println("-----------------------------------------------");
        delay(1000);
        esperando();
        Serial.println("--------     PROCESO COMPLETADO    ------------");
      }
      if(aukera=1)
      {
        Serial.println("Has introducido el numero 1");
      }
     Serial.println(aukera);
   } 
 }
 
/*-----------------  FUNCIONES  ---------------*/

 void esperando ()
 {
    for(int i=0; i<=93; i++)
   {
     imprimir();
     i++;
   }
   Serial.println("");
 }
 
 
 void imprimir ()
 {
   Serial.print(".");
   delay(500);
 }
 

 
 
