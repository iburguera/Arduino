/*
 * UDPSendReceiveStrings
 * This sketch receives UDP message strings, prints them to the serial port
 * and sends an "acknowledge" string back to the sender
 * Use with Arduino 1.0
 *
 */

#include <SPI.h>         // needed for Arduino versions later than 0018
#include <Ethernet.h>
#include <EthernetUdp.h> // Arduino 1.0 UDP library

byte mac[] = { 0x90, 0xA2, 0xDA, 0x00, 0x0C, 0x55 };
byte ip[] = {192, 168, 2, 200 };    // Arduino's IP address

unsigned int localPort = 80;      // local port to listen on


char packetBuffer[UDP_TX_PACKET_MAX_SIZE]; //buffer to hold incoming packet,

EthernetUDP Udp;

int redPin    = 6; //DEFINE
int greenPin  = 5; //DEFINE
int bluePin   = 3; //DEFINE
 


int valRed =0;  
int valGreen =0;
int valBlue =0; 

void setup() 
{
  Ethernet.begin(mac,ip);
  Udp.begin(localPort);
  Serial.begin(9600);
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);  
}

void loop() 
{
  int packetSize =  Udp.parsePacket(); 
  if(packetSize)
  {
    Udp.read(packetBuffer,UDP_TX_PACKET_MAX_SIZE);
    //Serial.println(packetBuffer);
    getColorRGB(packetBuffer);
    //setColorRGB(valRed,valGreen,valBlue);
    //printColores();
  }

  delay(10);
}

void getColorRGB(char packetBuffer[])
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

void setColorRGB(int red, int green, int blue)
{
  analogWrite(redPin, red);
  analogWrite(greenPin, green);
  analogWrite(bluePin, blue);  
}


void printColores()
{
  Serial.print("RED : ");
  Serial.print(valRed);
  Serial.print(" GREEN : ");
  Serial.print(valGreen);
  Serial.print(" BLUE : ");
  Serial.print(valBlue);
  Serial.println();  
}
