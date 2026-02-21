class Traffic
{
  float vehicleMinSpeed = 8;
  float vehicleMaxSpeed = 12;
  float vehicleMinPos = -5500;
  float vehicleMaxPos = -5000;
  float vehicleMaxStartPos = -1000;
  float vehiclePos;
  boolean spawned = false;
  Vehicle test = new Vehicle(true, color(120, 55, 203), 300, 0);
  ArrayList<Vehicle> traffic = new ArrayList<Vehicle>();

  void create(int amount) {
    boolean outerLane = random(1) < 0.5;

    for (int i = 0; i < amount; i++) {
      outerLane = randomBool(outerLane, 2);
      lastLane = outerLane;
      color c = color (random(20, 255), random(20, 255), random(20, 255));
      float startPos = random(vehicleMinPos, vehicleMaxStartPos);
      float speed = random(vehicleMinSpeed, vehicleMaxSpeed);
      if (outerLane) {
        speed = random(vehicleMinSpeed, vehicleMaxSpeed)*1.2;
      }
      traffic.add(new Vehicle(outerLane, c, startPos, speed));
    }
  }

  void spawn(float playerSpeed, float steer) {
    for (Vehicle v : traffic) {
      v.update(playerSpeed, steer);
      v.draw();
      trafficBehaviour();
      reset();
    }
    
  }
  void trafficBehaviour() {
    float hitBoundary = 200;
    float overlap = 55;
    for (int s = 0; s < traffic.size(); s++) {
      Vehicle a = traffic.get(s);
      for (int r = s+1; r < traffic.size(); r++) {
        Vehicle b =  traffic.get(r);
 
        if (a.OuterLane == b.OuterLane) {

          if (a.Pos - overlap < b.Pos + overlap &&
            a.Pos - overlap > b.Pos - overlap) {
            a.Pos = random(vehicleMinPos, vehicleMaxPos);
           // println("corrected overlapping");
          }

          if (a.Pos - hitBoundary < b.Pos + hitBoundary || b.Pos - hitBoundary < a.Pos + hitBoundary) {
          // println((s +" overlapping" + r), a.OuterLane, b.OuterLane );



            if (a.Pos > b.Pos && a.OuterLane == false) {

              a.Speed = b.Speed;
            }
            if (a.Pos < b.Pos && a.OuterLane == true) {
              a.Speed = b.Speed;
            }
          }
        }
      }
    }
  }



  boolean lastLane;
  void reset() {

    for (Vehicle v : traffic) {

      if (v.Pos >= 500) {
        //print(lastLane+" ");
        v.OuterLane = randomBool(lastLane, 2);
        lastLane = v.OuterLane;
        //print(v.OuterLane+" ");
        v.C = color (random(20, 180), random(20, 120), random(20, 180));
        v.Pos = random(vehicleMinPos, vehicleMaxPos);
        v.Speed  = random(vehicleMinSpeed, vehicleMaxSpeed);
        if (v.OuterLane) {
          v.Speed   = random(vehicleMinSpeed, vehicleMaxSpeed)*1.2;
        }
      }
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
