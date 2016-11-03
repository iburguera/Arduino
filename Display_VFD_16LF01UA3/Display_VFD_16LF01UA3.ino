
/*--------------------------------------------------------------------*/
/*--                     VFD l6LF0lUA3 DISPLAY                      --*/
/*--------------------------------------------------------------------*/

/*--------------------------------------------------------------------*/
/*--  Autor:   Iker Burguera                                        --*/
/*--  Email:   ikerburguera@gmail.com                               --*/
/*--  Date:    l7/06/20l2                                           --*/
/*--  Version: l.0V                                                 --*/
/*--                                                                --*/
/*--  Description: The folLOWing code provides a LOW level method   --*/
/*--               to write data into the VFD l6LF0lUA3 DISPLAY.    --*/
/*--               The code writes a blinking asterisk (*) in the   --*/
/*--               middle of the display.                           --*/
/*--------------------------------------------------------------------*/




/*--------------------------------------*/
/*--             VARIABLES            --*/
/*--------------------------------------*/

int DATA  =  3;             // Digital Pin 3
int SCLK  =  4;             // Digital Pin 4
int RST   =  5;             // Digital Pin 5

/*--------------------------------------*/
/*--               SETUP              --*/
/*--------------------------------------*/

void setup()
{
  Serial.begin(9600);
  pinMode(SCLK,OUTPUT);     // Declare digital Pin 3 oUTPUT
  pinMode(RST,OUTPUT);      // Declare digital Pin 4 oUTPUT 
  pinMode(DATA,OUTPUT);     // Declare digital Pin 5 oUTPUT
  
  resetDisplay();           // Reset the display. RST Pin LOW for ABoVE lms
  numberDisplay();          // Sets the number of characters we are going to use. 0-l6
  brightnessDisplay();      // Sets the brightness of the display
}

/*--------------------------------------*/
/*--             LooP CoDE            --*/
/*--------------------------------------*/

void loop()
{
  setPointer();
  writeAsterisk();
  delay(1000);
  Serial.println("Escrito *");
  
  setPointer();
  writeLetter();
  delay(1000);
  Serial.println("Escrito A");
}

















/*--------------------------------------*/
/*--             FUNCIoNES            --*/
/*--------------------------------------*/


/*------------------------*/
/*--    RESET DISPLAY   --*/
/*------------------------*/

void resetDisplay()                      // Function to reset the display
{
  digitalWrite(RST,LOW);                 // Set RST signal to "0" for above lms
  delay(5);
  digitalWrite(RST,HIGH);                // Set RST signal back to "l"
  delay(5);
}

/*------------------------*/
/*--   NUMBER DISPLAY   --*/
/*------------------------*/

void numberDisplay()                     // Function to set the number of character shown in the display
{ 
  // We are going to use l6 characters from the display. 
  // l6 character = l l 0 0  0 0 0 0
 
  l();  l();  o();  o();  o();  o();  o();  o(); 
}

/*------------------------*/
/*-- BRIGHTNESS DISPLAY --*/
/*------------------------*/

void brightnessDisplay()                // Function to set the brightness of the display
{
  // We are going to use the 75% of the brightness in the display
  // %75 (%74,2) = l l l l  0 0 0 0  
  
  l();  l();  l();  l();  o();  o();  o();  o();   
}

/*------------------------*/
/*--    SET P0INTER     --*/
/*------------------------*/

void setPointer()                // Function to set the  write pointer in the display
{
  // We are going to set the pointer in the middle of the display. 
  // Position 8 = l 0 l 0 0 l l 0 
  
  l(); o(); l(); o(); o(); l(); l(); o();     
}


/*-----------------------*/
/*--   SCLK FALL DoWN  --*/
/*-----------------------*/

void sclkFallDown()                     // Function to set down the SCLK signal                  
{
  digitalWrite(SCLK,HIGH);
  delay(2);
  digitalWrite(SCLK,LOW);
  delay(2);
  digitalWrite(SCLK,HIGH);
  delay(2);
}

/*-----------------------*/
/*--       WRITE 0     --*/
/*-----------------------*/

void o()                                // Function to write a "0" value in DATA. 
{
  digitalWrite(DATA,LOW);               // We set the DATA value to 0
  delay(5);
  sclkFallDown();                       // We call sclkFallDown to send the DATA value
}


/*-----------------------*/
/*--       WRITE l     --*/
/*-----------------------*/

void l()                                // Function to write a "l" value in DATA. 
{
  digitalWrite(DATA,HIGH);              // We set the DATA value to l
  delay(5);
  sclkFallDown();                       // We call sclkFallDown to send the DATA value
}

/*------------------------*/
/*--    WRITEASTERISK   --*/
/*------------------------*/

void writeAsterisk()                    // Function to write an asterisk (*) in the display
{
  // Asterisk * = 0 0 l 0  l 0 l 0      // CoDIGo INTERNET
  // Asterisk * = 0 l 0 l  0 0 l 0      // DATASHEET
  
  o();  l(); o(); l(); o(); o(); l(); o();  
}

/*------------------------*/
/*--    WRITEASTERISK   --*/
/*------------------------*/

void writeLetter()                    // Function to write the letter A in the display
{
  // A = 0 0 0 0  0 0 0 1     
 
  o();  o(); o(); o(); o(); o(); o(); 1();   
}

