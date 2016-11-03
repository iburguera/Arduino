 
int inPin = 2; // input pin (for a switch)

void setup()
{
    Serial.begin(9600);    
    pinMode(inPin, INPUT); // declare switch as input
}
void loop()
{
        if (digitalRead(inPin) == HIGH) 
        {
             Serial.print(1, BYTE);              // PALANTE
             delay(350); 
        }
        else
        {
             Serial.println(2, BYTE);            // PATRAS
             delay(350); 
        }
}

