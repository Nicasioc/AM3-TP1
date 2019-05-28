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
    textureIndex = int(random(1, 8));
    this.setImage(textureIndex);
    angulo=45;
    pantalla=pantalla_;
    absoluteX = new float[FRACTALS_LEVEL];
    absoluteY = new float[FRACTALS_LEVEL];
  }

  void setImage(int index) {
    texturaLinea = loadImage("images/linea_shipibo"+index+".png");  // toma textura ver metodo
  }

  void nextTexture() {
    textureIndex++;
    if (textureIndex >= 17) textureIndex = 0;
    this.setImage(textureIndex);
  }

  void previousTexture() {
    textureIndex--;
    if (textureIndex <= 1) textureIndex = 17;
    this.setImage(textureIndex);
  }

  int getTextureIndex() {
    return this.textureIndex;
  }

  void drawFractal(int size_, int level) {
    //angulo difinido en main
    
    if(!REST_MODE && intro_ended) {
      angulo_global = mouseY;
    }

    int angle = int(map(angulo_global, 1, CANVAS_HEIGHT, 1, 180));

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

  float getXByIndex(int index) {
    return absoluteX[index];
  } 

  float getYByIndex(int index) {
    return absoluteY[index];
  }

  PImage getTexture() {
    return texturaLinea;
  }

}
