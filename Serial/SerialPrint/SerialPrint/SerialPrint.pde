/*
  
 
 */
 
 void setup() 
 {
  Serial.begin(9600); 
 }
 
 void loop()
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
   delay(10000);
 }
 
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
