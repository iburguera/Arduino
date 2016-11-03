/*--------------------------------------------------------------------*/
/*--                    Proyecto AIRSOFT Castrillo                  --*/
/*--------------------------------------------------------------------*/

/*--------------------------------------------------------------------*/
/*--  Proyecto:   Proyecto Airsoft Castrillo                        --*/
/*--  Autor   :   Iker Burguera                                     --*/
/*--  Email   :   ikerburguera@gmail.com                            --*/
/*--  Date    :   23/04/2014                                        --*/
/*--  Version :   1.0                                               --*/
/*--                                                                --*/
/*--  Description: Proyecto que simula el funcionamiento de una     --*/
/*--  bomba como las que  salen  en las peliculas de Hollywood.     --*/
/*--  No me hago responsable del mal uso que se le pueda dar.       --*/
/*--------------------------------------------------------------------*/


#include <SoftwareSerial.h>
#include <Keypad.h>


          
#define txPin 13										// Pin de Transmision

SoftwareSerial LCD = SoftwareSerial(0, txPin);                                          // since the LCD does not send data back to the Arduino, we should only define the txPin




const int LCDdelay=10;                                                                  // conservative, 2 actually works

const byte ROWS = 4; //four rows
const byte COLS = 3; //three columns

char keys[ROWS][COLS] = 
{
    {'1','2','3'},
    {'4','5','6'},
    {'7','8','9'},
    {'*','0','#'}
};

byte rowPins[ROWS] = {5, 4, 3, 2}; //connect to the row pinouts of the keypad
byte colPins[COLS] = {8, 7, 6}; //connect to the column pinouts of the keypad

Keypad keypad = Keypad( makeKeymap(keys), rowPins, colPins, ROWS, COLS );

const int passwordLength = 6;                                                                  // Definimos cuantos digitos queremos que tenga nuestra contraseña
int  currentLength        = 0;                                                                  // Define que numero de la contraseña estamos escribiendo actualmente sobre el teclado
char password[passwordLength];                                                                 // Almacena la contraseña o codigo de ACTIVACION/DESACTIVACION
char codIntro[passwordLength];                                                                 // Almacena los valores de los códigos introducidos

int i = 0; 
int j = 0;
int delayCountDown = 800;
char entered[5];                                                                               // Almacena el codigo introducido por el teclado para compararlo con el almacenado en password[5]

char horas[2];                                                                          // Definimos buffer las  HORAS
char minutos[2];                                                                          // Definimos buffer los  MINUTOS
char segundos[2];                                                                         // Definimos buffer los  SEGUNDOS

unsigned int horasTotal;                                                                          // Definimos  las  HORAS
unsigned int minutosTotal;                                                                          // Definimos  los  MINUTOS
unsigned int segundosTotal;                                                                         // Definimos  los  SEGUNDOS

int bufferTiempo[3];

int intentos = 5;
int posicion = 5;
int countPos = 0;

int cables[5] = {1,1,1,1,1};

const int digitosLenght    = 2;                                                                // Definimos que longitud tienen que debe tener cada HORA, cada MINUTO y cada SEGUNDOS. HORA: 00(2)  MINUTO: 00(2)  SEGUNDO: 00(2)
const int maxDigitosTiempo = 6;                                                                // Definimos la longitud total que tener las HORAS, MINUTOS y SEGUNDOS. HORA: 00(2) + MINUTO: 00(2) + SEGUNDO: 00(2) = 6

int keySwitch =  0;




void setup()
{
    Serial.begin(9600);   
    pinMode(12, INPUT);
    pinMode(11, OUTPUT);
    LCD.begin(9600);
    clearLCD();
    lcdPosition(0,0);
    backlightOn();
    
    
    
    keypad.addEventListener(keypadEvent); // Add an event listener for this keypad
    
    introduccionJuego();
      
}

void loop()
{
  if(digitalRead(12))
  {
       switch(keySwitch)
       {
          case 0 : //tone(11, 440, 500);                  
                   introduceTiempoPartida();                 
                   convertirDigitosTiempoPartidaInteger();                
                   introduceCodigoActivacion();
                   keySwitch = 1; 
                   break;
                   
          case 1 : comprobarCables();
                   leerCodigo(); 
                   countDown(); 
                   ponerTiempo();  
                   ponerPantallaCodigo();
                   ponerIntentosRestantes();
                   break;
       } 
   }
   else
   {
      Serial.println("Sin Activar");
      delay(500);
   }
}

