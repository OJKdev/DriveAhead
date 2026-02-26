class Steering {

  float value = 0;
  float target = 0;
  float speed = 0.1;

  float maxValue = 100;
  float step = 3;

  void wheel() {


    if (input.isDown('A')) target += step;
    if (input.isDown('D')) target -= step;

    //lerp to target
    if (value > maxValue*-1 && value < maxValue) {
      value = lerp(value, target, speed);
    } else {
      target = (maxValue-1) * Math.signum(target);
      value = lerp(value, target, speed);
    }
  }

  float value() {
    return value;
  }
}
