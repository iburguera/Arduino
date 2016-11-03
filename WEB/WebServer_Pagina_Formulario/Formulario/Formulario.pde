#include <WString.h>
#include <Ethernet.h>


byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED }; //physical mac address
byte ip[] = { 192, 168, 1, 200 }; // ip in lan
byte gateway[] = { 192, 168, 1, 1 }; // internet access via router
byte subnet[] = { 255, 255, 255, 0 }; //subnet mask
Server server(80); //server port
byte sampledata=50; //some sample data – outputs 2 (ascii = 50 DEC)
int ledPin = 4; // LED pin
String readString = String(30); //string for fetching data from address

boolean LEDON = false; //LED status flag

    void setup()
    {      
        Ethernet.begin(mac, ip, gateway, subnet);   
        pinMode(ledPin, OUTPUT);
        Serial.begin(9600); 
    }

    void loop()
    {
          Client client = server.available();
    
          if (client) 
          {
              while (client.connected())
              {
                  if (client.available())
                  {
                      char c = client.read();
                      
                      if (readString.length() < 30) 
                      {
                          readString.append(c); 
                      }
                      Serial.print(c);

                      if (c == '\n') 
                      {
                          if(readString.contains("L=1")) 
                          {
                               digitalWrite(ledPin, HIGH); // set the LED on
                               Serial.println("Has pulsado el boton ENCENDER");
                               LEDON = true;
                          }
                          else // L=0
                          {
                               digitalWrite(ledPin, LOW); // set the LED OFF
                               Serial.println("Has pulsado el boton APAGAR");
                               LEDON = false; 
                          }

                              client.println("HTTP/1.1 200 OK");                      
                              client.println("Content-Type: text/html");
                              client.println();
        
                              client.print("<body style=background-color:yellow>");
                              client.println("<font color=’red’><h1>HTTP test routines</font></h1>");                    
                              client.println("<hr />");
                              client.println("<hr />");
                              client.println("<font color=’blue’ size=’5′>Sample data: ");
                              client.print(sampledata);//lets output some data
                              client.println("<br />");//some space between lines
                              client.println("<hr />");                  
                              client.println("<font color=’green’>Simple table: ");
                              client.println("<br />");
                              client.println("<table border=1><tr><td>row 1, cell 1</td><td>row 1, cell 2</td></tr>");
                              client.println("<tr><td>row 2, cell 1</td><td>row 2, cell 2</td></tr></table>");
                              client.println("<br />");
                              client.println("<hr />");
                              
                              //controlling led via checkbox
                              
                              client.println("<h1>LED control</h1>");
                              
                              //address will look like http://192.168.1.110/?L=1 when submited
                              
                              client.println("<form method=get name=LED><input type=checkbox name=L value=1>LED<br><input type=submit value=submit></form>");
                              client.println("<br />");
                              
                              //printing LED status
                              
                              client.print("<font size=’5′>LED status: ");
                              
                              if (LEDON)
                                  client.println("<font color=’green’ size=’5′>ON");
                              else
                                  client.println("<font color=’grey’ size=’5′>OFF");
                                  
                              client.println("<hr />");
                              client.println("<hr />");
                              client.println("</body></html>");
        
                              readString="";   
                              client.stop();
    
                       }
                     }
                   }
                 }
               } 
