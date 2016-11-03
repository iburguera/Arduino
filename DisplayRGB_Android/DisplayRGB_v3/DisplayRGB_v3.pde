

int xPos=0;
int yPos=0;
int zPos=0;

float redVal=0;
float greenVal=0;
float blueVal=0;
 
float zVal=0; 
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
  zPos=int(mouseX/cos(a));
  
  zVal = sqrt(sq(displayWidth)+sq(displayHeight));
  
  redVal    =map(xPos,0,displayWidth,0,255);
  greenVal  =map(yPos,0,displayHeight,0,255);
  blueVal   =map(zPos,0,zVal,0,255);
    
  background(redVal,greenVal,blueVal);
  
  stroke(#FF0000);
  line(0, 0, displayWidth, 0);                  //RED
  
  stroke(#00FF00);
  line(0, 0, 0, displayHeight);                 //GREEN
   
  stroke(#0000FF);
  line(0, 0, displayWidth, displayHeight);      //BLUE
 
  print("Xpos: "+xPos);
  print(" , ");
  print("Ypos: "+yPos);
  print("  ,  ");
  print("Zpos: "+zPos);
  print(" , ");
  println("Angle: "+degrees(a));
  
  textSize(14);
  textAlign(CENTER);
  text("( R , G , B ) "+" : "+" ( "+redVal+" , "+greenVal+" , "+blueVal+" ) ",width/2,80);  
  textAlign(CENTER);
    text("( X , Y , Z ) "+" : "+" ( "+xPos+" , "+yPos+" , "+zPos+" ) ",width/2,60);
  text("( Angle ) "+" : "+" ( "+degrees(a)+" ) ",width/2,100);
  textAlign(CENTER);
  
}
