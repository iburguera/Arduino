

void setup()
{
  Serial.begin(9600);
}

void loop() 
{
  for (int i=0;i<=255;i++)
  {
        Serial.println(i);
        delay(100);  
  }
  for (int i=255;i>=0;i--)
  {
        Serial.println(i);
        delay(100);  
  }
  delay(500);
}
