class Traffic
{
  boolean debug = false;

  float vehicleMinSpeed = 8;
  float vehicleMaxSpeed = 11;
  float vehicleMinPos = -3300;
  float vehicleMaxPos = -3000;
  float vehicleMaxStartPos = -1000;
  float vehiclePos;
  boolean spawned = false;
  Vehicle test = new Vehicle(true, color(150), 300, 0);

  ArrayList<Vehicle> traffic = new ArrayList<Vehicle>();

  void create(int numberOfVehicles) {
    boolean outerLane = random(1) < 0.5;

    for (int i = 0; i < numberOfVehicles; i++) {
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

      reset();
      trafficBehaviour(steer);
      v.update(playerSpeed, steer);
      v.draw();

      //For debugging & testing
      // test.currentLane = 499;
      // test.draw();
    }
  }
  void trafficBehaviour(float steer) {
    float perimiter = 200;
    float overlap = 101;


    //Get perception
    for (int s = 0; s < traffic.size(); s++) {
      Vehicle a = traffic.get(s);
      for (int r = s+1; r < traffic.size(); r++) {
        Vehicle b =  traffic.get(r);

        //flag if vehicle is close to/far from "player"
        if (a.Pos > 0 && a.Pos < 400) {
          a.isNearPlayer = true;
          b.isNearPlayer = true;
        }

        //flag  if vehicles violates perimiters
        if (abs(a.Pos - b.Pos) < perimiter) {
          a.violatePerimiter = true;
          b.violatePerimiter = true;
        }
        //flag if vehicles is in overlaping positions
        if (abs(a.Pos - b.Pos) < overlap) {
          a.overlap = true;
          b.overlap = true;
        }

        //Applies to only vehicles in same lane
        if (a.OuterLane == b.OuterLane) {
          //if vehicles overlap in same lane - flag for reset
          if (abs(a.Pos - b.Pos) < overlap) {
            a.reset = true;
          }

          //if vehciles violates perimiters
          if (abs(a.Pos - b.Pos) < perimiter) {

            if (a.Pos > b.Pos) {
              a.vAheadSpeed = b.Speed;
              a.vAhead = true;
            }
            if (b.Pos > a.Pos ) {
              b.vAheadSpeed = a.Speed;
              b.vAhead = true;
            }
            if (a.Pos < b.Pos) {
              a.vBehindSpeed = b.Speed;
              a.vBehind = true;
            }
            if (b.Pos < a.Pos ) {
              b.vBehindSpeed = a.Speed;
              b.vBehind = true;
            }
          }
        }
      }
    }
    //Make decisions
    for (Vehicle v : traffic) {

      //Plaeyer beam flash vehcile in each lane
      if (input.isDown(' ') && v.isNearPlayer) {

        if (v.OuterLane && steer >0) {
          v.beamed = true;
        }
        if (!v.OuterLane && steer < 0) {
          v.beamed = true;
        }
      }

      if (v.vBehind) {
        if (v.vBehindSpeed > v.Speed) {
          if (v.OuterLane) {
            if (!v.vAhead || !v.overlap) { 
              v.leavePrecedence = true;
            }
          }
        }
      }
      //Attempt to make vehicle leave precedence for player WIP
      //if (v.isNearPlayer/*  && v.conformable > 0.85 */) {
      //  if (v.OuterLane && steer > 0) {
      //    if (!v.vAhead || !v.violatePerimiter || !v.overlap) {
      //      //v.leavePrecedence = true;
      //    }
      //  }
      //}
      if (v.vAhead) {
        if (v.Speed > v.vAheadSpeed) {
          if (!v.OuterLane && !v.isNearPlayer) {
            v.takeOver = true;
          }
        }
      }
      if (v.vAhead) {
        if (v.Speed > v.vAheadSpeed) {
          if (v.OuterLane) {
            v.wait = true;
          }
        }
      }
      if (abs(v.Pos - player.Pos) < overlap) {
        float t = map(v.currentLane, 380, 620, 100, -100);
        if (abs(t-steer) < 70) {
          player.overlap = true;
        }
      }
    }

    //Apply behaviour
    for (Vehicle v : traffic) {

      if (v.beamed && v.conformable < 0.4 ) {

        v.Speed = v.beamedSpeed;
      }

      if (v.leavePrecedence) {
        
        if (v.OuterLane && (v.currentLane > 418 && v.currentLane < 420)) {

          if (v.overlap == false) {

            v.OuterLane = false;
          }
        }
        if (v.currentLane > 580 && v.currentLane < 582) {
          v.Speed = v.desiredSpeed;

          v.leavePrecedence = false;
        }
      }
      if (v.takeOver) {
        v.Speed = v.vAheadSpeed;
        if (!v.OuterLane && (v.currentLane > 580 && v.currentLane < 582)) {

          if (v.overlap == false && v.violatePerimiter == false) {

            v.OuterLane = true;
          }
        }
        if (v.currentLane > 418 && v.currentLane < 420) {
          v.Speed = v.desiredSpeed;
          v.takeOver = false;
        }
      }
      if (v.wait) {
        v.Speed = v.vAheadSpeed;
        if (!v.vAhead) {
          v.Speed = v.beamed ? v.beamedSpeed : v.desiredSpeed;
          v.wait = false;
        }
      }


      if (player.overlap) {
        player.alive=false;
      }



      if (debug) {
        println(v.PlateText, "TO:", v.takeOver, "LP", v.leavePrecedence, "Bd:", v.beamed, "NP:", v.isNearPlayer);
        println(v.PlateText, "w:", v.wait, "OL:", v.overlap, "PM", v.violatePerimiter, "conform:", nf(v.conformable, 0, 2));
        println(v.PlateText, "speed:", v.Speed, "d-speed:", v.desiredSpeed);
        println(steer, player.Pos, v.Pos, abs(v.Pos - player.Pos)<overlap, v.PlateText, v.OuterLane);
      }
    }
  }


  boolean lastLane;
  void reset() {
    player.overlap = false;


    for (Vehicle v : traffic) {
      v.overlap = false;
      v.violatePerimiter = false;
      v.vAhead = false;

      v.vBehind = false;

      v.beamed = false;
      v.isNearPlayer = false;


      if (v.Pos >= 600 || v.reset) {
        v.reset=false;
        v.OuterLane = randomBool(lastLane, 2);
        lastLane = v.OuterLane;
        v.C = color (random(20, 180), random(20, 120), random(20, 180));
        v.Pos = random(vehicleMinPos, vehicleMaxPos);
        v.Speed  = random(vehicleMinSpeed, vehicleMaxSpeed);
        v.desiredSpeed = v.Speed;
        if (v.OuterLane) {
          v.Speed   = random(vehicleMinSpeed, vehicleMaxSpeed)*1.2;
          v.desiredSpeed = v.Speed;
          v.conformable = random(0, 1);
        }
      }
    }
  }


  int t = 0, f =0;
  boolean randomBool(boolean bool, int streak) {
    if (bool) {
      t++ ;
    }
    if (!bool) {
      f++ ;
    }

    if (abs(t - f) > streak) {
      return !bool;
    }

    bool = random(1) < 0.5;
    return bool;
  }
}
