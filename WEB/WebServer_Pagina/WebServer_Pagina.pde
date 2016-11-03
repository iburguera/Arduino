/*
 * Web Server
 *
 * A simple web server that shows the value of the analog input pins.
 */

#include <Ethernet.h>

byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
byte ip[] = { 192, 168, 1, 200 };

Server server(80);

int inPin = 9; // input pin (for a switch)

void setup()
{
  Ethernet.begin(mac, ip);
  server.begin();
   pinMode(inPin, INPUT); // declare switch as input 
}

void loop()
{
  Client client = server.available();
  if (client) {
    // an http request ends with a blank line
    boolean current_line_is_blank = true;
    while (client.connected()) {
      if (client.available()) {
        char c = client.read();
        
        
        // if we've gotten to the end of the line (received a newline
        // character) and the line is blank, the http request has ended,
        // so we can send a reply
        if (c == '\n' && current_line_is_blank) 
        {
          // send a standard http response header
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
client.println("<p><span class='Estilo1'><u>ARDUINO WEB PAGE</u> </span></p>");
client.println("<form name='form1' method='post' action=''>");
client.println("<p><span class='Estilo6'>Posicion del servomotor </span></p>");
client.println("<table width='383' height='92' border='0'>");
client.println("<tr>");
client.println("<td bgcolor='#3366FF'><div align='center'><span class='Estilo2'></span></div></td>");
client.println("<td><div align='center'><span class='Estilo2'></span>");
client.println("<label>");
client.println("<input type='submit' name='Submit' value='ARRIBA'>");
client.println("</label>");
client.println("</div></td>");
client.println("<td bgcolor='#3366FF'><div align='center'><span class='Estilo2'></span></div></td>");
client.println("</tr>");
client.println("<tr>");
client.println("<td bgcolor='#3366FF'><div align='center'>");
client.println("<label>");
client.println("<input type='submit' name='Submit4' value='IZQUIERDA'>");
client.println("</label>");
client.println("</div></td>");
client.println("<td bgcolor='#3366FF'><div align='center'>");
client.println("<label>");
client.println("<input type='submit' name='Submit5' value='PosicionInicial'>");
client.println("</label>");
client.println("</div></td>");
client.println("<td bgcolor='#3366FF'><div align='center'>");
client.println("<label>");
client.println("<input type='submit' name='Submit3' value='DERECHA'>");
client.println("</label>");
client.println("</div></td>");
client.println("</tr>");
client.println("<tr>");
client.println("<td bgcolor='#3366FF'><div align='center'></div></td>");
client.println("<td bgcolor='#3366FF'><div align='center'>");
client.println("<label>");
client.println("<input type='submit' name='Submit2' value='ABAJO'>");
client.println("</label>");
client.println("</div></td>");
client.println("<td bgcolor='#3366FF'><div align='center'></div></td>");
client.println("</tr>");
client.println("</table>");
client.println("<p><span class='Estilo6'>Valores de los motores</span></p>");
client.println("<table width='298' height='51' border='1' align='center'>");
client.println("<tr>");
client.println("<td bgcolor='#99FF00'><div align='center' class='Estilo12'><span class='Estilo10'>MOTOR 1 </span></div></td>");
client.println("<td bgcolor='#99FF00'><div align='center' class='Estilo12'><span class='Estilo10'>MOTOR2</span></div></td>");
client.println("</tr>");
client.println("<tr>");
    client.println("<td><div align='center' class='Estilo8' ></div>");
              client.print("<center><span class='Estilo6'>");
                client.println(digitalRead(9));
              client.print("</center>"); 
    client.println("</td>");
    client.println("<td><div align='center' class='Estilo8' ></div>");
              client.print("<center><span class='Estilo6'>");
                client.println(digitalRead(9));
              client.print("</center>"); 
    client.println("</td>");
client.println("</tr>");
client.println("</table>");
client.println("</form>");
client.println("<p class='Estilo8'>Pagina web para controlar el servomotor e interpretar los valores de los motores </p>");
client.println("<p>&nbsp;</p>");
client.println("</center>");
client.println("</body>");
client.println("</html>");

          break;
        }
        if (c == '\n') {
          // we're starting a new line
          current_line_is_blank = true;
        } else if (c != '\r') {
          // we've gotten a character on the current line
          current_line_is_blank = false;
        }
      }
    }
    // give the web browser time to receive the data
    delay(1);
    client.stop();
  }
}
