
int valor;
int puertoMotorPWM = 9;

void setup() 
{
   Serial.begin(9600);
}

void loop () 
{
   for(valor=0;valor<=255;valor++)
   {
     analogWrite(puertoMotorPWM, valor);
     delay(100);
   }
   for(valor=255;valor>0;valor--)
   {
     analogWrite(puertoMotorPWM, valor);
     delay(100);
   }
   
}
