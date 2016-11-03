/*---------------------------------------*/
/*--        LIGHT LDR SENSOR I         --*/
/*---------------------------------------*/

/*---------------------------------------*/
/*-- Autor  : Iker Burguera Hidalgo    --*/
/*-- Date   : 16/06/2012               --*/
/*-- E-mail : ikerburguera@gmail.com   --*/
/*-- Version: 1.0                      --*/
/*-- Descrip: Measures the imcoming    --*/
/*--          light from the 2 LDR     --*/
/*---------------------------------------*/  


/*---------------------------------------*/
/*--             VARIABLES             --*/
/*---------------------------------------*/ 

int sensorLDR1     =  1;                      // Analog port 1 = LDR light sensor input
int sensorLDR2     =  2;                      // Analog port 1 = LDR light sensor input

int valSensorLDR1  =  0;                      // Initialization for distance value
int valSensorLDR2  =  0;                      // Initialization for distance value


/*--------------------------------------*/
/*--               SETUP              --*/
/*--------------------------------------*/ 

void setup ()
{
  Serial.begin(9600);
  pinMode(sensorLDR1,INPUT);
  pinMode(sensorLDR2,INPUT);
}

/*--------------------------------------*/
/*--               LOOP               --*/
/*--------------------------------------*/


void loop ()
{
   valSensorLDR1  =  analogRead(sensorLDR1);               // Read analog value from the distance sensor
   valSensorLDR1  =  map(valSensorLDR1,0,1024,0,255);      // Map obtained value to 8 bit:  1024 (2^10) -> 255(2^8)
   
   valSensorLDR2  =  analogRead(sensorLDR2);               // Read analog value from the distance sensor
   valSensorLDR2  =  map(valSensorLDR2,0,1024,0,255);      // Map obtained value to 8 bit:  1024 (2^10) -> 255(2^8)
   
   //Serial.print("Valor sensor :  ");                     // Check values in the terminal prompt
   //Serial.print("(");                     
   //Serial.print(valSensorLDR1); 
   //Serial.print(",");                     
   //Serial.print(valSensorLDR2); 
   //Serial.println(")");                     
     
  
           
   Serial.print(valSensorLDR1);                          // CSV format "," separated by ":" ->  212,132:    where 212= value LDR  1 and 132= value LDR 2 
   Serial.print(",");                     
   Serial.print(valSensorLDR2); 
   Serial.print(":");                  
   
   
   delay(1000);
}


