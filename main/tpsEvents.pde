/*
  Events for TSPS library

*/
TSPSPerson person = null;

void personEntered( TSPSPerson p ){
  println("personEntered");
  rest_mode = false;
  if (person == null) {
    person = p;
    println(person);
  }
}

void personUpdated( TSPSPerson p ){
  println("personUpdated");
  if (person != null) {
    println("p.id"+p.id);
    println("person.id"+person.id);
    println(p.centroid.y*height);
    angulo_global = p.centroid.y*height;
  }
}

void personLeft( TSPSPerson p ){
  println("personLeft");
  rest_mode = true;
  person = null;
}