#include <SoftwareSerial.h>


#define rxPin 2
#define txPin 3

byte incomingByte = 0;

SoftwareSerial rfSerial = SoftwareSerial(rxPin, txPin);

void setup() 
{
     pinMode(rxPin, INPUT);
     rfSerial.begin(2400);
     Serial.begin(9600);
}

void loop() 
{
     incomingByte = rfSerial.read();
     Serial.print("Valor recibido : ");
     Serial.println(incomingByte, DEC);
     incomingByte = 0;
     delay(300);
}


