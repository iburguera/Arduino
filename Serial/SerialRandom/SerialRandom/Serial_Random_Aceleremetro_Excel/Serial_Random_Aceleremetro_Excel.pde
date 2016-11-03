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
  
  Serial.print(randNumberX); 
  Serial.print(", ");
  Serial.print(randNumberY);  
  Serial.print(", ");
  Serial.print(randNumberY); 
  Serial.println(""); 
  delay(1000);
}
