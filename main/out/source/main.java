import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {

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

public void setup() {
  //SIEMPRE CUADRADO!!!
  //Composition <drawComposicion> asume que el canvas es cuadrado
  
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

public void draw() {
  fadeGraphics(background, 100);
  fadeGraphics(pantalla, 100);
  background(0);
  
  composicion.render();
}
class Background {
  float formula;
  int x, y;
  int L= 50*1;
  float m, n ;
  float final_;
  PGraphics pantalla = createGraphics(700, 700, P3D);

  public void callChladni() {
    if (frameCount%40 == 0) { 
      pantalla.beginDraw();
      //m= random(1,6);
      m =PApplet.parseInt(map(mouseY, 0, CANVAS_HEIGHT, 2, 30));
      n =PApplet.parseInt(map(mouseY, 0, CANVAS_HEIGHT, 1, 7));
      //n =5;
      pantalla.loadPixels();

      for (int i=0; i< pantalla.height; i++ ) {
        //L=50;
        L=PApplet.parseInt(map(mouseX, 0, CANVAS_WIDTH, 50, CANVAS_WIDTH/4 ));
        for (int j=0; j< pantalla.width; j++ ) {

          int loc = i+ j* pantalla.width;

          formula = 1-abs( cos(n * PI * i / L) * cos(m* PI* j / L) - cos(m *PI * i / L) * cos( n * PI *j / L)) ;
          //println(formula);
          formula = map(formula, 0, 1, 0, 255)> 245 ? 255 : 0 ;
          pantalla.pixels[loc]= color( formula-100, 0, 0, 40);
        }
      }


      pantalla.updatePixels();
      pantalla.endDraw();
    }
  }

  public void render() {
    image(pantalla, 0, 0);
  }
}
class Composicion {
  PGraphics pantalla;
  PGraphics background;
  Fractal fractal;
  int cantidadFractalesEjeX;
  Composicion(PGraphics pantalla_, PGraphics background_) {
    pantalla = pantalla_;
    fractal = new Fractal(pantalla);
    background = background_;
  }

  public void render() {
    this.drawComposicion();
    image(background, 0,0);
    image(pantalla, 0, 0);
  }

  public void drawComposicion() {
    cantidadFractalesEjeX = PApplet.parseInt( map(mouseX, 2, CANVAS_WIDTH, 2, 8 ) ); // valor final
    int cantidadFractalesEjeY = cantidadFractalesEjeX;
    int fractalPositionY = pantalla.height/cantidadFractalesEjeY;
    int fractalPositionX = pantalla.width/cantidadFractalesEjeX;
    for (int x=1; x < cantidadFractalesEjeX; x++) {
      for (int y=1; y < cantidadFractalesEjeY; y++) {
        pantalla.beginDraw();
        pantalla.pushMatrix();
        pantalla.pushStyle();
        pantalla.translate(x*fractalPositionX, y*fractalPositionY);
        pantalla.stroke(255, 0, 0);
        this.drawFractals(fractalPositionY);
        pantalla.popMatrix();
        pantalla.popStyle();
        pantalla.endDraw();
      }
    }
  }

  public void drawFractals(int size_) {
    for (int i=0; i < cantidadFractales; i++) {
      pantalla.scale(-1,-1);
      fractal.drawFractal(size_, FRACTALS_LEVEL);//Dibuja el fractal en el PImage pantalla. fractal ya tiene una referencia a pantalla dentro

      background.beginDraw();
      //background.line(fractal.getXByIndex(0), fractal.getYByIndex(0), fractal.getXByIndex(1)+size_, fractal.getYByIndex(1));
      //PGraphics imageBuffer, PImage texture, float width_, float height_, float x, float y
      drawVertexShapeXY(background, fractal.getTexture(), fractal.getXByIndex(0), fractal.getYByIndex(0), 20, -1*fractal.getXByIndex(3)+size_);
      //background.line(fractal.getXByIndex(2), fractal.getYByIndex(2), , fractal.getYByIndex(3));
      //background.line(fractal.getXByIndex(3), fractal.getYByIndex(3), fractal.getXByIndex(1)+size_, fractal.getYByIndex(1));
      //background.line(fractal.getXByIndex(1), fractal.getYByIndex(1), fractal.getXByIndex(2)+size_, fractal.getYByIndex(2));
      background.endDraw();
    }
  }

  public void onKeyPressUpdateFractalTexture(int key) {
    if (key == 'w'|| key == 'W') {
      fractal.nextTexture();
    }
    
    if (key == 's'|| key == 'S') {
      fractal.previousTexture();
    }
  }

}
class Fractal {
  float size_;
  int level;
  int angulo;
  int divisor;
  int textureIndex;

  float[] absoluteX;
  float[] absoluteY;

  PImage texturaLinea;
  PGraphics pantalla;

  Fractal(PGraphics pantalla_) {
    textureIndex = PApplet.parseInt(random(1, 8));
    this.setImage(textureIndex);
    angulo=45;
    pantalla=pantalla_;
    absoluteX = new float[FRACTALS_LEVEL];
    absoluteY = new float[FRACTALS_LEVEL];
  }

  public void setImage(int index) {
    texturaLinea = loadImage("images/linea_shipibo"+index+".png");  // toma textura ver metodo
  }

  public void nextTexture() {
    textureIndex++;
    if (textureIndex >= 17) textureIndex = 0;
    this.setImage(textureIndex);
  }

  public void previousTexture() {
    textureIndex--;
    if (textureIndex <= 1) textureIndex = 17;
    this.setImage(textureIndex);
  }

  public int getTextureIndex() {
    return this.textureIndex;
  }

  public void drawFractal(int size_, int level) {
    int angle = PApplet.parseInt(map(mouseY, 1, CANVAS_HEIGHT, 1, 180));

    if (level > 0) {

      drawVertexShape(pantalla, texturaLinea, -size_/fractalHeight, 20);

      absoluteX[level-1] = pantalla.modelX(0, 0, 0);
      absoluteY[level-1] = pantalla.modelY(0, 0, 0);
  
      pantalla.translate(0, -size_/fractalHeight);
      pantalla.rotate(radians(angle));
      this.drawFractal(size_/fractalHeightModifier, level-1);
      pantalla.rotate(radians(-2*angle));
      this.drawFractal(size_/fractalHeightModifier, level-1);
      pantalla.rotate(radians(angle));
      pantalla.translate(0, size_/fractalHeight);
    }
  }

  public float getXByIndex(int index) {
    return absoluteX[index];
  } 

  public float getYByIndex(int index) {
    return absoluteY[index];
  }

  public PImage getTexture() {
    return texturaLinea;
  }

}
//Modifica alfa de un pgrafic
public void fadeGraphics(PGraphics pantalla, int fadeAmount) {
  pantalla.beginDraw();
  pantalla.loadPixels();

  // iterate over pixels
  for (int i =0; i<pantalla.pixels.length; i++) {

    // get alpha value
    int alpha = (pantalla.pixels[i] >> 24) & 0xFF ;

    // reduce alpha value
    alpha = max(0, alpha-fadeAmount);

    // assign color with new alpha-value
    pantalla.pixels[i] = alpha<<24 | (pantalla.pixels[i]) & 0xFFFFFF ;
  }

  pantalla.updatePixels();
  pantalla.endDraw();
}
public void keyPressed() { 

  composicion.onKeyPressUpdateFractalTexture(key);

  if (key == 'a'|| key == 'A') {
    cantidadFractales=cantidadFractales+2;
    normalizeFractalValues();
  }
  
  if (key == 'd'|| key == 'D') {
    cantidadFractales=cantidadFractales-2;
    normalizeFractalValues();
  }

  if (key == CODED) {
    if (keyCode == LEFT) {
      fractalHeight=fractalHeight+1;
      normalizeFractalValues();
    }
    if (keyCode == RIGHT) {
      fractalHeight=fractalHeight-1;
      normalizeFractalValues();
    }

    if (keyCode == UP) {
      fractalHeightModifier=fractalHeightModifier-1;
      normalizeFractalValues();
    }
    if (keyCode == DOWN) {
      fractalHeightModifier=fractalHeightModifier+1;
      normalizeFractalValues();
    }
  }
}

//mantiene los valores dentro de un rango
public void normalizeFractalValues() {
  if (fractalHeight <=1) fractalHeight =1;
  if (fractalHeightModifier <= 1) fractalHeightModifier = 1;
  if (cantidadFractales <= 2) cantidadFractales = 2;
};
public void drawVertexShape(PGraphics imageBuffer, PImage texture, float height_, float width_) {

  imageBuffer.pushStyle();
  imageBuffer.strokeWeight(0);
  imageBuffer.stroke(0, 255, 0);
  imageBuffer.beginShape();
  imageBuffer.texture(texture);
  imageBuffer.vertex(-5, 0, 0, 0);
  imageBuffer.vertex(5, 0, width_, 0);
  imageBuffer.vertex(5, height_, width_, 500);
  imageBuffer.vertex(-5, height_, 0, 500);
  imageBuffer.endShape(CLOSE);
  imageBuffer.popStyle();

}

public void drawVertexShapeXY(PGraphics imageBuffer, PImage texture, float x, float y, float width_, float height_) {
  imageBuffer.pushStyle();
  imageBuffer.strokeWeight(0);
  imageBuffer.stroke(0, 255, 0);
  imageBuffer.beginShape();
  imageBuffer.texture(texture);
  imageBuffer.vertex(x, y, 0, 0);
  imageBuffer.vertex(x+5, y, width_, 0);
  imageBuffer.vertex(x+5, y+height_, width_, 500);
  imageBuffer.vertex(x, y+height_, 0, 500);
  imageBuffer.endShape(CLOSE);
  imageBuffer.popStyle();

}
  public void settings() {  size(700, 700, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
