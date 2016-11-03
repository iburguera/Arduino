
 void setup() 
 {
  Serial.begin(9600);                    // Start serial communication at 9600 bps
 }

void loop() 
{
    Serial.print(1, BYTE);              
    delay(1000);                        
    Serial.print(2, BYTE);              
    delay(1000);
    Serial.print(3, BYTE);              
    delay(1000);
    Serial.print(4, BYTE);              
    delay(1000);
    Serial.print(5, BYTE);              
    delay(1000);
    Serial.print(6, BYTE);              
    delay(1000);
    Serial.print(7, BYTE);              
    delay(1000);
    Serial.print(8, BYTE);              
    delay(1000);
    Serial.print(9, BYTE);              
    delay(1000);
    Serial.print(10, BYTE);              
    delay(1000);
}
 
