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
  fractalHeightModifier=2;
  cantidadFractales=1 ;
  pantalla = createGraphics(CANVAS_WIDTH, CANVAS_HEIGHT,P3D);
  background = createGraphics(CANVAS_WIDTH, CANVAS_HEIGHT,P3D);
  normalizeFractalValues();//normaliza valores para dibujar fractales
  composicion = new Composicion(pantalla, background);
  //fondo = new Background();
}

void draw() {
  fadeGraphics(background, 100);
  fadeGraphics(pantalla, 100);
  background(0);
  
  composicion.render();
}