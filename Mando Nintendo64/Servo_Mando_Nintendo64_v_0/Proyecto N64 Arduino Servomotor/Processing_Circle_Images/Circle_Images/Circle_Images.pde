/*---------------------------------------------------------
 *             Nintendo 64 Controller + Servomotor         * 
-----------------------------------------------------------*/

/*----------------------------------  
  *  Autor: Iker Burguera
  *  Date : 24/09/2013
  *  email: ikerburguera@gmail.com
------------------------------------*/    

// Programa que mueve un servomotor a un angulo concreto(0,45,90,135,...) segun la tecla pulsada en el mando de la Nintendo 64
// MUY IMPORTANTE: Para agregar la imagen: Sketch -> Add file 




PImage img_C_UP,img_C_DOWN,img_C_LEFT,img_C_RIGHT,img_Button_A,img_Button_B,img_Button_LEFT,img_Button_RIGHT;

int   circle_value;
float radius_value;
float images_value   =  76;
int   const_value;

void setup() 
{
  size(displayWidth,displayHeight);
  background(255);
  
  img_Button_A        = loadImage("Button_A.png");
  img_Button_B        = loadImage("Button_B.png");
  img_C_DOWN          = loadImage("Button_C_Down.png");
  img_C_LEFT          = loadImage("Button_C_Left.png");
  img_C_RIGHT         = loadImage("Button_C_Right.png");
  img_C_UP            = loadImage("Button_C_Up.png");
  img_Button_LEFT     = loadImage("Button_Left.png");
  img_Button_RIGHT    = loadImage("Button_Right.png");
 
 
  const_value         = 300; 
  circle_value        = get_Shortest_Side(displayWidth,displayHeight)-const_value;
  radius_value        = circle_value/2; 
}

void draw() 
{
   
   fill(0,153,204);
   ellipse(displayWidth/2,displayHeight/2,circle_value,circle_value);   
   
   
   
   imageMode(CENTER);
   
   image(img_C_UP    ,displayWidth/2,(displayHeight/2)-radius_value,images_value,images_value);
   image(img_C_DOWN  ,displayWidth/2,(displayHeight/2)+radius_value,images_value,images_value);
   image(img_C_LEFT  ,(displayWidth/2)-radius_value,(displayHeight/2),images_value,images_value);
   image(img_C_RIGHT ,(displayWidth/2)+radius_value,(displayHeight/2),images_value,images_value);

  
   image(img_Button_RIGHT    ,(displayWidth/2)+(radius_value*cos(radians(45))),(displayHeight/2)-(radius_value*cos(radians(45))),images_value,images_value);
   image(img_Button_LEFT     ,(displayWidth/2)-(radius_value*cos(radians(45))),(displayHeight/2)-(radius_value*cos(radians(45))),images_value,images_value);
   image(img_Button_B        ,(displayWidth/2)-(radius_value*cos(radians(45))),(displayHeight/2)+(radius_value*cos(radians(45))),images_value,images_value);
   image(img_Button_A        ,(displayWidth/2)+(radius_value*cos(radians(45))),(displayHeight/2)+(radius_value*cos(radians(45))),images_value,images_value);
    
   println("Display WIDTH :  "+displayWidth);
   println("Display HEIGHT:  "+displayHeight);
   println("Circle Value  :  "+circle_value);
}

int get_Shortest_Side(int displayWidth, int displayHeight)
{
    int circle_value;
    
    if(displayWidth>displayHeight)
    {
        circle_value  = displayHeight;
    }
    else
    {
        circle_value  =displayWidth;
    }
    return(circle_value);
}









