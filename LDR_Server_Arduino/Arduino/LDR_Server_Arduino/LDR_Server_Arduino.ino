/* 
 ------------------------------------------ 
            LDR + Servidor WEB
 ------------------------------------------ 
*/
 
#include <Ethernet.h>   // Incluye la librería Ethernet
#include<SPI.h>
 

byte mac[] = { 0x90, 0xA2, 0xDA, 0x00, 0x0C, 0x55 }; //physical mac address
byte ip[] = { 192, 168, 2, 200 };
 
EthernetServer server(80);
 
 
//------------------------------------
//Funcion principal
//------------------------------------
void setup()
{  
  Ethernet.begin(mac, ip);  //Incializa libreria y configuraciones de red
  server.begin();  //Incia comunicación a través del puerto
}
 
 
//------------------------------------
//Funcion ciclicla
//------------------------------------ 
void loop()
{
  EthernetClient client = server.available();
 
  if (client) 
  {
    boolean current_line_is_blank = true;          //Una petición http termina con una línea en blanco
    
    while (client.connected()) 
    {
      if (client.available()) 
      {
        char c = client.read();
 
        if (c == '\n' && current_line_is_blank) // Si hemos llegado al final de la línea (recibió una nueva línea Carácter) y la línea está en blanco, la petición http ha terminado, Para que podamos enviarle una respuesta
        {          
          client.println("HTTP/1.1 200 OK");              // Envió de un encabezado estándar de respuesta HTTP 
          client.println("Content-Type: text/html");
          client.println();
       
          client.print("Valor LDR analogico: ");        //Imprimir valor entrada análoga
          client.print("0");
          client.print(" de ");
          client.print(analogRead(1));  // Lectura del pin 0 (analogo)
          client.println("<br />");
          client.println("<br />");
 
          break;
        }
 
        if (c == '\n') 
        {
          
          current_line_is_blank = true;   // Comenzaremos una nueva línea
        } 
        else if (c != '\r') 
        {
          
          current_line_is_blank = false;  // Obtenemos un caracter en la línea actual
        }
      }
    }
    
    delay(1);   // Damos un tiempo al servidor web para recibir los datos. Retardo de un 1 ms(milisegundo)
 
    client.stop();
  }
}
