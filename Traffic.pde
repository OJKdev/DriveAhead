class Traffic
{
  float vehicleMinSpeed = 7;
  float vehicleMaxSpeed = 12;
  float vehicleMinPos = -5500;
  float vehicleMaxPos = -5000;
  float vehiclePos;
  boolean spawned = false;


  //Lane true false count
  int t = 0, f =0;

  //Vehicle vehicle = new Vehicle(true, color(120, 55, 203), 0);
  ArrayList<Vehicle> traffic = new ArrayList<Vehicle>();



  void ResetVehicle() {
    if (vehiclePos >= 1000) vehiclePos = -5000;
    println(vehiclePos);
  }

  void create() {
    boolean outerLane = random(1) < 0.5;

    for (int i = 0; i < 6; i++) {
      outerLane = randomBool(outerLane, 2);
      color c = color (random(20, 255), random(20, 255), random(20, 255));
      float startPos = random(vehicleMinPos, vehicleMaxPos);
      float speed = random(vehicleMinSpeed, vehicleMaxSpeed);

      if (outerLane) {
        speed = random(vehicleMinSpeed, vehicleMaxSpeed)*1.1;
      }

      traffic.add(new Vehicle(outerLane, c, startPos, speed));
      //println(lane, c, startPos, speed);
    }
  }
  void spawn(float playerSpeed) {
    int vIndex = 0;

    for (Vehicle v : traffic) {
      v.update(playerSpeed);
      // vehiclePos -= random(7, 12)-playerSpeed;
      v.Draw();

      println("v"+vIndex+" startpos" + v.Pos +" "+ spawned);
      vIndex++;
    }
  }
  boolean randomBool(boolean bool, int streak) {
    if (bool) {
      t++ ;
      println("T: " + t);
    }
    if (!bool) {
      f++ ;
      println("F: " + f);
    }

    if (abs(t - f) > streak) {
      return !bool;
    }

    bool = random(1) < 0.5;
    return bool;
  }
}
