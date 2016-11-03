import processing.serial.*;

float xPos=0;
float yPos=0;
float zPos=0;
 
void setup()
{
   size(displayWidth, displayHeight);
}

void draw() 
{
  PVector v1 = new PVector(displayWidth,0);
  PVector v2 = new PVector(displayWidth,displayHeight);
   
  
  float a = PVector.angleBetween(v1,v2);
  
  xPos=mouseX;
  yPos=mouseY;
  zPos=mouseX/cos(a);
    
  background(0);
  
  stroke(#FF0000);
  line(0, 0, displayWidth, 0);        //RED
  
  stroke(#00FF00);
  line(0, 0, 0, displayHeight);      //GREEN
   
  stroke(#0000FF);
  line(0, 0, displayWidth, displayHeight);      //BLUE
 
  print("Xpos"+xPos);
  print(" , ");
  print("Ypos"+yPos);
  print("  :  ");
  print("Zpos"+zPos);
  print(" , ");
  println("Angle: "+degrees(a));
  
  
}
