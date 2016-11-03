
int    nintendoPin = 3 ; // LED conectado al pin 
float  valor;

void setup() 
{
  Serial.begin(9600);
  pinMode(nintendoPin, INPUT);      // Puerto 5 de lectura analogica
}

void loop() 
{
    valor = analogRead(nintendoPin);
    Serial.print("Valor recibido : ");
    Serial.println(valor);
    delay(300);                  
} 
