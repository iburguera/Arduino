/*---------------------------------------------------
               PROYECTO VOLANTE FORMULA 1
            
  El proyecto se basa en simular la funciones basicas
  que realiza el volante de un F-1 con componentes
  electronicos básicos(Resistencias, Switches, Poten-
  cimetros,Condensadores y bobinas).
  Se utilizarán 2 pulsadores para simular el
  encendido(Verde) y apagado(Rojo) del motor. 
  El potenciometro se utilizará para simular el giro 
  del volante.
  Finalmente, se utilizarán 2 switches para simular
  la subida y bajada de las marchas.
  
  ---------------------------------------------------*/
 
 

int inPinDOWN  = 2;      // PIN para BAJAR Marchas 
int inPinUP    = 4;      // PIN para SUBIR Marchas
int marcha     = 0;      // Valor de la marcha



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
         if(marcha<6)
         {
            marcha = marcha+1;
            PosicionMarcha();
         }
      }            
      if (digitalRead(inPinDOWN) == HIGH) 
      {
         if(marcha>(-1))
         {
            marcha = marcha-1;
            PosicionMarcha();
         }
      }
}
void PosicionMarcha()
{
    switch(marcha)
      {
          case -1: Serial.println("R");break;
          case  0: Serial.println("N");break;
          case  1: Serial.println(1); break;
          case  2: Serial.println(2); break;
          case  3: Serial.println(3); break;
          case  4: Serial.println(4); break;
          case  5: Serial.println(5); break;
          case  6: Serial.println(6); break;
      }
      delay(350);
}
