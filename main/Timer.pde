class Timer {
  int timestamp;
  float timeMark;

  Timer(float timeMark_) {
    timeMark = timeMark_;
  }

  boolean isTimeMarkReached() {
    return millis()-timestamp >= timeMark;
  }

  void setTimestamp() {
    timestamp = millis();
  }

}