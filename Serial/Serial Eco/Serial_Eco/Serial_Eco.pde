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
     Serial.println("Has introducido el valor: ");
     Serial.println("aukera");
   } 
 }
 
/0 
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
 

 
 
