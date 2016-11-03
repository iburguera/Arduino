int randNumberX;
int randNumberY;
int randNumberZ;

void setup()
{
  Serial.begin(9600);
}

void loop() 
{
  randNumberX = random(50);
  randNumberY = random(50);
  randNumberZ = random(50);
  
  Serial.print('S');
  Serial.print(' ');
  Serial.print(randNumberX); 
  Serial.print(' ');
  Serial.print(randNumberY);  
  Serial.print(' ');
  Serial.print(randNumberZ); 
  Serial.print(' ');
  Serial.print('F');
  Serial.println(); 
  delay(100);
}
