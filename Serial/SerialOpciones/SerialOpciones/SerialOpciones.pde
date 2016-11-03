/*
  
 
 */
 
 void setup() 
 {
  Serial.begin(9600); 
  int aukera=0;
 }
 
 void loop()
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
        aukera=1; 
   }
   else
   {
        if(aukera=1)
        {
          aukera=Serial.read();
        }
        else
        {
           switch(aukera)
           
             case 2:      Serial.println("HOLA MUNDO");
                          delay(5000); 
                          break;
             case 3:      Serial.println("ADIOS MUNDO");
                          delay(5000); 
                          break;
        }
   }
   
   
   Serial.read
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
 
 
