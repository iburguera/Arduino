
int value;

 void setup() 
 {
  Serial.begin(9600);                    // Start serial communication at 9600 bps
 }

void loop() 
{
    value=random(1,10);
    Serial.print(value, BYTE);              
    delay(1000);                        
}
 
