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
  float lastDist;

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

    float deltaDist = max(0, fDist - lastDist);
    lastDist = fDist;

    // snittfart km/h
    float h = fTime / 3600000.0;
    avgSpeed = fDist / max(h, 0.000001);

    // multiplier baserat på snittfart
    float targetSpeed = 130.0;
    float p = 1.5;

    //float mult = pow(avgSpeed / targetSpeed, p);
    float mult;
    if (fSpeed < 60) mult = 0.1;
    else if (fSpeed < 90) mult = 0.4;
    else if (fSpeed < 120) mult = 0.7;
    else if (fSpeed < 150) mult = 1.1;
    else if (fSpeed < 170) mult = 1.7;
    else if (fSpeed < 180) mult = 2;
    else mult = 2.5;

    // clamp så den aldrig blir för sjuk/låg (valfritt)
    mult = constrain(mult, 0.1, 5.0);

    // poäng: 100 poäng per km * multiplier
    fScore += deltaDist * 100.0 * mult;



    Score = nf(fScore, 0, -1);

    pushMatrix();

    fill(255);
    textSize(50);

    text(Score + "", 800, 35);
    popMatrix();
    return Score;
  }

  void EndScreen(float timerValue) {
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
      String text = "Your drove " + nf(fDist, 0, -1) + "km in " + time;
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
      skipaAhead = true;
      fill(0);
      textSize(30);
      textAlign(CENTER);
      String text = "Type your name and Enter to restart!";
      text(pName, 500, 750);
      text(text, 500, 700);
    }
  }


  void loadScores() {
    pushMatrix();
    translate(-313, -122, 0);
    textAlign(LEFT);
    textSize(80);
    text("DRIVE AHEAD!", 0, 0);
    popMatrix();

    JSONObject root = loadJSONObject("highscores.json");
    JSONArray scores = root.getJSONArray("scores");

    for (int i = 0; i < scores.size(); i++) {
      for (int j = i + 1; j < scores.size(); j++) {

        JSONObject a = scores.getJSONObject(i);
        JSONObject b = scores.getJSONObject(j);

        float scoreA = a.getFloat("score");
        float scoreB = b.getFloat("score");

        // Om j är större än i → byt plats
        if (scoreB > scoreA) {
          scores.setJSONObject(i, b);
          scores.setJSONObject(j, a);
        }
      }
    }

    for (int i = 0; i < scores.size(); i++) {
      JSONObject s = scores.getJSONObject(i);

      String name = s.getString("name");
      float score = s.getFloat("score");
      float dist = s.getFloat("dist");
      String time = s.getString("time");
      float avgSpeed = s.getFloat("avgSpeed");

      pushMatrix();
      translate(200, i*98, 0);
      textAlign(LEFT);
      textSize(40);
      text((i+1) +". " + name + ", " + nf(score, 0, 0)+"p", 100, -35);
      textAlign(RIGHT);
      textSize(26);
      textAlign(LEFT);
      text("Distance: " +nf(dist, 0, 0)+  "km, Time: " + time + ", Avarage Speed: " + avgSpeed + "km/h", 101, -2);
      popMatrix();
    }

    fill(0);
    textSize(30);
    textAlign(CENTER);
    String text = "Press W to drive ahead!";

    text(text, -96, 25);

    if (input.isDown('W')) {

      START = true;
      player.alive=true;
      skipaAhead = false;
      ScoreBoard = false;
    }
  }
}
