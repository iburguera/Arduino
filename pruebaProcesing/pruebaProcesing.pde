
 void setup() 
 {
  Serial.begin(9600);                    // Start serial communication at 9600 bps
 }

void loop() 
{

    Serial.print(1, BYTE);               // send 1 to Processing
    delay(1000);                               // If the switch is not ON,
    Serial.print(0, BYTE);               // send 0 to Processing
    delay(1000);                            // Wait 100 milliseconds
}
 
