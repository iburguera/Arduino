/*
     RGB LED ARDUINO
*/
 
int redPin    = 6;
int greenPin  = 5;
int bluePin   = 3;

int valRed    = 0;
int valGreen  = 0;
int valBlue   = 0;

int i,j,k=0;
 
void setup()
{
  Serial.begin(9600);           // start serial for output
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);  
}
 
void loop()
{ 
   setColor(255,0,0);
   delay(2000);
   setColor(0,255,0);
   delay(2000);
   setColor(0,0,255);
   delay(2000);
   
}
 
void setColor(int red, int green, int blue)
{
  analogWrite(redPin, red);
  analogWrite(greenPin, green);
  analogWrite(bluePin, blue);  
}
