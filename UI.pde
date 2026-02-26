class UI {
  String speed = "0";
  String distText;
  String time;
  String Score;

  float fSpeed;
  float fDist;
  float fTime;
  float fScore = 0;
  float avgSpeed;

  float endTime;
  float Pos = -300;
  float endPos = 400;

  boolean skipaAhead = false;


  public void speedoMeter(float speedValue) {
    speed = str(round(speedValue*10));
    fSpeed = speedValue*10;
    pushMatrix();
    fill(#E9FF48);
    textSize(30);
    text(speed+" km/h", 20, 36);
    popMatrix();
  }
  public void odometer(float distance) {

    distText = str(distance);
    fDist = distance;
    pushMatrix();
    fill(#E9FF48);
    textSize(40);
    textSize(30);
    text(nf(distance, 0, 1) + " km", 20, 65);
    popMatrix();
  }
  public void elapsedTime(float timerValue) {


    fTime = timerValue*1000;


    int hours = round(fTime / 3600000);
    int minutes = round(fTime % 3600000) / 60000;
    int seconds = round(fTime % 60000) / 1000;
    int ms = round(fTime) % 1000;

    String timeShow =
      (hours >= 1 ? nf(hours, 2) + ":" : "") +
      (minutes >=1 ? nf(minutes, 2) + ":" : "") +
      nf(seconds, 2) + ":" +
      nf(ms, 3);
    time =
      nf(hours, 2) + ":"  +
      nf(minutes, 2) + ":"  +
      nf(seconds, 2) + ":" +
      nf(ms, 3);
    pushMatrix();
    fill(#E9FF48);
    textSize(40);
    textSize(30);
    text(timeShow + "'", 20, 99);
    popMatrix();
  }
  public String countPoints() {
    avgSpeed = fDist/(fTime / 3600000.0);

    float h = fTime / 3600000.0;
    avgSpeed = fDist / max(h, 0.000001);

    float targetSpeed = 130;
    float p = 1.5;

    float base = fDist / max(h, 0.000001);
    float bonus = pow(avgSpeed / targetSpeed, p);

    float score = (100 * base * bonus)/100;

    Score = nf(score, 0, -1);

    pushMatrix();

    fill(255);
    textSize(50);

    text(Score + "", 800, 35);
    popMatrix();
    return Score;
  }
  void EndScreen(float timerValue, Player player) {
    endTime = fTime/1000;
    var e = abs(endTime-timerValue);
    if (input.isDown(' ')) skipaAhead = true;
    if (skipaAhead) e = 16;

    if (e > 3 && e < 8) {
      pushMatrix();
      Pos = lerp(Pos, endPos, 0.01);
      fill(0);
      textSize(70);
      textAlign(CENTER);

      text("You died...", 500, Pos);

      popMatrix();
    }
    if (e > 9 ) {

      pushMatrix();

      fill(0);
      textSize(70);
      textAlign(CENTER);
      String text = "Your drove " + nf(fDist, 0, 0) + "km in " + time;
      text(text, 500, 184);
      popMatrix();
    }
    if (e > 11 ) {
      pushMatrix();

      fill(0);
      textSize(70);
      textAlign(CENTER);
      String text = "with an average speed of " + avgSpeed + " km/h..";
      text(text, 500, 327);

      popMatrix();
    }
    if (e > 13 ) {
      pushMatrix();


      fill(0);
      textSize(70);
      textAlign(CENTER);
      String text = "...and you scored " + Score + " points..";

      text(text, 500, 479);
      popMatrix();
    }
    if (e > 15 ) {

      fill(0);
      textSize(30);
      textAlign(CENTER);
      String text = "Type your name and Enter to restart!";
      text(pName, 500, 750);
      text(text, 500, 700);

      // if (input.isDown('W')) {

      //   START = true;
      //   player.alive=true;
      //   skipaAhead = false;
      // }
    }
  }
  void UIlight() {
    pointLight(255, 255, 255, 800, 35, 100);
  }
}
