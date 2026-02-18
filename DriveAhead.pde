int width = 1000;
int height = 600;
float mouseValue;


void settings(){
  size(width, height, P3D);

}
 Steer steer = new Steer();
 Drive drive = new Drive();
 Road road = new Road();
 


void setup() {

}
  

void draw() {
background(0);
pointLight(255, 255, 255, 50, 70, 100);
steer.WheelKeys();
drive.Gas();

road.DrawRoad(steer.SteerValue(),drive.DriveValue());


}
