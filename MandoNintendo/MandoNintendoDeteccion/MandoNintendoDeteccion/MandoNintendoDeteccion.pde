
int    nintendoPin = 3 ; // LED conectado al pin analogico 3
int  valor;

void setup() 
{
  Serial.begin(9600);
  pinMode(nintendoPin, INPUT);      // Puerto 5 de lectura analogica
}

void loop() 
{
    valor = analogRead(nintendoPin);
    
    if((valor>475) and (valor<500))                // Boton A
    {
      Serial.print("TECLA : A  ");
      Serial.print("Valor recibido : ");
      Serial.println(valor);
    }
    if((valor>450) and (valor<470))                // Boton B
    {
      Serial.print("TECLA : B  ");
      Serial.print("Valor recibido : ");
      Serial.println(valor);
    }
    if((valor>400) and (valor<440))                // ARRIBA
    {
      Serial.print("TECLA : ARRIBA  ");
      Serial.print("Valor recibido : ");
      Serial.println(valor);
    }
     if((valor>355) and (valor<399))               // ABAJO
    {
      Serial.print("TECLA : ABAJO  ");
      Serial.print("Valor recibido : ");
      Serial.println(valor);
    }
     if((valor>500) and (valor<600))               // IZQUIERDA
    {
      Serial.print("TECLA : IZQUIERDA  ");
      Serial.print("Valor recibido : ");
      Serial.println(valor);
    }
     if((valor>300) and (valor<350))               // DERECHA
    {
      Serial.print("TECLA : DERECHA  ");
      Serial.print("Valor recibido : ");
      Serial.println(valor);
    }
    
    //Serial.print("Valor recibido : ");
    delay(500);                  
} 