void comprobarCables()
{
    cables[0] = analogRead(0);
    cables[1] = analogRead(1);
    cables[2] = analogRead(2);
    cables[3] = analogRead(3);
    cables[4] = analogRead(4);
    
    Serial.print("( ");
    Serial.print(cables[0]);
    Serial.print(" , ");
    Serial.print(cables[1]);
    Serial.print(" , ");
    Serial.print(cables[2]);
    Serial.print(" , ");
    Serial.print(cables[3]);
    Serial.print(" , ");
    Serial.print(cables[4]); 
    Serial.print("  )");
    Serial.println();
    
    if(cables[0]<1015)                            // AUMENTA VELOCIDAD +4
    {
       tone(11, 1200, 300);
       delay(700);
       tone(11, 1200, 300);
       delay(700);
       delayCountDown=250;
       Serial.println("AUMENTA VELOCIDAD +4");
       
    }
    if(cables[1]<1015)                            // PONE LA BOMBA EN NORMALIDAD
    {
       delayCountDown=1000;
       Serial.println("VELOCIDAD NORMAL");
       
    }
    if(cables[2]<1015)                            // SE DETIENE
    {
      bombaDesactivada();
      Serial.println("BOMBA DESACTIVADA");
     
    }
    if(cables[3]<1015)                            // EXPLOTA
    {
       Serial.println("EXPLOSION");
       bombaExplosion();
       
    }
    if(cables[4]<1015)                            // AUMENTA VELOCIDAD +2
    {
       tone(11, 600, 300);
       delay(700);
       tone(11, 600, 300);
       delay(700);
       Serial.println("AUMENTA VELOCIDAD +2");
       delayCountDown=500;
    }
    
}

void leerCodigo()
{
   if(j < passwordLength)
   {
    lcdPosition(1, 5+j);
    
    char key = keypad.getKey();
    key == NO_KEY;
    if (key != NO_KEY)
    {
      if ((key != '*')&&(key != '#'))
      { 
        LCD.print(key);
        codIntro[j] = key;
        j++;
        //tone1.play(NOTE_C6, 200);
      }
    }
  }
   comprobarCodigo(); 
}

void ponerPantallaCodigo()
{
    lcdPosition(1,0); 
    LCD.print("COD:");
    
    //Leer Codigo del teclado 
    //Comprobar Codigo

}

void bombaDesactivada()
{
    clearLCD();
    lcdPosition(0, 5);
    LCD.print("BOMBA");
    lcdPosition(1, 1);
    LCD.print("DESACTIVADA :)");
    tone(11, 800, 300);
    delay(700);
    tone(11, 800, 300);
    delay(700);
    tone(11, 800, 300);
    delay(1000000);  
}

void bombaExplosion()
{
    clearLCD();
    lcdPosition(0, 5);
    LCD.print("BOOM!");
    lcdPosition(1, 2);
    LCD.print("ESTAS MUERTO!");
    tone(11, 200, 2500);
    delay(1000000);
}

void comprobarCodigo()
{
  if(j==passwordLength)
  {
     if(codIntro[0]==password[0] && codIntro[1]==password[1] && codIntro[2]==password[2] && codIntro[3]==password[3] && codIntro[4]==password[4] && codIntro[5]==password[5])
     {
          bombaDesactivada();
     } 
     else
     {
        lcdPosition(1, 5);
        LCD.print("ERROR!");
        tone(11, 200, 300);
        delay(500);
        
        if(intentos>0)
        {
          intentos--;
        }
        else
        {
           bombaExplosion();
        }      
        j=0;
        clearLCD();
     } 
  }  
}

void ponerIntentosRestantes()
{
    lcdPosition(1,15); 
    LCD.print(intentos);
}

