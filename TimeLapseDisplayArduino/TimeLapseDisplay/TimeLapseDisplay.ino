#include <LiquidCrystal.h>

LiquidCrystal lcd(8, 13, 9, 4, 5, 6, 7); 

int pinPotentiometer       = 1;

int potValue = 0;
int valMap1 = 0;

unsigned long time;

int counter_foto           = 0;
int counter_rpm            = 0;

unsigned int horas         = 0;
unsigned int minutos       = 0;
unsigned int segundos      = 0;

int delayPhoto             = 100;

int keyPressed             = 0;



byte p20[8] = {
  B10000,
  B10000,
  B10000,
  B10000,
  B10000,
  B10000,
  B10000,
};
byte p40[8] = {
  B11000,
  B11000,
  B11000,
  B11000,
  B11000,
  B11000,
  B11000,
};
byte p60[8] = {
  B11100,
  B11100,
  B11100,
  B11100,
  B11100,
  B11100,
  B11100,
};
byte p80[8] = {
  B11110,
  B11110,
  B11110,
  B11110,
  B11110,
  B11110,
  B11110,
};
byte p100[8] = {
  B11111,
  B11111,
  B11111,
  B11111,
  B11111,
  B11111,
  B11111,
};

void setup()
{
  Serial.begin(9600);
  pinMode(pinPotentiometer, INPUT);

  lcd.clear(); 
  lcd.begin(16, 2);
  
  lcd.createChar(0, p20);
  lcd.createChar(1, p40);
  lcd.createChar(2, p60);
  lcd.createChar(3, p80);
  lcd.createChar(4, p100);
  
  printIntro();
  printLoading();
    
  time = millis();

  
}



void loop()
{
  
  keyPressed = analogRead(0);
  
  if(keyPressed==1023)                                  // SIN PULSAR NINGUN BOTON 
  {
     lcd.clear(); 
     printTime(); 
     printRPM();
     printVelocity();
     counter_foto++;
  }
  
  if(keyPressed==641)                                   // BOTON SELECT       //PLAY
  {
     Serial.println("BOTON: SELECT");
     delay(20);
     delayPhoto=100;
  }
  
  if(keyPressed==408)                                   // BOTON IZQUIERDO
  {
    Serial.println("BOTON: IZQUIERDO");
    delay(80);
  }
  
  if(keyPressed==0)                                     // BOTON DERECHO
  {
    Serial.println("BOTON: DERECHO");
    delay(80);
  }
  
  if(keyPressed==255)                                   // BOTON DOWN          //PAUSE 
  {
    Serial.println("BOTON: ABAJO");
    delay(80);
  }
  
  if(keyPressed==99)                                    // BOTON UP            //STOP
  {
    Serial.println("BOTON: ARRIBA");
    delay(80);
    //reset();
  }
  
  
 
  delay(delayPhoto);
  
  
}

void printVelocity()
{
  //PRINT TEXT
  lcd.setCursor(8,1); 
  lcd.print("VEL:");
  
  //PRINT DATA
  lcd.setCursor(12,1);  
  potValue = analogRead(1);
  valMap1 = map(potValue,0,1024,0,101);
  lcd.print(valMap1);
  
  lcd.setCursor(15,1);
  lcd.print("%");
  
}
 
void printLoading()
{
  lcd.clear();
  lcd.setCursor(1,0);
  lcd.print("IKER BURGUERA"); 
  
  lcd.setCursor(0,1);
  lcd.print("                ");   
 
   for (int i = 0; i<16; i++)
   {  
     for (int j=0; j<5; j++)
     {
      lcd.setCursor(i, 1);   
      lcd.write(j);
      delay(100);
     } 
   }
}


void printIntro()
{
  lcd.setCursor(3,0); 
  lcd.print("TIME LAPSE");
  lcd.setCursor(4,1); 
  lcd.print("ARDUINO");
  delay(5000);
}

void printRPM()
{
  lcd.setCursor(0,1); 
  lcd.print("RPM:");
  lcd.setCursor(4,1); 
  lcd.print(valMap1);
}


void incTime() 
{
  segundos++;
 
  if (segundos == 60) 
  {   
    segundos = 0;
    minutos++;

    if (minutos == 60)
    {
      minutos = 0;
      horas++;
 
      if (horas == 24) 
      {      
         horas = 0;    
      }
    }
  }
}
 

void printTime() 
{
  incTime();
  
  lcd.setCursor(1,0); 
  lcd.print("TIME:");
  
  lcd.setCursor(7,0);
  char time[17];
  sprintf(time, "%02i:%02i:%02i", horas, minutos, segundos);
  lcd.print(time);
}

  
  










