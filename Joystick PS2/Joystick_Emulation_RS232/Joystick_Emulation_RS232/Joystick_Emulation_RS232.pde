
 /*---------  VARIABLES --------*/
   
     float valorPot=0;              // Valor  del potenciometro
     
 /*-----------------------------*/
 
 
 void setup() 
 {
  Serial.begin(9600); 
 }
 
 void loop()
 {
   Serial.println(valorPot);
   if(valorPot<=100)
   {
      valorPot= valorPot+0.1;
   }
   else
   {
      valorPot= 0;
   }
   delay(25);
 }
 

