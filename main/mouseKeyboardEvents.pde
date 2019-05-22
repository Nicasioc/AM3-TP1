void keyPressed() { 

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
void normalizeFractalValues() {
  if (fractalHeight <=1) fractalHeight =1;
  if (fractalHeightModifier <= 1) fractalHeightModifier = 1;
  if (cantidadFractales <= 2) cantidadFractales = 2;
};