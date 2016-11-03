
/*
 
   SENSOR DE PROXIMIDAD SHARP GP2Y0A21YK

*/

#define SENSOR1 1
#define SENSOR2 2

int sensorVal1 =  0;
int sensorVal2 =  0;

void setup()
{
  Serial.begin(115200);
  pinMode(SENSOR1, INPUT);
  pinMode(SENSOR2, INPUT);
}

void loop()
{
  /*
  sensorVal1  =  analogRead(SENSOR1);
  sensorVal2  =  analogRead(SENSOR2); 
  
  Serial.print("Sensor 1: "+sensorVal1);
  Serial.print("\t");
  Serial.print("Sensor 2: "+sensorVal2);
  Serial.println();
  */
  
  Serial.print(analogRead(SENSOR1));
  Serial.print(",");
  Serial.print(analogRead(SENSOR2));
  Serial.println();
  
  delay(100);
}
