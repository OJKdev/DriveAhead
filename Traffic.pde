class Traffic
{
  float vehicleMinSpeed = 8;
  float vehicleMaxSpeed = 12;
  float vehicleMinPos = -5300;
  float vehicleMaxPos = -5000;
  float vehiclePos;
  boolean spawned = false;


  //Lane true false count


  //Vehicle vehicle = new Vehicle(true, color(120, 55, 203), 0);
  ArrayList<Vehicle> traffic = new ArrayList<Vehicle>();



  void Reset() {
    boolean outerLane = random(1) < 0.5;
    for (Vehicle v : traffic) {
      if (v.Pos >= 500) {
        v.OuterLane = randomBool(outerLane, 2);
        v.C = color (random(20, 180), random(20, 120), random(20, 180));
        v.Pos = random(vehicleMinPos, vehicleMaxPos);
        v.Speed  = random(vehicleMinSpeed, vehicleMaxSpeed);
        if (outerLane) {
          v.Speed   = random(vehicleMinSpeed, vehicleMaxSpeed)*1.2;
        }
      }
    }
  }

  void create(int amount) {
    boolean outerLane = random(1) < 0.5;

    for (int i = 0; i < amount; i++) {
      outerLane = randomBool(outerLane, 2);
      color c = color (random(20, 255), random(20, 255), random(20, 255));
      float startPos = random(vehicleMinPos, vehicleMaxPos);
      float speed = random(vehicleMinSpeed, vehicleMaxSpeed);
      if (outerLane) {
        speed = random(vehicleMinSpeed, vehicleMaxSpeed)*1.2;
      }
      traffic.add(new Vehicle(outerLane, c, startPos, speed));
    }
  }

  void spawn(float playerSpeed) {
    for (Vehicle v : traffic) {
      v.update(playerSpeed);
      v.Draw();
      Reset();
    }
  }


  int t = 0, f =0;
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
