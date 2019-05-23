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
PGraphics pantalla;
PGraphics background;

Background fondo;
Composicion composicion;

void setup() {
  //SIEMPRE CUADRADO!!!
  //Composition <drawComposicion> asume que el canvas es cuadrado
  size(700, 700, P3D);
  FRACTALS_LEVEL = 4;
  frameRate(60);
  CANVAS_WIDTH=width;
  CANVAS_HEIGHT=height;
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
  // Detectar precensia
  // Inciar interaccion + Tiempo "juego"
  // Volver a estado incial 1
  */

  fadeGraphics(background, 100);
  fadeGraphics(pantalla, 100);
  background(0);
  
  composicion.render();
}