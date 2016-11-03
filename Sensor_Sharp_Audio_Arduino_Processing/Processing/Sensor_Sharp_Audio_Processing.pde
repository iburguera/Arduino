/*--------------------------------------------------------------------*/
/*--             SENSOR PROXIMIDAD SHARP + PROCESSING               --*/
/*--------------------------------------------------------------------*/

/*--------------------------------------------------------------------*/
/*--  Proyecto:   Sensor Proximidad + Processing (Audio+Image)      --*/
/*--  Autor   :   Iker Burguera                                     --*/
/*--  Email   :   ikerburguera@gmail.com                            --*/
/*--  Date    :   21/07/2013                                        --*/
/*--  Version :   1.0                                               --*/
/*--                                                                --*/
/*--  Desc: Utilizando 2 sensores de proximidad Sharp GP2Y0A21YK    --*/
/*--  vamos a reproducir sonidos y mostrar imagenes cuando el       --*/
/*--  sensor detecte un objeto cerca.                               --*/
/*--                                                                --*/
/*--------------------------------------------------------------------*/


import ddf.minim.*;                                                         // Cargamos libreria Minim para poder reproducir sonidos
import processing.serial.*;                                                 // Cargamos libreria Serial para poder recibir datos de a linea serie

Minim minim;                                                                // Definimos el objeto minim                                                         
AudioPlayer song_play;                                                      // Definimos el objeto song_play para poder cargar ficheros *.mp3, *.wav, etc

Serial myPort;                                                              // Definimos el objeto myPort para leer datos de la linea serie
byte[] inBuffer = new byte[10];                                             // Buffer para guardar los datos que vienes de la linea serie

PImage img_display;                                                         // Definimos el objeto img_display para cargar imagenes a mostrar

String song_vader  =  "vader.mp3";                                          // Definimos ruta para la cancion vader.mp3
String song_bomb   =  "bomb.mp3";                                           // Definimos ruta para la cancion bomb.mp3
String img_vader   =  "vader.png";                                          // Definimos ruta para la imagen vader.png
String img_bomb    =  "bomb.png";                                           // Definimos ruta para la imagen bomb.png

String myString    =  "";                                                   // Definimos variable myString para tratar los datos de la linea serie
String[] list      = new String[1];                                         // Creamos un array para separar los datos de los sensores 1 y 2 proveninetes de la linea serie. Los datos estan separados por comas. ---> Sensor1_data , Sensor2_data



int sensor1_val    =   0;                                                   // Variable para guardar valor integer del sensor 1
int sensor2_val    =   0;                                                   // Variable para guardar valor integer del sensor 2
int umbral         = 260;                                                   // Variable con la que definiremos el umbral de activacion para mostrar imagenes y reproducirsonidos
 
void setup()                                                                // Metodo para establecer el setup
{
  size(512, 512);                                                           // Dibujamos el lienzocon las medidas 512x512. Las imagenes vader.png y bomb.png deben tener esta resolucion
  background(0);                                                            // Establecemos el fondo negro como inicio cuando todavia no se muestra ninguna imagen
  
  myPort = new Serial(this, Serial.list()[4], 115200);                      // Configuramos el puerto serial y la velocidad en baudios
  minim = new Minim(this);                                                  // Creamos el objeto nimim  
  
}
 
void draw()                                                                 // Metodo para ejecutar continuamente el codigo                                                               
{
  while (myPort.available() > 0)                                            // Comprobamos si existe algun datos disponible en la linea serie
  {
    int lf = 10;                                                            // Variable con el valor de final de linea
  
    myPort.readBytesUntil(lf, inBuffer);                                    // Leemos los valores en el puerto serie hasta que encuentre un final de linea y lo almacenamos en inBuffer
    
    if (inBuffer != null)                                                   // Si inbuffer no es null, leemos los valores que tiene dentro
    {
      myString = new String(inBuffer);                                      // Convertimos los valores existentes en inBuffer aun String para tratarlos mejor
      
      processingSerialData(myString);                                       // Funcion para procesar y tratar los datos de myString. Aqui definiremos que imagen se debe mostrar y que sonido se debe ejecutar
      
      display_img_play_song();                                              // Funcion para mostrar la imagen definida y reproducir el audio del metodo anterior
    }  
  }
}
 

/*--------------------------------------*/
/*--             FUNCION              --*/
/*--------------------------------------*/
 

void processingSerialData(String myString)                                  // Funcion para procesar y tratar los datos de myString. Aqui definiremos que imagen se debe mostrar y que sonido se debe ejecutar                                
{
      list = split(myString, ',');                                          // Separamos los datos de los sensores 1 y 2 alojados en myString que estan separados por Comas. 
      
      list[0] = trim(list[0]);                                              // Eliminamos cualquier caracter vacio que no nos sirva con la funcion trim()
      list[1] = trim(list[1]);                                              // Eliminamos cualquier caracter vacio que no nos sirva con la funcion trim()
            
      sensor1_val  =  int(list[0]);                                         // Valor del Sensor 1
      sensor2_val  =  int(list[1]);                                         // Valor del Sensor 2
      
      print(list[0]);                                                       // Mostramos los valores de los Sensores 1 y 2
      print(",");
      print(list[1]);
      println(); 
}

void display_img_play_song ()                                               // Funcion para mostrar la imagen definida y reproducir el audio del metodo anterior
{
    if(sensor1_val>umbral)                                                  // Si el valor del sensor 1 es mayor que el umbral... 
    {
         playSong(song_bomb);                                               // Establecemos el sonido de la bomba/misil al caer. Pasamos el valor del String song_bomb  =  "bomb.mp3"; 
         displayImage(img_bomb);                                            // Establecemos la imagen de una bomba/misil en pantalla. Pasamos el valor del String img_bomb  =  "bomb.png"; 
    }
    
    if(sensor2_val>umbral)                                                  // Si el valor del sensor 2 es mayor que el umbral...
    {
         playSong(song_vader);                                              // Establecemos el sonido de la marcha imperial de Darth Vader.Pasamos el valor del String song_vader  =  "vader.mp3";
         displayImage(img_vader);                                           // Establecemos la imagen de Darth Vader en pantalla. Pasamos el valor del String img_vader  =  "vader.png";
    }
}


void playSong (String song_name)                                            // Funcion reproducir la cancion definimos segun el sensor activado                                        
{
    song_play = minim.loadFile(song_name);                                  // La cancion que se cargue dependera del sensor que se haya activado
    song_play.rewind();                                                     // En caso de que se haya reproducido anteriormente utilizaremos el metodo rewind para hacer sonar la cancion cada vez que se active el sensor
    song_play.play();                                                       // Reproducimos la cancion
}

void displayImage  (String img_name)                                        // Funcion para mostrar la imagen segun el sensor activado
{
    background(0);                                                          // Dibujamos el fondo en negro para borrar la imagen si la hubiera.
    img_display = loadImage(img_name);                                      // Cargamos la imagen en el objeto img_display.
    image(img_display, 0, 0);                                               // Dibujamos la imagen en la pantalla con origen x=0 y=0
}
 
void stop()                                                                 // Funcion para parar la cancion una vez terminada 
{
  song_play.close();
  minim.stop();
  super.stop();
}
