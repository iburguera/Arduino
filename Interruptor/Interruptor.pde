 
 
 
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
             Serial.println("ENCENDIDO");
             delay(1000); 
        }
        else
        {
             Serial.println("APAGADO");
             delay(1000); 
        }
}

