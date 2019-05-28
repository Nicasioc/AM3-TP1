// flechas, variacion tamano;
//mouse  variacion cantidad y fondo;
//cada vez que arranca toma una textura diferente;
/*
fractalHeightModifier => modifica forma fractal hijo dividiendo fractalHeight por fractalHeightModifier
*/
int fractalHeight, fractalHeightModifier, cantidadFractales;
int CANVAS_WIDTH;
int CANVAS_HEIGHT;
int FRACTALS_LEVEL;
int CROP_SIZE;
int ONE_MINUTE_IN_MILLIS = 60000;
float PLAY_TIME_IN_MINUTES = 1;
/* Animacion inicial */
int ANGLE_REST_MODE;
int angle_active_mode;
float angulo_global; //usado para rotar los fractales
boolean REST_MODE = true; //hay moviento, tiene que actualizar con movimiento
boolean intro_ended = false;
boolean outro_ended = true;
int maxSpeedStart = 10;
int speed = 1;
float accelleration = 2.5;

Timer timer;

/* Buffer fondo y fractales */
PGraphics pantalla;
PGraphics background;
Background fondo;
Composicion composicion;

void setup() {
  //SIEMPRE CUADRADO!!!??
  //Composition <drawComposicion> asume que el canvas es cuadrado
  size(700, 700, P3D);
  frameRate(60);
  FRACTALS_LEVEL = 4;
  CANVAS_WIDTH=width;
  CANVAS_HEIGHT=height;
  ANGLE_REST_MODE=700;
  angle_active_mode=700/2;
  angulo_global=height;
  fractalHeight=4;
  fractalHeightModifier=1;
  cantidadFractales=6;
  pantalla = createGraphics(CANVAS_WIDTH, CANVAS_HEIGHT,P3D);
  background = createGraphics(CANVAS_WIDTH, CANVAS_HEIGHT,P3D);
  composicion = new Composicion(pantalla, background);
  timer = new Timer(ONE_MINUTE_IN_MILLIS*PLAY_TIME_IN_MINUTES);
  CROP_SIZE= 200;
  //fondo = new Background();
}

void draw() {
  //@TODO: Como manejar el crop?
  //@TODO: Pasos que faltan
  /*
  // 1 Detectar
  // * Inciar interaccion + Tiempo "juego"
  // * Volver a estado incial 1
  // 4 lineas que conectan
  // 5 defazar un poco las unidades
  // 6 Estar un tiempo en una zona
  //  - separar la pantalla en dos partes sobre el eje Y
      - un tiempoen una zona cambia un control,un tiempoen otra cambia a otro control
  */
 
  if (REST_MODE && outro_ended) {
    float vibracion = map(noise(frameRate)*ANGLE_REST_MODE, 0.0, float(ANGLE_REST_MODE), float(ANGLE_REST_MODE-50), float(ANGLE_REST_MODE));
    angulo_global = vibracion;
  }

 if (!REST_MODE && !intro_ended && angulo_global <= angle_active_mode) {
   intro_ended = true;
   outro_ended = false;
 }

  if (REST_MODE && !outro_ended && angulo_global >= ANGLE_REST_MODE) {
    outro_ended = true;
  }

  if (REST_MODE && angulo_global < ANGLE_REST_MODE) {
    angulo_global+=5;
  }

  if (!REST_MODE && !intro_ended) {
    //es mouseY asi no salta cuando termina y el usuario tiene control desde el comienzo
    angle_active_mode = mouseY;
    if (speed < maxSpeedStart) {
      speed+=accelleration;
    }
    angulo_global-=speed;
  }

  if (timer.isTimeMarkReached()) {
    REST_MODE = true;
  }

  fadeGraphics(background, 100);
  fadeGraphics(pantalla, 100);
  background(0);
  composicion.render();
  
}