void ponerTiempo()
{  
     char bufferTiempo[9]=""; 
     sprintf(bufferTiempo, "%02d:%02d:%02d", horasTotal, minutosTotal, segundosTotal); 
     lcdPosition(0,4);   LCD.print(bufferTiempo);
    
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

// Taking care of some special events.
void keypadEvent(KeypadEvent key)
{
    
}

void introduceTiempoPartida()
{
  int count = 0;
  
  lcdPosition(0,3); 
  LCD.print("INTRODUCE");
  lcdPosition(1,1); 
  LCD.print("TIEMPO PARTIDA");
  
  delay(1000);
  clearLCD();
  
  lcdPosition(0,1); 
  LCD.print("TIEMPO PARTIDA");
  
  lcdPosition(1,1); 
  LCD.print("H:");
  lcdPosition(1,6);
  LCD.print("M:");
  lcdPosition(1,11);
  LCD.print("S:"); 
  
 

  
  while (currentLength < maxDigitosTiempo)
  {
   
    
    char key = keypad.getKey();
    key == NO_KEY;
    if (key != NO_KEY)
    {
      if ((key != '*')&&(key != '#'))
      { 
         switch(count)
         {
           case 0 :   lcdPosition(1,3);              // HORA     (1,3)
                      LCD.print(key);
                      currentLength++;
                      horas[0]=key;
                      count++;
                      break; 
                      
           case 1 :   lcdPosition(1,4);              // HORA     (1,4)
                      LCD.print(key);
                      currentLength++;
                      horas[1]=key;
                      count++;
                      break;
                      
           case 2 :   lcdPosition(1,8);              // MINUTO   (1,8)
                      LCD.print(key);
                      currentLength++;
                      minutos[0]=key;
                      count++;
                      break; 
                      
           case 3 :   lcdPosition(1,9);              // MINUTO   (1,9)
                      LCD.print(key);
                      currentLength++;
                      minutos[1]=key;
                      count++;
                      break; 
                      
           case 4 :   lcdPosition(1,13);              // SEGUNDO  (1,13)
                      LCD.print(key);
                      currentLength++;
                      segundos[0]=key;
                      count++;
                      break; 
                      
           case 5 :   lcdPosition(1,14);              // SEGUNDO  (1,14)
                      LCD.print(key);
                      currentLength++;
                      segundos[1]=key;
                      count++;
                      break;
           case 6 :   delay(1500);count=0;break;           
         }//Switch 
      }// if * #
    }// if NOKEY
     
  } //while
  currentLength=0;
  delay(3000);
  clearLCD();
  
  
}

void convertirDigitosTiempoPartidaInteger()
{
    int hora0      =  horas[0]      -  '0';           // Convertimos el char a integer quitandole el valor de '0' de la tabla ASCII 
    int hora1      =  horas[1]      -  '0';
    int minuto0    =  minutos[0]    -  '0';
    int minuto1    =  minutos[1]    -  '0';
    int segundo0   =  segundos[0]   -  '0';
    int segundo1   =  segundos[1]   -  '0';

    horasTotal     =  (hora0*10)+hora1;
    minutosTotal   =  (minuto0*10)+minuto1;
    segundosTotal  =  (segundo0*10)+segundo1;


    
}

void countDown()
{
    if(horasTotal == 0)
    {
     	if(minutosTotal == 0 && segundosTotal != 0)
	{
             segundosTotal--; 
             if(segundosTotal>10)
             {
               tone(11, 440, 200);
               tone(11, 440, 100);
               delay(100);
               tone(11, 440, 100);
               delay(100);
             }
             else
             {  
               tone(11, 440, 200);
             } 
        }
        
	if(minutosTotal != 0 && segundosTotal == 0)
	{
             minutosTotal--;
             segundosTotal = 59;
        }
        
	if(minutosTotal != 0  && segundosTotal != 0)
	{
             segundosTotal--;
        }
    }

    if(horasTotal != 0)
    {
        if(minutosTotal == 0 && segundosTotal == 0)
	{
             horasTotal--;
             minutosTotal = 59;
             segundosTotal = 59;
        }
       
	if(minutosTotal == 0 && segundosTotal != 0)
	{
             segundosTotal--; 
        }
        
	if(minutosTotal != 0 && segundosTotal == 0)
	{
             minutosTotal--;
             segundosTotal = 60;
        }
        
	if(minutosTotal != 0  && segundosTotal != 0)
	{
             segundosTotal--;
        }
    }
    
    if(horasTotal==0 && minutosTotal==0 && segundosTotal==0)
    {
       bombaExplosion();
    }
    
    
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    leerCodigo(); 
    delay(delayCountDown/20);
    
}


void introduceCodigoActivacion()
{ 

  
  lcdPosition(0,0); 
  LCD.print("INTRODUCE CODIGO");
  lcdPosition(1,2); 
  LCD.print("DE ACTIVACION");
  
  delay(1000);
  clearLCD();
  
  lcdPosition(0,1); 
  LCD.print("COD. ACTIVACION");
  
  while (currentLength < passwordLength)
  {
    lcdPosition(1, 5+currentLength);
    
    char key = keypad.getKey();
    key == NO_KEY;
    if (key != NO_KEY)
    {
      if ((key != '*')&&(key != '#'))
      { 
        LCD.print("*");
        password[currentLength] = key;
        currentLength++;
        //tone1.play(NOTE_C6, 200);
      }
    }
  }
   delay(4000);
   clearLCD();
   
  if (currentLength == passwordLength)
  {
    lcdPosition(0,0); 
    LCD.print("COD. INTRODUCIDO");
    lcdPosition(1,5); 
      
    LCD.print(password[0]);
    LCD.print(password[1]);
    LCD.print(password[2]);
    LCD.print(password[3]);
    LCD.print(password[4]);
    LCD.print(password[5]);

    //tone1.play(NOTE_E6, 200);
    delay(6000);
    clearLCD();
    
        
        lcdPosition(0, 5);
        LCD.print("BOMBA");
        lcdPosition(1, 4);
        LCD.print("ACTIVADA");
        tone(11, 800, 300);
        delay(700);
        tone(11, 800, 300);
        delay(700);
        tone(11, 800, 300);
        delay(2000);
        clearLCD();    
    
    lcdPosition(0,4); 
    LCD.print("-CORRE-");
    lcdPosition(1,7); 
    LCD.print(":)");      
    
    delay(2000);
    clearLCD();
    
    currentLength = 0;
  }
  
  
}

void introduccionJuego()
{
  lcdPosition(0,5); 
  LCD.print("JUEGO");
  lcdPosition(1,4); 
  LCD.print("AIRSOFT");
  
  delay(3000);
  //clearLCD();
  
 
}
