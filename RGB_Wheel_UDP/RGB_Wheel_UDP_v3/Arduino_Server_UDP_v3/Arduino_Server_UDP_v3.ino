/*---------------------------------------------------------
              Remote RGB LED Control on LAN 
                      Arduino SERVER
-----------------------------------------------------------*/

/*----------------------------------  
    Autor: Iker Burguera
    Date : 20/05/2013
    email: ikerburguera@gmail.com
------------------------------------*/  

#include <SPI.h>                                                                     // Libreria Arduino necesaria para versiones posteriores a la 0018
#include <Ethernet.h>                                                                // Libreria Ethernet 
#include <EthernetUdp.h>                                                             // Libreria Arduino 1.0 UDP 

#DEFINE redPin     6;                                                                // Definimos el pin 6 con salida PWM para RED
#DEFINE greenPin   5;                                                                // Definimos el pin 5 con salida PWM para GREEN
#DEFINE bluePin    3;                                                                // DEfinimos el pin 3 con salida PWM para BLUE

byte mac[]              = { 0x90, 0xA2, 0xDA, 0x00, 0x0C, 0x55 };                    // Establecemos el valor MAC de nuestra Ethernet Shield
byte ip[]               = {192, 168, 2, 200 };                                       // Asignamos una direccion IP a nuestro Servidor alojado en la Ethernet Shield
unsigned int localPort  = 80;                                                        // Escucharemos las peticiones en el puerto 80. Podriamos utilizar otro puerto, pero el cliente Android bloqueaba otros puertos, por lo tanto utilizo uno que si se que esta permitido, el 80 para http

char packetBuffer[UDP_TX_PACKET_MAX_SIZE];                                           // Creamos el buffer donde alojaremos el valor de los paquetes que nos manden
EthernetUDP Udp;                                                                     // Creamos el objeto UDP

int valRed     =  0;                                                                 // Variable Global RED donde almacenaremos los valores obtenidos de los paquetes UDP enviados por el cliente
int valGreen   =  0;                                                                 // Variable Global GREEN donde almacenaremos los valores obtenidos de los paquetes UDP enviados por el cliente
int valBlue    =  0;                                                                 // Variable Global BLUE donde almacenaremos los valores obtenidos de los paquetes UDP enviados por el cliente 

void setup() 
{
  Ethernet.begin(mac,ip);                                                            // Empezamos la comunicacion Ethernet bajo la MAC y LA IP asignadas anteriormente
  Udp.begin(localPort);                                                              // Empezamos a escuchar los datos en el puerto 80
  Serial.begin(9600);                                                                
  pinMode(redPin, OUTPUT);                                                           // Asignamos el pin 6 como salida PWM para RED
  pinMode(greenPin, OUTPUT);                                                         // Asignamos el pin 5 como salida PWM para GREEN
  pinMode(bluePin, OUTPUT);                                                          // Asignamos el pin 3 como salida PWM para BLUE  
}

void loop() 
{
  int packetSize =  Udp.parsePacket();           
  
  if(packetSize)                                                                     // Identificamos si hemos recibido un mensaje UDP
  {
    Udp.read(packetBuffer,UDP_TX_PACKET_MAX_SIZE);                                   // Leemos el mensaje UDP y lo asignamos a packeBuffer
    //Serial.println(packetBuffer);                                                 
    getColorRGB(packetBuffer);                                                       // Obtenemos los valores RGB del paquete UDP. El paquete viene separado por comas de la siguiente manera: "RED, GREEN, BLUE"
    setColorRGB(valRed,valGreen,valBlue);                                            // Funcion para establecer los colores RGB al LED RGB conectado a Arduino
    //printColores();
  }
  delay(10);        
}

void getColorRGB(char packetBuffer[])                                                // Funcion beta de obtener los valores separados por comas y parsearlas a int. Funciona, pero queda por mejorar el metodo
{
   String num1="";
   String num2="";
   String num3=""; 
   
   int uno=0;
   int dos=0;
   int tres=0;  
     
   int longitud = 0;
  
   char *p = packetBuffer;
   char *str;
   int count=1;
 
   while ((str = strtok_r(p, ",", &p)) != NULL) 
   {
     switch (count)
     {
         case 1: //Serial.print("RED: "+String(str));
                 num1 = String(str);     
                 uno  = num1.toInt();
                 valRed    = uno;
                 
                 /*
                 Serial.print("RED: ");
                 Serial.print(uno);
                 Serial.println();
                 */
                 
                 break;
                 
         case 2: //Serial.print(" GREEN: "+String(str));
                 num2 = String(str); 
                 dos  = num2.toInt();
                 valGreen=dos;
                 
                 /*
                 Serial.print(" GREEN: ");
                 Serial.print(dos);
                 Serial.println();
                 */
                 break;
                 
         case 3: //Serial.print(" BLUE: "+String(str));
                 num3 = String(str);
                 longitud = num3.length();
                 
                 tres = num3.toInt();
                 
                 if((longitud==3)  & (tres>255))
                 {
                   tres=tres/10;
                 }
                  if((longitud==4) & (tres>255))
                 {
                   tres=tres/10;
                 }
                 if((longitud==5) & (tres>255))
                 {
                   tres=tres/10;
                 }
                 
                 valBlue = tres;
                 
                
                 /*
                 Serial.print(" BLUE: ");
                 Serial.print(tres);
                 Serial.print(" LONGITUD: ");
                 Serial.print(longitud);
                 Serial.println();
                 break;
                 */
                 
         default: uno=0;dos=0;tres=0;break;        
     }
     count++;
   }
   Serial.println();
}

void setColorRGB(int red, int green, int blue)                                        // Funcion para generar salida PWM y crear color RGB en el LED
{
  analogWrite(redPin, red);
  analogWrite(greenPin, green);
  analogWrite(bluePin, blue);  
}


void printColores()                                                                   // Funcion para observar valores rebidos despues de haber sido procesados 
{
  Serial.print("RED : ");
  Serial.print(valRed);
  Serial.print(" GREEN : ");
  Serial.print(valGreen);
  Serial.print(" BLUE : ");
  Serial.print(valBlue);
  Serial.println();  
}
