class Composicion {
  PGraphics pantalla;
  PGraphics background;
  Fractal fractal;
  int cantidadFractalesEjeX;
  Composicion(PGraphics pantalla_, PGraphics background_) {
    pantalla = pantalla_;
    fractal = new Fractal(pantalla);
    background = background_;
    cantidadFractalesEjeX = 4;
  }

  void render() {
    this.drawComposicion();
    image(background, 0,0);
    image(pantalla, 0-CROP_SIZE/2, 0-CROP_SIZE/2, CANVAS_WIDTH+CROP_SIZE, CANVAS_HEIGHT+CROP_SIZE);
  }

  void drawComposicion() {
    //cantidadFractalesEjeX = int( map(mouseX, 2, CANVAS_WIDTH, 2, 8 ) ); // valor final
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

  void drawFractals(int size_) {
    for (int i=0; i < cantidadFractales; i++) {
      pantalla.scale(-1,-1);
      fractal.drawFractal(size_, FRACTALS_LEVEL);//Dibuja el fractal en el PImage pantalla. fractal ya tiene una referencia a pantalla dentro

      background.beginDraw();
      //background.line(fractal.getXByIndex(0), fractal.getYByIndex(0), fractal.getXByIndex(1)+size_, fractal.getYByIndex(1));
      //PGraphics imageBuffer, PImage texture, float width_, float height_, float x, float y
      //drawVertexShapeXY(background, fractal.getTexture(), fractal.getXByIndex(0), fractal.getYByIndex(0), 20, -1*fractal.getXByIndex(3)+size_);
      //drawVertexShapeXY(background, fractal.getTexture(), fractal.getXByIndex(0), fractal.getYByIndex(0), 20, -1*fractal.getXByIndex(3)+size_);
      //background.line(fractal.getXByIndex(2), fractal.getYByIndex(2), , fractal.getYByIndex(3));
      //background.line(fractal.getXByIndex(3), fractal.getYByIndex(3), fractal.getXByIndex(1)+size_, fractal.getYByIndex(1));
      //background.line(fractal.getXByIndex(1), fractal.getYByIndex(1), fractal.getXByIndex(2)+size_, fractal.getYByIndex(2));
      background.endDraw();
    }
  }

  void onKeyPressUpdateFractalTexture(int key) {
    if (key == 'w'|| key == 'W') {
      fractal.nextTexture();
    }
    
    if (key == 's'|| key == 'S') {
      fractal.previousTexture();
    }
  }

}
