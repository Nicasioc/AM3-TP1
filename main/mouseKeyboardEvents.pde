int SPACEBAR = 32;


void keyPressed() { 

  composicion.onKeyPressUpdateFractalTexture(key);

  if (keyCode == 32) {
    REST_MODE = !REST_MODE;
  }


  if (key == CODED && REST_MODE) {
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