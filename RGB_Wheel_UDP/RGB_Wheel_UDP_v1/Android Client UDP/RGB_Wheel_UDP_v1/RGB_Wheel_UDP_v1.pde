import hypermedia.net.*;

UDP udp;  // define the UDP object

final float PI2 = 2*PI;
ArrayList<ColorWedge> wedges; 
color wcolor = 0;
int red,green,blue;

String ip       = "192.168.2.200";     // the remote IP address
int port        = 80;      // the destination port


void setup() 
{
  size(displayWidth,displayHeight);
  colorMode(HSB,PI2);
  wedges = new ArrayList<ColorWedge>();
  
  udp = new UDP( this, 6000 );  // create datagram connection on port 6000
  udp.listen( true );           // and wait for incoming message
  
  float radius = 190,
        ox = width/2,
        oy = height/2,
        px, py, nx, ny,
        step = 0.01,
        overlap = step*0.6;
        
  for(float a=0; a<PI2; a+=step) 
  {
    px = ox + radius * cos(a-overlap);
    py = oy + radius * sin(a-overlap);
    nx = ox + radius * cos(a+overlap);
    ny = oy + radius * sin(a+overlap);
    wedges.add(new ColorWedge(color(a,PI2,PI2), new float[]{ox,oy,px,py,nx,ny}));
  }
}

void draw() 
{
  background(0);
  pushStyle();
  for(ColorWedge w: wedges) 
  { 
    w.draw(); 
  }
  drawBoxColor();
  printTextDisplayTitle();
  printTextDisplayRGB(red,green,blue);
  
}

void mouseDragged() 
{
  float angle = atan2(mouseY-height/2,mouseX-width/2);
  if(angle<0) angle+=PI2;
  ColorWedge wedge = wedges.get((int)map(angle,0,PI2,0,wedges.size()));
  wcolor = wedge.c;
  printColor();    
}

void printColor()
{
   print("Color HEX: #"+hex(wcolor,6));     // Prints "FFCC00" format
  
   int r = (wcolor & 0xFF0000) >> 16;
   int g = (wcolor & 0xFF00) >> 8;
   int b = (wcolor & 0xFF);
   
   red=r;
   green=g;
   blue=b;
  
   sendUDP(red,green,blue);
   
   println("\t Color RGB: ("+r+","+g+","+b+")");
}

void sendUDP(int red, int green, int blue)
{
    String rgb = "("+red+","+green+","+blue+")";
    udp.send(""+rgb, ip, port );    // the message to send
    delay(1);
}

void printTextDisplayRGB(int r,int g,int b)
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

void drawBoxColor()
{
    fill(wcolor);
    rect((displayWidth/2)-90, 110, 180, 30, 12);
}

void printTextDisplayTitle()
{
    textAlign(CENTER);
    fill(6);
    textSize(21);
    text("Arduino Color  Wheel", displayWidth/2, 20);
}


class ColorWedge 
{
  color c;
  float[] coords;
  
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
