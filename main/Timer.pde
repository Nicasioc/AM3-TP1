class Timer {
  int timestamp = 0;
  float timeMark;

  Timer(float timeMark_) {
    timeMark = timeMark_;
  }

  boolean isMaredTimeReached() {
    return millis()-timestamp >= timeMark;
  }

  boolean hasTimestamp() {
    return timestamp != 0;
  }

  void setTimestamp() {
    timestamp = millis();
  }

  void cleanTimestamp() {
    timestamp = 0;
  }

}