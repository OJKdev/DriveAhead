class Vehicle {
  float outerLanePos = 419;
  float innerLanePos = 581;
  float currentLane;
  float tHeight = -20;

  boolean OuterLane = true;
  color C = color(242, 0, 188);
  float Pos;
  float Speed;

  Vehicle (boolean outerLane, color c, float pos, float speed) {
    OuterLane = outerLane;
    C =c ;
    Pos = pos;
    Speed = speed;
  }
  
  void update(float playerSpeed){
    Pos -= Speed-playerSpeed;
  }


  public void Draw() {
    if (OuterLane) {
      currentLane = outerLanePos;
    } else {
      currentLane = innerLanePos;
    }

    float t = map(Pos, -4600, -4000, 0, 1);
    t = constrain(t, 0, 1);




    //Draw car
    pushMatrix();
    translate(currentLane+steer.SteerValue(), 328+tHeight, Pos);

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

    //Light
    pushMatrix();
    translate(-35, 10, 45);
    stroke(251*t, 77*t, 77*t);
    strokeWeight(10);
    fill(248*t, 1*t, 42*t);
    box(24, 11, 6);
    popMatrix();

    //Light
    pushMatrix();
    translate(36, 10, 45);
    stroke(251*t, 77*t, 77*t);
    strokeWeight(10);
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
}
