#include <WString.h>
#include <Ethernet.h>
#include <Servo.h> 


byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED }; //physical mac address
byte ip[] = { 192, 168, 1, 200 }; // ip in lan
byte gateway[] = { 192, 168, 1, 1 }; // internet access via router
byte subnet[] = { 255, 255, 255, 0 }; //subnet mask
Server server(80); //server port
byte sampledata=90; //some sample data – outputs 2 (ascii = 50 DEC)
int ledPin = 4; // LED pin
String readString = String(30); //string for fetching data from address
Servo myservo;  // create servo object to control a servo 
                // a maximum of eight servo objects can be created 
int pos = 90;    // variable to store the servo position 


    void setup()
    {      
        Ethernet.begin(mac, ip, gateway, subnet);   
        pinMode(ledPin, OUTPUT);
        myservo.attach(9);  // attaches the servo on pin 9 to the servo object 
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
                      
                      if (readString.length() < 50) 
                      {
                          readString.append(c); 
                      }
                      //Serial.print(c);

                      if (c == '\n') 
                      {
                          if(readString.contains("ACCION=IZQUIERDA")) 
                          {
                               Serial.println("Has pulsado el boton: IZQUIERDA ");  
                               if(pos>0 && pos<180)
                               {
                                    pos =pos+3; 
                                    myservo.write(pos);  
                                    delay(1);   
                               }
                               else
                               {
                                    pos =90; 
                                    myservo.write(pos);  
                                    delay(1);       
                               }
                          }
                          if(readString.contains("ACCION=DERECHA")) 
                          {
                               Serial.println("Has pulsado el boton: DERECHA");
                               if(pos>0 && pos<180)
                               {
                                    pos =pos-3; 
                                    myservo.write(pos);  
                                    delay(1);   
                               }
                               else
                               {
                                    pos =90; 
                                    myservo.write(pos);  
                                    delay(1);       
                               } 
                          }
                          if(readString.contains("ACCION=POSINI")) 
                          {
                               Serial.println("Has pulsado el boton POSICION INICIAL"); 
                               if(pos>0 && pos<180)
                               {
                                    pos =90; 
                                    myservo.write(pos);  
                                    delay(1);   
                               }
                               else
                               {
                                    pos =90; 
                                    myservo.write(pos);  
                                    delay(1);       
                               }
                          }
                          if(readString.contains("ACCION=ARRIBA")) 
                          {
                               Serial.println("Has pulsado el boton: ARRIBA ");  
                               if(pos>0 && pos<180)
                               {
                                    pos =45; 
                                    myservo.write(pos);  
                                    delay(1);   
                               }
                               else
                               {
                                    pos =90; 
                                    myservo.write(pos);  
                                    delay(1);       
                               }
                          }
                          if(readString.contains("ACCION=ABAJO")) 
                          {
                               Serial.println("Has pulsado el boton: ABAJO ");  
                               if(pos>0 && pos<180)
                               {
                                    pos =135; 
                                    myservo.write(pos);  
                                    delay(1);   
                               }
                               else
                               {
                                    pos =90; 
                                    myservo.write(pos);  
                                    delay(1);       
                               }
                          }
                     

                              client.println("HTTP/1.1 200 OK");                      
                              client.println("Content-Type: text/html");
                              client.println();
                              
                              client.println("<html>");
                              client.println("<head><title>Configuracion WEB Arduino</title><style type='text/css'>");
                              client.println("<!--");
                              client.println(".Estilo1");
                              client.println("{");
                              client.println("font-family: Verdana;");
                              client.println("font-size: 36px;");
                              client.println("color: #FFFFFF;");
                              client.println("}");
                              client.println(".Estilo2 {color: #FFFFFF}");
                              client.println(".Estilo6 {font-family: Verdana; color: #FFFFFF; font-weight: bold; }");
                              client.println(".Estilo8 {color: #FFFFFF; font-family: Verdana; }");
                              client.println(".Estilo10 {font-weight: bold; font-family: Verdana;}");
                              client.println(".Estilo12 {color: #333333; }");
                              client.println("-->");
                              client.println("</style></head>");
                              client.println("<body  bgcolor='#3366FF' >");
                              client.println("<center>");
                              client.println("<p>&nbsp;</p>");
                              client.println("<p><span class='Estilo1'><u> ARDUINO CONTROL WEB SERVOMOTOR</u> </span></p>");
                              
                              client.println("<form method=get >");
                              client.println("<center>");
                              client.println("<table width='383' height='92' border='0'>");
                              client.println("<tr>");
                              client.println("<td></td><td><input type=submit name=ACCION value=ARRIBA></td><td></td>");
                              client.println("</tr>");
                              client.println("<tr>");
                              client.println("<td><input type=submit name=ACCION value=IZQUIERDA></td><td><input type=submit name=ACCION value=POSINI></td><td><input type=submit name=ACCION value=DERECHA></td>");
                              client.println("</tr>");
                              client.println("<tr>");
                              client.println("<td></td><td><input type=submit name=ACCION value=ABAJO></td><td></td>");
                              client.println("</tr>");            
                              client.println("</table>"); 
                              client.println("</center>");
                              client.println("</form>");
                              
                              client.println("<br><br>");
                              
                              client.println("<center>");
                              client.println("<table width='383' height='92' border='1'>");
                              client.println("<tr bgcolor='#99CC00'>");
                              client.println("<td><center><b>GRADOS</b></center></td>");
                              client.println("</tr>");
                              client.println("<tr>");
                              client.println("<td><center><b>");
                              client.println(pos);
                              client.println("</b></center></td>");
                              client.println("</tr>");
                              client.println("</table>"); 
                              client.println("</center>");
                             
                              client.println("<p class='Estilo8'>Pagina web para controlar el servomotor </p>");
                              client.println("<p class='Estilo8'>Autor : Iker Burguera  &nbsp;&nbsp;&nbsp;  Email: ikerburguera@gmail.com</p>");
                              client.println("<br>");
                              client.println("</center>");
                              client.println("</body>");
                              client.println("</html>");

                              readString="";   
                              client.stop();

                       }
                     }
                   }
                 }
               } 
