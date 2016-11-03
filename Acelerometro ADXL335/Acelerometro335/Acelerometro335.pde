int randNumberX;
int randNumberY;
int randNumberZ;

void setup()
{
  Serial.begin(9600);
}

void loop() 
{
  randNumberX = analogRead(3);
  randNumberY = analogRead(4);
  randNumberZ = analogRead(5);
  
  Serial.print("(X,Y,Z) =>( ");
  Serial.print(randNumberX-340); 
  Serial.print(", ");
  Serial.print(randNumberY-340);  
  Serial.print(", ");
  Serial.print(randNumberZ-340);  
  Serial.println(")");
  delay(100);
}
