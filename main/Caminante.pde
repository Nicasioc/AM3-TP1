class Caminante {
  ArrayList<String> estados = new ArrayList<String>();
  float x, y;
  float t;
  float velocidad;
  float direccion;
  float variacionAngular = 0;
  color colorRelleno;
 
  String estado; //recta / "esquina" / curva
  int pasos;
 
  Caminante(int x_, int y_) {

    x = x_;
    y = y_;
 
    t = 3;
    velocidad = 3;
    direccion = 0;
    pushStyle();
    colorMode( HSB );
    colorRelleno = color( random(150, 190), 255, 255, 100 );//color fijo
    popStyle();
 
    estado = "recta";
    pasos = 0;
  }
 
  void dibujar() {
    pushStyle();
    noStroke();
 
    fill( colorRelleno );
 
    ellipse( x, y, t, t );
    popStyle();
  }
 
  void mover() {
 
    //direccion = direccion + radians( random(-variacionAngular, variacionAngular) );
 
    //coordenadas polares
    float dx = velocidad * cos( direccion );
    float dy = velocidad * sin( direccion );
    x = x + dx;
    y = y + dy;
 
    //espacio toroidal
    if ( x>width) {
     x=x-width;
      y=y+5;
    }
    x = ( x<0 ? x+width : x );
    y = ( y>height ? y-height : y );
    y = ( y<0 ? y+height : y );
  }
 
  void seguir( float mx, float my ) {
    direccion = atan2( my-y, mx-x );
  }
 
  void huir( float mx, float my ) {
    direccion = atan2( my-y, mx-x ) + radians( 180 );//+PI
  }
 
  boolean seChocoCon( Caminante otro ) {
    float distancia = dist( x, y, otro.x, otro.y );
    float sumaRadios = t/2 + otro.t/2;
    boolean resultado = distancia <= sumaRadios;
    return resultado;
  }
 
  void actualizar() {
 
    if ( estado.equals( "recta")) {
      if ( pasos >= 15 ) {
        estado = "esquina";
      }
    } else if ( estado.equals( "esquina" ) ) {
      direccion -= radians(90);
      estado = "curva";
      pasos = 0;
    } else if ( estado.equals( "curva" ) ) {
      direccion += radians( 10);
      if ( pasos >= 27 ) {
        estado = "esquina2";
        pasos = 0;
      }
    } else if ( estado.equals( "esquina2" ) ) {
      direccion -= radians(90);
      estado = "recta2";
      pasos = 0;
    } else if ( estado.equals( "recta2" ) ) {
      if ( pasos >= 15 ) {
        estado = "esquina3";
        //noLoop();
      }
    } else if ( estado.equals( "esquina3" ) ) {
      direccion -= radians(90);
      estado = "recta";
      pasos = 0;
    }
    pasos++;
  }
}