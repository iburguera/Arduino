#include <SoftwareSerial.h>

#define txPin 9										// Pin de Transmision

SoftwareSerial LCD = SoftwareSerial(0, txPin);                                          // since the LCD does not send data back to the Arduino, we should only define the txPin

const int LCDdelay=10;                                                                  // conservative, 2 actually works

void setup()
{
  pinMode(txPin, OUTPUT);
  LCD.begin(9600);
  clearLCD();
  lcdPosition(0,0);
  //backlightOn();
  //LCD.print("Hello world!");
}

void loop()
{
  lcdPosition(0,1); 
  LCD.print("IKER");
  lcdPosition(0,7); 
  LCD.print("BURGUERA");
  delay(100);
  
}






void lcdPosition(int row, int col)                                                       // Goto with row & column 
{
  LCD.write(0xFE);                                                                       //command flag
  LCD.write((col + row*64 + 128));                                                       //position 
  delay(LCDdelay);
}

void clearLCD()                                                                          //Limpiamos el LCD
{
  LCD.write(0xFE);                                                                       //command flag
  LCD.write(0x01);                                                                       //clear command.
  delay(LCDdelay);
}

void backlightOn()                                                                       //turns on the backlight
{  
  LCD.write(0x7C);   //command flag for backlight stuff
  LCD.write(157);    //light level.
  delay(LCDdelay);
}

void backlightOff()
{  //turns off the backlight
  LCD.write(0x7C);   //command flag for backlight stuff
  LCD.write(128);     //light level for off.
  delay(LCDdelay);
}

void serCommand()
{   //a general function to call the command flag for issuing all other commands   
  LCD.write(0xFE);
}
