/*
  Programa que imprime la tabla ASCII en el puerto serie
 
  Iker Burguera
  12/06/2010 14:51
 
 */
 
 void setup() 
 {
  Serial.begin(9600); 
 }

 void loop()
 {
       char caracter;
       
       for(caracter=0; caracter<=255;caracter++)
       {
         Serial.print(caracter);
         Serial.print(",");
         delay(200);
       }
 }
 

