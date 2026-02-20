class Drive {

  float value = 0;     
  float target = 0;    
  float speed = 0.05;   

  float maxValue = 20;
  float minValue = 1;
  float gas = 0.1;
  float engineBreak = 0.015;
  float Break = 0.1;
  float gearRate;
  float acceleration;
  float stopDist;

  void Pedals () {

    if (value < maxValue*0.45) gearRate = 0.4;
    if (value > maxValue*0.45 && value < maxValue*0.65 ) gearRate = 0.15;
    if (value > maxValue*0.65 && value < maxValue*0.85 ) gearRate = 0.05;
    if (value > maxValue*0.85 ) gearRate = 0.01;
    
    acceleration = gas * gearRate;
    stopDist = Break * (gearRate*3);
    
      if (input.isDown('W')){ target += acceleration;
    } else {
      if (target > minValue)  target -= engineBreak;
    }
   
      if (input.isDown('S')) { if (target > minValue)  target -= stopDist;
    }
    if (value < maxValue) {
      value = lerp(value, target, speed);
    } else {
      target = maxValue-0.5;
      value = lerp(value, target, speed);
    }

  }

  float Value() {
    if (value > maxValue*-1 && value < maxValue) {
      value = lerp(value, target, speed);
    } else {
      target = (maxValue-1) * Math.signum(target);
      value = lerp(value, target, speed);
    }

    return value;
  }
}
