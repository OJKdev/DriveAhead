class UI {
  String speed = "0";
 
  public void speedoMeter(float speedValue) {
    speed = str(round(speedValue*10));
    
textSize(60);
text(speed+" km/h", 40, 120); 

  }
  
  
}
