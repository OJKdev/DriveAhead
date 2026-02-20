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
  public void Odometer(float distance) {

    //if (distance > 1000) distText = nf(distance/1000, 0, 1) + " km";
   // else distText = round(distance) + " m";
distText = str(distance);
    fill(#E9FF48);
    textSize(40);
    textSize(30);
    text(nf(distance, 0, 2) + " km", 20, 65);;
  }
   public void ElapsedTime(float timerValue) {

    time = nf(timerValue, 0, 2);

    fill(#E9FF48);
    textSize(40);
    textSize(30);
    text(time + "'", 20, 99);
  }
}
