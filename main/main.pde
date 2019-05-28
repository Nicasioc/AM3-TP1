//@TODO: hay muchas variables globales

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
int ANGLE_REST_MODE;
int ANGLE_ACTIVE_MODE;
int angulo_global; //usado para rotar los fractales
boolean REST_MODE = true; //hay moviento, tiene que actualizar con movimiento

PGraphics pantalla;
PGraphics background;

Background fondo;
Composicion composicion;

void setup() {
  //SIEMPRE CUADRADO!!!??
  //Composition <drawComposicion> asume que el canvas es cuadrado
  size(700, 700, P3D);
  FRACTALS_LEVEL = 4;
  frameRate(60);
  CANVAS_WIDTH=width;
  CANVAS_HEIGHT=height;
  ANGLE_REST_MODE=700;
  ANGLE_ACTIVE_MODE=700/2;
  angulo_global=height;
  fractalHeight=4;
  fractalHeightModifier=1;
  cantidadFractales=6;
  pantalla = createGraphics(CANVAS_WIDTH, CANVAS_HEIGHT,P3D);
  background = createGraphics(CANVAS_WIDTH, CANVAS_HEIGHT,P3D);
  composicion = new Composicion(pantalla, background);
  CROP_SIZE= 200;
  //fondo = new Background();
}

void draw() {
  //@TODO: Como manejar el crop?
  //@TODO: Pasos que faltan
  /*
  // 1 Detectar
  // 2 Inciar interaccion + Tiempo "juego"
  // 3 Volver a estado incial 1
  // 4 lineas que conectan
  // 5 defazar un poco las unidades
  // 6 Estar un tiempo en una zona
  //  - separar la pantalla en dos partes sobre el eje Y
      - un tiempoen una zona cambia un control,un tiempoen otra cambia a otro control
  */

  if (REST_MODE && angulo_global < ANGLE_REST_MODE) {
    angulo_global++;
  }

  if (!REST_MODE && angulo_global > ANGLE_ACTIVE_MODE) {
    angulo_global--;
  }
  
  fadeGraphics(background, 100);
  fadeGraphics(pantalla, 100);
  background(0);
  composicion.render();
}