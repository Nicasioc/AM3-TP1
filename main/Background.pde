class Background {
  float formula;
  int x, y;
  int L= 50*1;
  float m, n ;
  float final_;
  PGraphics pantalla = createGraphics(700, 700, P3D);

  void callChladni() {
    if (frameCount%40 == 0) { 
      pantalla.beginDraw();
      //m= random(1,6);
      m =int(map(mouseY, 0, CANVAS_HEIGHT, 2, 30));
      n =int(map(mouseY, 0, CANVAS_HEIGHT, 1, 7));
      //n =5;
      pantalla.loadPixels();

      for (int i=0; i< pantalla.height; i++ ) {
        //L=50;
        L=int(map(mouseX, 0, CANVAS_WIDTH, 50, CANVAS_WIDTH/4 ));
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

  void render() {
    image(pantalla, 0, 0);
  }
}
