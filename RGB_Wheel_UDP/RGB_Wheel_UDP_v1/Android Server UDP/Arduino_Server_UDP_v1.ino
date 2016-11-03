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
char replyBuffer[] = "acknowledged";       // a string to send back


EthernetUDP Udp;

void setup() 
{
  Ethernet.begin(mac,ip);
  Udp.begin(localPort);
  Serial.begin(9600);
}

void loop() 
{
  int packetSize =  Udp.parsePacket(); 
  if(packetSize)
  {
    Udp.read(packetBuffer,UDP_TX_PACKET_MAX_SIZE);
    Serial.println(packetBuffer);
  }
  delay(10);
}
