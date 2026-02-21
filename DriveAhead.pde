//int width = 1920;
//int height = 1000;

int width = 1000;
int height = 600;

float mouseValue;
Input input;
UI ui;
Headlights hl;
Traffic traffic;
Odometer odometer;
Timer timer;
Steering steering;
Drive drive;
Road road;
 


void settings() {
  size(width, height, P3D);
  
}

void setup() {
input = new Input();
ui = new UI();
hl = new Headlights();
traffic = new Traffic();
traffic.create(10);
odometer = new Odometer();
timer = new Timer();
timer.reset();
steering = new Steering();
drive = new Drive();
road = new Road();

}
  

void draw() {
 //Global Matrix for window scaling
 pushMatrix();

float scaleFactor = min(width/1000.0, height/600.0);
scale(scaleFactor);

translate( (width/scaleFactor - 1000)/2,
           (height/scaleFactor - 600)/2 );

background(0);

//Ui
odometer.countDistance(drive.value(), timer.deltaTime);
ui.odometer(odometer.distanceKm);
ui.speedoMeter(drive.value());
ui.elapsedTime(timer.Value());




//Controllers
steering.wheel();
drive.pedals();
hl.HeadLight(steering.value());
road.DrawRoad(steering.value(),drive.value());
traffic.spawn(drive.value(),steering.value());





//Global Matrix pop
popMatrix();
}

void keyPressed() {
  input.press(key);
}

void keyReleased() {
  input.release(key);
}
