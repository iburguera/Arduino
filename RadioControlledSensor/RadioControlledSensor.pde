

int    radioPin = 3 ; // LED conectado al pin 
float  valor;

void setup() 
{
  Serial.begin(9600);
  pinMode(radioPin, INPUT);      // Puerto 5 de lectura analogica
}

void loop() 
{
  valorTemp = analogRead(radioPin);
  Serial.print("Valor recibido : ");
  Serial.println(valorTemp);
  delay(1000);                  
 } 
