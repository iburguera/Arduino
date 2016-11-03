/*---------------------------------------*/
/*--        LIGHT LDR SENSOR I         --*/
/*---------------------------------------*/

/*---------------------------------------*/
/*-- Autor  : Iker Burguera Hidalgo    --*/
/*-- Date   : 16/06/2012               --*/
/*-- E-mail : ikerburguera@gmail.com   --*/
/*-- Version: 1.0                      --*/
/*-- Descrip: Measures the imcoming    --*/
/*--          light from the outside.  --*/
/*---------------------------------------*/  


/*---------------------------------------*/
/*--             VARIABLES             --*/
/*---------------------------------------*/ 

int sensorLDR1     =  1;                      // Analog port 1 = LDR light sensor input
int valSensorLDR1  =  0;                      // Initialization for distance value


/*--------------------------------------*/
/*--               SETUP              --*/
/*--------------------------------------*/ 

void setup ()
{
  Serial.begin(9600);
  pinMode(sensorLDR1,INPUT);
}

/*--------------------------------------*/
/*--               LOOP               --*/
/*--------------------------------------*/


void loop ()
{
   valSensorLDR1  =  analogRead(sensorLDR1);               // Read analog value from the distance sensor
   valSensorLDR1  =  map(valSensorLDR1,0,1024,0,255);      // Map obtained value to 8 bit:  1024 (2^10) -> 255(2^8)
   
   //Serial.print("Valor sensor :  ");                     // Check values in the terminal prompt
   //Serial.println(valSensorLDR1); 
     
   Serial.print(valSensorLDR1);                            // CSV format
   Serial.print(",");
   
   delay(1000);
}


