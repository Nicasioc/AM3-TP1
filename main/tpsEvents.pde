/*
  Events for TSPS library
*/

void personEntered( TSPSPerson p ){
  println("personEntered");
  rest_mode = false;
  if (person == null) {
    person = p;
    println(person);
  }
}

void personUpdated( TSPSPerson p ){
  if (person != null && !rest_mode) {
    if(intro_ended) {
      angulo_global = round(p.centroid.x*width);
    }
    if(!intro_ended) {
      angle_active_mode = round(p.centroid.x*width);
    }
  }
}

void personLeft( TSPSPerson p ){
  println("personLeft");
  restartApp();
}