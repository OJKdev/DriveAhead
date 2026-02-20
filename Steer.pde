class Steering {
  
float value = 0;     // aktuellt värde
  float target = 0;    // vart vi vill
  float speed = 0.1;   // hur snabbt den lerpar
  
  float maxValue = 100;
  float step = 3;
  




  void Wheel() {

    // sätt target beroende på knapp
    
      if (input.isDown('A')) target += step;
      if (input.isDown('D')) target -= step;
    

    // mjuk rörelse mot target
    if (value > maxValue*-1 && value < maxValue) {
    value = lerp(value, target, speed);} else {
    target = (maxValue-1) * Math.signum(target);
  value = lerp(value, target, speed); }
   
  }

  float Value() {
    
   // println("value:" + value + "target:" + target);
    return value;
  }

}
