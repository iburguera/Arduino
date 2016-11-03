
/*---------------------------------------*/
/*--      PROYECTO RECICLAJE II        --*/
/*---------------------------------------*/
/*--                                   --*/
/*--     RECLYCING FALLING BOMB        --*/
/*--                                   --*/
/*---------------------------------------*/  

/*---------------------------------------*/
/*-- Autor  : Iker Burguera Hidalgo    --*/
/*-- Date   : 15/06/2012               --*/
/*-- E-mail : ikerburguera@gmail.com   --*/
/*-- Version: 1.0                      --*/
/*-- Descrip: Plays falling bomb sound --*/
/*--          when the distance sensor --*/
/*--          activates.               --*/
/*---------------------------------------*/  


/*---------------------------------------*/
/*--             VARIABLES             --*/
/*---------------------------------------*/ 

int sensorMov1     =  1;                      // Analog port 1 = Distance sensor input
int valSensorMov1  =  0;                      // Initialization for distance value
int ledSensorPin   = 13;                      // Led sensor Pin


/*--------------------------------------*/
/*--               SETUP              --*/
/*--------------------------------------*/ 

void setup ()
{
  Serial.begin(9600);
  pinMode(sensorMov1,INPUT);
  pinMode(ledSensorPin,OUTPUT);
}

/*--------------------------------------*/
/*--               LOOP               --*/
/*--------------------------------------*/


void loop ()
{
   valSensorMov1  =  analogRead(sensorMov1);               // Read analog value from the distance sensor
   valSensorMov1  =  map(valSensorMov1,0,1024,0,255);      // Map obtained value to 8 bit:  1024 (2^10) -> 255(2^8)
   
   Serial.print("Valor sensor :");
   Serial.println(valSensorMov1); 
   
   if(valSensorMov1<=100)                                  // Check wether the condition is satisfied
   {
      Serial.println("PELIGROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
      digitalWrite(ledSensorPin, HIGH);
      delay(2000);      
   }
   
   delay(200);
}

