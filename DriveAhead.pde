//int width = 1920;
//int height = 1000;

int width = 1000;
int height = 600;

float mouseValue;
Input input;
UI ui;
Headlights hl;
Vehicle vehicle;
Traffic traffic;
Odometer odometer;
Timer timer;


void settings() {
  size(width, height, P3D);
  
}


 Steer steer = new Steer();
 Drive drive = new Drive();
 Road road = new Road();
 


void setup() {
   colorMode(RGB, 255, 255, 255);
  // surface.setResizable(true);
  //fullScreen(P3D);
input = new Input();
ui = new UI();
hl = new Headlights();
//vehicle = new Vehicle(false, color(242, 0, 188), 1);
traffic = new Traffic();
traffic.create(6);
odometer = new Odometer();
timer = new Timer();
timer.reset();
}
  

void draw() {
 pushMatrix();

float scaleFactor = min(width/1000.0, height/600.0);
scale(scaleFactor);

translate( (width/scaleFactor - 1000)/2,
           (height/scaleFactor - 600)/2 );





background(0);
//pointLight(255, 255, 255, 50, 70, 100);

pushMatrix();

odometer.countDistance(drive.DriveValue(), timer.deltaTime);
ui.Odometer(odometer.distanceKm);
ui.speedoMeter(drive.DriveValue());
ui.ElapsedTime(timer.Value());

popMatrix();

//ambientLight(150,150,150);

steer.WheelKeys();
drive.Gas();
hl.HeadLight(steer.SteerValue());
road.DrawRoad(steer.SteerValue(),drive.DriveValue());


traffic.spawn(drive.DriveValue());

//traffic.Run(drive.DriveValue());




popMatrix();
}

void keyPressed() {
  input.press(key);
}

void keyReleased() {
  input.release(key);
}
