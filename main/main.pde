// import TSPS
import tsps.*;
TSPS tspsReceiver;

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
int ANGLE_rest_mode;
int angle_active_mode;
float angulo_global; //usado para rotar los fractales
boolean rest_mode = true; //hay moviento, tiene que actualizar con movimiento
TSPSPerson person = null;
boolean intro_ended = false;
boolean outro_ended = true;
int maxSpeedStart = 10;
int speed = 1;
float accelleration = 2.5;

Timer timer;

/* Buffer fondo y fractales */
PGraphics pantalla;
PGraphics background;
PGraphics debugScreen;
Background fondo;
Composicion composicion;

void setup() {
  //SIEMPRE CUADRADO!!!??
  //Composition <drawComposicion> asume que el canvas es cuadrado
  size(700, 700, P3D);
  CROP_SIZE= 500;
  frameRate(60);
  FRACTALS_LEVEL = 4;
  CANVAS_WIDTH=width;
  CANVAS_HEIGHT=height;
  ANGLE_rest_mode=700;
  angle_active_mode=700/2;
  angulo_global=height;
  fractalHeight=4;
  fractalHeightModifier=1;
  cantidadFractales=6;
  pantalla = createGraphics(CANVAS_WIDTH, CANVAS_HEIGHT,P3D);
  background = createGraphics(CANVAS_WIDTH, CANVAS_HEIGHT,P3D);
  debugScreen = createGraphics(CANVAS_WIDTH, CANVAS_HEIGHT,P3D);
  composicion = new Composicion(pantalla, background);
  timer = new Timer(ONE_MINUTE_IN_MILLIS*PLAY_TIME_IN_MINUTES);
  tspsReceiver= new TSPS(this, 12000);
  //fondo = new Background();
}

void draw() {
 
  if ( timer.hasTimestamp() && timer.isMaredTimeReached()) {
    println("time ended");
    restartApp();
  }

  if (rest_mode && outro_ended) {
    println("estado incial");
    float vibracion = map(noise(frameRate)*ANGLE_rest_mode, 0.0, float(ANGLE_rest_mode), float(ANGLE_rest_mode-50), float(ANGLE_rest_mode));
    angulo_global = vibracion;
  } else if (rest_mode && angulo_global < ANGLE_rest_mode) {
    println("volviendo a reposo");
    angulo_global+=5;
  } else if (!rest_mode && !intro_ended) {
    println("mostrando inicio");
    if (speed < maxSpeedStart) {
      speed+=accelleration;
    }
    angulo_global-=speed;
  }
  if (!rest_mode && !intro_ended && angulo_global <= angle_active_mode) {
   println("terminó animacion inicio");
   intro_ended = true;
  }

  if (rest_mode && !outro_ended && angulo_global >= ANGLE_rest_mode) {
    println("terminó animacion salida");
    outro_ended = true;
  }

  fadeGraphics(background, 100);
  fadeGraphics(pantalla, 100);
  background(0);

  if (!rest_mode && outro_ended) {
    background.text("Shipido", width/2, 200);
  }

  composicion.render();
}