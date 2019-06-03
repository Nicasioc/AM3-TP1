int SPACEBAR = 32;


void keyPressed() { 

  composicion.onKeyPressUpdateFractalTexture(key);

  if (keyCode == 32) {
    rest_mode = !rest_mode;
    intro_ended = false;
    timer.setTimestamp();
  }

  if (key == 'd'|| key == 'D') {
    //debug.pde
    showDebug = !showDebug;
  }

  if (key == CODED && rest_mode) {
    if (keyCode == UP) {
      cantidadFractales=cantidadFractales+2;
      normalizeFractalValues();
    }
    
    if (keyCode == DOWN) {
      cantidadFractales=cantidadFractales-2;
      normalizeFractalValues();
    }

    if (keyCode == LEFT) {
      fractalHeight=fractalHeight+1;
      normalizeFractalValues();
    }
    if (keyCode == RIGHT) {
      fractalHeight=fractalHeight-1;
      normalizeFractalValues();
    }
  }
}

//mantiene los valores dentro de un rango
void normalizeFractalValues() {
  fractalHeight = constrain(fractalHeight, 3, 6);
  fractalHeightModifier = constrain(fractalHeightModifier, 1, 4);

  //println("fractalHeight: "+fractalHeight);
  //println("fractalHeightModifier: "+fractalHeightModifier);
};