#include <WString.h>
#include <Ethernet.h>
#include <Servo.h> 



byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED }; //physical mac address
byte ip[] = { 192, 168, 1, 200 }; // ip in lan
byte gateway[] = { 192, 168, 1, 1 }; // internet access via router
byte subnet[] = { 255, 255, 255, 0 }; //subnet mask
Server server(80); //server port
Servo myservo;  // create servo object to control a servo 
                // a maximum of eight servo objects can be created 
int pos = 90;    // variable to store the servo position 
byte sampledata=90; //some sample data – outputs 2 (ascii = 50 DEC)
int ledPin = 4; // LED pin
String readString = String(30); //string for fetching data from address


    void setup()
    {      
        Ethernet.begin(mac, ip, gateway, subnet);   
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
                      
                      if (readString.length() < 30) 
                      {
                          readString.append(c); 
                      }
                      //Serial.print(c);

                      if (c == '\n') 
                      {
                          if(readString.contains("ACCION=ARRIBA")) 
                          {
                              ejecutarProcesoArriba();
                          }
                          else
                          {
                              ejecutarProcesoInicio();
                          }
                          if(readString.contains("ACCION=ABAJO")) 
                          {
                              ejecutarProcesoAbajo();
                          }
                          else
                          {
                              ejecutarProcesoInicio();
                          }
                          if(readString.contains("ACCION=IZQUIERDA")) 
                          {
                              ejecutarProcesoArriba();           
                          }
                          else
                          {
                              ejecutarProcesoInicio();
                          }
                          
                          if(readString.contains("ACCION=DERECHA")) 
                          {
                               ejecutarProcesoDerecha();   
                          }
                          else
                          {
                               ejecutarProcesoInicio();
                          }
                          
                          if(readString.contains("ACCION=POSINI")) 
                          {
                               ejecutarProcesoInicio();
                          }
                          else
                          {
                              ejecutarProcesoInicio(); 
                          }
                          
                          if(readString.contains("ACCION=0")) 
                          {
                               ejecutarProceso0();
                          }
                          else
                          {
                              ejecutarProcesoInicio(); 
                          }
                          
                          if(readString.contains("ACCION=45")) 
                          {
                               ejecutarProceso45();
                          }
                          else
                          {
                              ejecutarProcesoInicio(); 
                          }
                          
                          if(readString.contains("ACCION=90")) 
                          {
                               ejecutarProceso90();
                          }
                          else
                          {
                               ejecutarProcesoInicio(); 
                          }
                          
                          if(readString.contains("ACCION=135")) 
                          {
                               ejecutarProceso135();
                          }
                          else
                          {
                               ejecutarProcesoInicio(); 
                          }
                          
                          if(readString.contains("ACCION=180")) 
                          {
                               ejecutarProceso180();
                          }
                          else
                          {
                               ejecutarProcesoInicio(); 
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
                              client.println("<p><span class='Estilo1'><u>ARDUINO SERVOMOTOR CONTROL WEB PAGE</u> </span></p>");
                              
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
                              client.println("<tr>");
                              client.println("<td></td><td><input type=submit name=ACCION value=0></td><td></td>");
                              client.println("<td></td><td><input type=submit name=ACCION value=45></td><td></td>");
                              client.println("<td></td><td><input type=submit name=ACCION value=90></td><td></td>");
                              client.println("<td></td><td><input type=submit name=ACCION value=135></td><td></td>");
                              client.println("<td></td><td><input type=submit name=ACCION value=180></td><td></td>");
                              client.println("<tr>");            
                              client.println("</table>"); 
                              client.println("</center>");
                              client.println("</form>");
                              
                              client.println("<br><br>");
                              
                              client.println("<center>");
                              client.println("<table width='383' height='92' border='1'>");
                              client.println("<tr bgcolor='#99CC00'>");
                              client.println("<td><center><b>MOTOR 1</b></center></td><td><center><b>POSICION</b></center></td><td><center><b>MOTOR 2</b></center></td>");
                              client.println("</tr>");
                              client.println("<tr>");
                              client.println("<td><center>VALOR 1</center></td>");
                              client.println("<td><center>");
                              client.println("</center></td>");
                              client.println("<td><center>VALOR 2 2</center></td>");
                              client.println("</tr>");
                              client.println("</table>"); 
                              client.println("</center>");
                             
                              client.println("<p class='Estilo8'>Pagina web para controlar el servomotor e interpretar los valores de los motores </p>");
                              client.println("<p>&nbsp;</p>");
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
              
              
    
    void ejecutarProcesoArriba()
    {
         Serial.println("Has pulsado el boton: ARRIBA"); 
         pos =135; 
         myservo.write(pos);  
         delay(1);    
    }
    void ejecutarProcesoAbajo()
    {
         Serial.println("Has pulsado el boton: ABAJO"); 
         pos =135; 
         myservo.write(pos);  
         delay(1);    
    }
    void ejecutarProcesoIzquierda()
    {
         Serial.println("Has pulsado el boton: IZQUIERDA"); 
         pos =135; 
         myservo.write(pos);  
         delay(1);    
    }
    void ejecutarProcesoDerecha()
    {
         Serial.println("Has pulsado el boton: DERECHA"); 
         pos =135; 
         myservo.write(pos);  
         delay(1);    
    }
    void ejecutarProceso0()
    {
         Serial.println("Has pulsado el boton: 0º"); 
         pos =0; 
         myservo.write(pos);  
         delay(1);    
    }
    void ejecutarProceso45()
    {
         Serial.println("Has pulsado el boton: 45º"); 
         pos =45; 
         myservo.write(pos);  
         delay(1);    
    }
    void ejecutarProceso90()
    {
         Serial.println("Has pulsado el boton: 90º"); 
         pos =90; 
         myservo.write(pos);  
         delay(1);    
    }
    void ejecutarProceso135()
    {
         Serial.println("Has pulsado el boton: 135º"); 
         pos =135; 
         myservo.write(pos);  
         delay(1);    
    }
    void ejecutarProceso180()
    {
         Serial.println("Has pulsado el boton: 180º"); 
         pos =180; 
         myservo.write(pos);  
         delay(1);    
    }
    void ejecutarProcesoInicio()
    {
         Serial.println("Has pulsado el boton: INICIO"); 
         pos =90; 
         myservo.write(pos);  
         delay(1);    
    } 
