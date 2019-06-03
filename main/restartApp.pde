void restartApp() {
  println("reinicia");
  rest_mode = true;
  outro_ended = false;
  intro_ended = false;
  person = null;
  timer.cleanTimestamp();
}