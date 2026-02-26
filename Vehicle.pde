class Vehicle {
  float outerLanePos = 419;
  float innerLanePos = 581;
  float currentLane = 0;
  float tHeight = -20;

  boolean OuterLane = true;
  color C = color(242, 0, 188);
  float Pos;
  float Speed;
  float Steer;
  String PlateText = randomPlate();

  float conformable = random(0, 1);
  Boolean leavePrecedence = false;
  Boolean takeOver = false;
  Boolean wait = false;

  Boolean isNearPlayer = false;
  Boolean overlap = false;
  Boolean violatePerimiter = false;
  Boolean reset = false;

  Boolean vAhead = false;
  float vAheadSpeed;
  Boolean vBehind = false;
  float vBehindSpeed;

  float desiredSpeed;

  Boolean changeLaneReady = false;

  Boolean beamed = false;
  Boolean beamedCoolDown;
  float beamedSpeed =0;




  Vehicle (boolean outerLane, color c, float pos, float speed) {
    OuterLane = outerLane;
    C =c ;
    Pos = pos;
    Speed = speed;
    desiredSpeed = speed;
    beamedSpeed = speed*1.2;
  }

  void update(float playerSpeed, float steer) {
    Pos -= Speed-playerSpeed;
    Steer = steer;
  }


  public void draw() {
    if (OuterLane) {
      if (currentLane == 0) {
        currentLane = outerLanePos;
      } else {
        currentLane = lerp(currentLane, outerLanePos, 0.01);
      }
    } else {
      if (currentLane == 0) {
        currentLane = innerLanePos;
      } else {

        currentLane = lerp(currentLane, innerLanePos, 0.01);
      }
    }

    //Distance dimming
    float t = map(Pos, -3600, -3000, 0, 1);
    t = constrain(t, 0, 1);
    float l = map(Pos, -4000, -2000, 10, 5);
    l = constrain(l, 5, 10);

    //Draw car
    pushMatrix();
    translate(currentLane+Steer, 328+tHeight, Pos);

    //Body
    pushMatrix();
    translate(0, 0, 0);
    fill(C);
    noStroke();
    box(101, 36, 94);
    popMatrix();

    //Body
    pushMatrix();
    translate(0, -17, 0);
    fill(C);
    noStroke();
    box(96, 40, 39);
    popMatrix();

    //Windows
    pushMatrix();
    translate(0, -23, 0);
    fill(47, 45, 53);
    noStroke();
    box(87, 25, 41);
    popMatrix();

    //Window
    pushMatrix();
    translate(0, -18, 0);
    fill(50*t, 45*t, 39*t);
    noStroke();
    box(97, 33, 34);
    popMatrix();

    //Plate
    pushMatrix();
    translate(0, 18, 45);
    fill(158*t, 158*t, 158*t);
    stroke(51, 50, 50);
    box(24, 11, -6);
    popMatrix();

    //PlateText
    pushMatrix();
    translate(0, 19.5, 49); // x,y,z i 3D-världen
    fill(0);
    textSize(6);
    textAlign(CENTER);
    text(PlateText, 0, 0);
    popMatrix();

    //Light
    pushMatrix();
    translate(-35, 10, 45);
    stroke(251*t, 77*t, 77*t);
    strokeWeight(l);
    fill(248*t, 1*t, 42*t);
    box(24, 11, 6);
    popMatrix();

    //Light
    pushMatrix();
    translate(36, 10, 45);
    stroke(251*t, 77*t, 77*t);
    strokeWeight(l);
    fill(248*t, 1*t, 42*t);
    box(24, 11, 6);
    popMatrix();

    //wheel
    pushMatrix();
    translate(36, 21, 22);
    stroke(19*t, 19*t, 19*t);
    strokeWeight(5);
    fill(31*t, 31*t, 31*t);
    sphere(20);
    popMatrix();

    //wheel
    pushMatrix();
    translate(36, 21, -24);
    stroke(19, 19, 19);
    strokeWeight(5);
    fill(31, 31, 31);
    sphere(20);
    popMatrix();

    //wheel
    pushMatrix();
    translate(-37, 21, 22);
    stroke(19, 19, 19);
    strokeWeight(5);
    fill(31, 31, 31);
    sphere(20);
    popMatrix();

    //Wheel
    pushMatrix();
    translate(-37, 21, -24);
    stroke(19, 19, 19);
    strokeWeight(5);
    fill(31, 31, 31);
    sphere(20);
    popMatrix();

    popMatrix();
  }
  String randomPlate() {
    String result = "";

    for (int i = 0; i < 3; i++) {
      char c = (char) random(65, 91);
      result += c;
    }

    return result + " " + nf(int(random(999)), 3);
  }
}
