import processing.serial.*;

import java.awt.Robot;
import java.awt.AWTException;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;


Serial N64Connection;
String buttons;
Robot VKey;
PImage bg;
String[] pressed;
boolean a,b,z,s,cu,cd,cl,cr,dd,du,dr,dl,ll,rr,u,d,l,r;

String boton="";



void setup() 
{
  pressed = split("a", ' ');;
  size(540,300);
  frameRate(1);
  String portName = Serial.list()[4];
  N64Connection = new Serial(this, portName, 115200);
  try
  {
    VKey = new Robot();
  }
  catch(AWTException a){}
  N64Connection.bufferUntil('\n');
  buttons = "Hell0 m0t0 ";
  bg = loadImage("N64 Controller.jpg");
}

void draw()
{
  background(bg);
  fill(255, 255, 0);
}

void serialEvent(Serial N64Connection)
{
  // bits: A, B, Z, Start, Dup, Ddown, Dleft, Dright
  // bits: 0, 0, L, R, Cup, Cdown, Cleft, Cright
  buttons = N64Connection.readString();
  pressed = split(buttons, ' ');
  //print(buttons);

  for (int i = 0; i <= 15; i++)
  {
    if (pressed[0].charAt(i) == ('4'))
    {
      switch(i)
      {
          case 0:    if(!a)                              //A
                     {
                        a = !a; 
                     }break;
        
          case 1:    if(!b)                              //B
                     {
                        b = !b; 
                      }break;
          case 2:    if(!z)                              //Z
                     {
                        z = !z; 
                     }break;
   
          case 3:    if(!s)                              // START
                     {
                        s = !s;                   
                     }break;
          case 4:    if(!du)                             // Direccion UP 
                     {
                        du = !du; 
                     }break;
          case 5:    if(!dd)                             // Direccion DOWN 
                     {
                        dd = !dd; 
                     }break;
          case 6:    if(!dl)                             // Direccion LEFT 
                     {
                        dl = !dl; 
                     }break;                     
          case 7:    if(!dr)                             // Direccion RIGHT 
                     {
                        dr = !dr; 
                     }break;

          case 10:   if(!ll)                             // Boton L 
                     {
                        ll = !ll; 
                     }break;
          case 11:   if(!rr)                             // Boton R 
                     {
                        rr = !rr; 
                     }break;

          case 12:   if(!cu)                             // C Boton UP  
                     {
                        cu = !cu; 
                     }break;
          case 13:   if(!cd)                             // C Boton DOWN  
                     {
                        cd = !cd; 
                     }break;
          case 14:   if(!cl)                             // C Boton LEFT  
                     {
                        cl = !cl; 
                     }break;
          case 15:   if(!cr)                             // C Boton RIGHT  
                     {
                        cr = !cr; 
                     }break;                    
      }
    }
    if (pressed[0].charAt(i) == ('0'))
    {
      switch(i)
      {
          case 0:    if(a)                              //A
                     {
                        a = !a;
                        printBoton("A");
                     }break;
        
          case 1:    if(b)                              //B
                     {
                        b = !b;
                        printBoton("B"); 
                      }break;
          case 2:    if(z)                              //Z
                     {
                        z = !z;
                        printBoton("Z"); 
                     }break;
   
          case 3:    if(s)                              // START
                     {
                        s = !s;
                        printBoton("START");                   
                     }break;
          case 4:    if(du)                             // Direccion UP 
                     {
                        du = !du; 
                        printBoton("Direccion UP");
                     }break;
          case 5:    if(dd)                             // Direccion DOWN 
                     {
                        dd = !dd; 
                        printBoton("Direccion DOWN");
                     }break;
          case 6:    if(dl)                             // Direccion LEFT 
                     {
                        dl = !dl;
                        printBoton("Direccion LEFT"); 
                     }break;                     
          case 7:    if(dr)                             // Direccion RIGHT 
                     {
                        dr = !dr;
                        printBoton("Direccion RIGHT"); 
                     }break;

          case 10:   if(ll)                             // Boton L 
                     {
                        ll = !ll;
                        printBoton("L"); 
                     }break;
          case 11:   if(rr)                             // Boton R 
                     {
                        rr = !rr;
                        printBoton("R"); 
                     }break;

          case 12:   if(cu)                             // C Boton UP  
                     {
                        cu = !cu;
                        printBoton("C Boton UP"); 
                     }break;
          case 13:   if(cd)                             // C Boton DOWN  
                     {
                        cd = !cd;
                        printBoton("C Boton DOWN"); 
                     }break;
          case 14:   if(cl)                             // C Boton LEFT  
                     {
                        cl = !cl;
                        printBoton("C Boton LEFT"); 
                     }break;
          case 15:   if(cr)                             // C Boton RIGHT  
                     {
                        cr = !cr;
                        printBoton("C Boton UP"); 
                     }break;                    
      } // Switch
    }//if 0
  } //for
} // serial event




void printBoton(String boton)
{
    println("Boton : "+boton);
}

