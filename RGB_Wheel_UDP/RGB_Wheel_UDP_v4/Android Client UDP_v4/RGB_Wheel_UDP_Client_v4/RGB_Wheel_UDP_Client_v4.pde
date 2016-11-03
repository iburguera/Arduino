/*---------------------------------------------------------
 *             Remote RGB LED Control on LAN  
 *               Arduino+Processing CLIENT 
-----------------------------------------------------------*/

/*----------------------------------  
  *  Autor: Iker Burguera
  *  Date : 20/05/2013
  *  email: ikerburguera@gmail.com
------------------------------------*/    

import java.awt.*;
import hypermedia.net.*;                                                            // Importamos libreria para poder utilizar UDP




UDP udp;                                                                            // Definimos el objeto UDP 

final float PI2 = 2*PI;                                                             // Creamos el valor PI multiplicado * 2
ArrayList<ColorWedge> wedges;                                                       // Creamos un Array donde almacenaremos la gama de colores
color wcolor = 0;                                                                    
int red,green,blue;                                                                 // Creamos variable donde almacenaremos los valores RGB 

String ip       = "192.168.2.200";                                                  // Establecemos la IP remota donde se aloja el Servidor
int port        = 80;                                                               // Establecemos el puerto por donde se enviaran las comunicaciones. El servidor deberá escuchar en este mismo puerto

TextField textField_IP   = new TextField("<IP>", 16);
TextField textField_PORT = new TextField("<Port>", 4);

void setup() 
{
  size(displayWidth,displayHeight);                                                 // Dibujamos el lienzo a pantalla completa para dibujar la rueda de colores
  colorMode(HSB,PI2);                                                               // Establecemos el tipo de color que utilizaremos. HSB
  wedges = new ArrayList<ColorWedge>();                                             // Inicializamos el objeto webges como Array de Colores
  
  udp = new UDP( this, 6000 );                                                      // Inicializamos el objeto udp para que escuche en el puerto 6000 en caso de que el servidor nos envie algun dato(acknowlegement). En este ejemplo, el servidor no envia ningun dato al cliente pero en un futuro nos podría interesar recibir datos
  udp.listen( true );                                                               // Espera ha recibir datos 
  
  float radius = 190,                                                               // Definimos los valores que llevara el circulo 
        ox = width/2,
        oy = height/2,
        px, py, nx, ny,
        step = 0.01,
        overlap = step*0.6;
        
  for(float a=0; a<PI2; a+=step)                                                    // Agregamos al objeto wedges los colores
  {
    px = ox + radius * cos(a-overlap);
    py = oy + radius * sin(a-overlap);
    nx = ox + radius * cos(a+overlap);
    ny = oy + radius * sin(a+overlap);
    wedges.add(new ColorWedge(color(a,PI2,PI2), new float[]{ox,oy,px,py,nx,ny}));
  }
  
  add(textField_IP);
  add(textField_PORT);
}

void draw() 
{
  background(0);                                                                    // Dibujamos el fondo en negro para poder apreciar la gama de colores RGBen la rueda
  pushStyle();
  
  for(ColorWedge w: wedges)                                                         // Dibujamos la rueda de colores RGB 
  { 
    w.draw(); 
  }
  drawBoxColor();                                                                   // Dibujamos un cuadro donde muestra el valor del color actual seleccionado en la pantalla
  printTextDisplayTitle();                                                          // Dibujamos un titulo para identificar el programa
  printTextDisplayRGB(red,green,blue);                                              // Dibujamos los valores RGB en formato numerico y Hexadecimal
  
}

void mouseDragged()                                                                 // Cuando movemos el raton en la pantalla...
{
  float angle = atan2(mouseY-height/2,mouseX-width/2);                              // Obtenemos el angulo donde se ha pulsado                        
  if(angle<0) angle+=PI2;
  ColorWedge wedge = wedges.get((int)map(angle,0,PI2,0,wedges.size()));             // Asociamos el angulo con el color
  wcolor = wedge.c;                                                                 // Asociamos el color del angulo en pantalla a la variable wcolor
  printColor();                                                                     
}

void printColor()
{
   print("Color HEX: #"+hex(wcolor,6));                                             // Imprimimos el valor wcolor en formato "FFCC00" 
  
   int r = (wcolor & 0xFF0000) >> 16;                                               // Obtenemos el valor Red
   int g = (wcolor & 0xFF00) >> 8;                                                  // Obtenemos el valor Green
   int b = (wcolor & 0xFF);                                                         // Obtenemos el valor Blue
   
   red=r;                                                                           // Asociamos a variable Global Red
   green=g;                                                                         // Asociamos a variable Global Green
   blue=b;                                                                          // Asociamos a variable Global Blue
  
   sendUDP(red,green,blue);                                                         // Enviamos datos a la funcion sendUDP()
   
   println("\t Color RGB: ("+r+","+g+","+b+")");
}

void sendUDP(int red, int green, int blue)                                          
{
    String rgb = red+","+green+","+blue;                                            // Creamos un String con formato "Red,Green,Blue" para enviarlo al servidor con los valor obtenidos de la rueda de colores
    udp.send(rgb, ip, port );                                                       // Enviamos el String a la IP y al Puerto establecido anteriormente
    delay(1);                                                                       // Le damos un delay de 1 ms
}

void printTextDisplayRGB(int r,int g,int b)                                         // Dibujamos los valores RGB en formato numerico y Hexadecimal
{
    textAlign(CENTER);
    fill(6);
    textSize(16);  
    text("Color RGB: ("+r+","+g+","+b+")",displayWidth/2,50);
    textAlign(CENTER);
    fill(6);
    textSize(16);
    text("Color HEX: #"+hex(wcolor,6)+"",displayWidth/2,70);
}

void drawBoxColor()                                                                 // Dibujamos un cuadro donde muestra el valor del color actual seleccionado en la pantalla
{
    fill(wcolor);
    rect((displayWidth/2)-90, 110, 180, 30, 12);
}

void printTextDisplayTitle()                                                        // Dibujamos un titulo para identificar el programa
{
    textAlign(CENTER);
    fill(6);
    textSize(21);
    text("Arduino Color  Wheel", displayWidth/2, 20);
}


class ColorWedge                                                                    // Creamos la clase ColorWedge donde almacenaremos colores y angulos. Cada color estará asociado a un angulo
{
  color c;                                                                          // Variable donde se almacena el color
  float[] coords;                                                                   // Array de float para agregar las coordenadas asociadas a los colores
  
  ColorWedge(color _c, float[] _coords) 
  {
    c = _c;
    coords = _coords;
  }
  void draw() 
  {
    fill(c);
    noStroke();
    triangle(coords[0],coords[1],coords[2],coords[3],coords[4],coords[5]);
    stroke(0);
    line(coords[2],coords[3],coords[4],coords[5]);
  }
}
