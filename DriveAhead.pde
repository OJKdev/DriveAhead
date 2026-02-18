int width = 1000;
int height = 600;
float mouseValue;
Input input;
UI ui;
Headlights hl;



void settings(){
  size(width, height, P3D);

}
 Steer steer = new Steer();
 Drive drive = new Drive();
 Road road = new Road();
 


void setup() {
input = new Input();
ui = new UI();
hl = new Headlights();
}
  

void draw() {
background(0);
//pointLight(255, 255, 255, 50, 70, 100);


ui.speedoMeter(drive.DriveValue());

//ambientLight(2,20,20);

steer.WheelKeys();
drive.Gas();
hl.HeadLight(steer.SteerValue());
road.DrawRoad(steer.SteerValue(),drive.DriveValue());

 

}

void keyPressed() {
  input.press(key);
}

void keyReleased() {
  input.release(key);
}
