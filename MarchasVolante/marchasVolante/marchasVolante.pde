 
 
 
int inPinUP    = 4;      // PIN para SUBIR Marchas
int inPinDOWN  = 2;      // PIN para BAJAR Marchas
int marcha     = 5;      // Valor de la marcha



void setup()
{
    Serial.begin(9600);    
    pinMode(inPinUP, INPUT); // declare switch as input
    pinMode(inPinDOWN, INPUT); // declare switch as input
}
void loop()
{
  
        if (digitalRead(inPinUP) == HIGH) 
        {
             marcha = marcha+1; 
             Serial.print("MARCHA : ");
             Serial.print(marcha);
             Serial.println("");
             delay(350);
        }
        if (digitalRead(inPinDOWN) == HIGH) 
        {
             marcha = marcha-1; 
             Serial.print("MARCHA : ");
             Serial.print(marcha);
             Serial.println("");
             delay(350);
        }
}


