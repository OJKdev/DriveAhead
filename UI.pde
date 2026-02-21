class UI {
  String speed = "0";
  String distText;
  String time;


  public void speedoMeter(float speedValue) {
    speed = str(round(speedValue*10));

    pushMatrix();
    fill(#E9FF48);
    textSize(30);
    text(speed+" km/h", 20, 36);
    popMatrix();
  }
  public void odometer(float distance) {

    distText = str(distance);
    fill(#E9FF48);
    textSize(40);
    textSize(30);
    text(nf(distance, 0, 2) + " km", 20, 65);
    ;
  }
  public void elapsedTime(float timerValue) {

    time = nf(timerValue, 0, 2);

    fill(#E9FF48);
    textSize(40);
    textSize(30);
    text(time + "'", 20, 99);
  }
}
