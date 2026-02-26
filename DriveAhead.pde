
int width = round(1000*1.5);
int height = round(600*1.5);

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
Player player;
Gizmo gizmo;

Boolean START = false;




void settings() {
  size(width, height, P3D);
  //fullScreen(P3D);
}

void setup() {

  surface.setLocation(0, 0);

  float fov = PI/2.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);

  startUp();
}

void startUp() {
  float randomHeight = random(2.0, 2.15);
  camera(width/2.0, height/randomHeight, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);

  input = new Input();
  ui = new UI();
  hl = new Headlights();
  player = new Player(0, 0, 0);
  traffic = new Traffic();
  traffic.create(4);
  odometer = new Odometer();
  timer = new Timer();
  timer.reset();
  steering = new Steering();
  drive = new Drive();
  road = new Road();

  gizmo = new Gizmo();
}


void draw() {

  //Global Matrix for window scaling
  pushMatrix();
  float scaleFactor = min(width/1000.0, height/600.0);
  scale(scaleFactor);
  translate( (width/scaleFactor - 1000)/2,
    (height/scaleFactor - 600)/2 );

  if (player.alive) {
    if (START) {
      startUp();
      START = false;
    }
    background(#00080F);

    //Ui
    odometer.countDistance(drive.value(), timer.deltaTime);
    ui.odometer(odometer.distanceKm);
    ui.speedoMeter(drive.value());
    ui.elapsedTime(timer.Value());
    ui.countPoints();

    //Controllers
    steering.wheel();
    drive.pedals();
    hl.HeadLight(steering.value());
    road.DrawRoad(steering.value(), drive.value());
    player.update(0, 311, 500, false);//bool enables player gizmo
    traffic.spawn(drive.value(), steering.value());
    //gizmo.messureLines(0, 0);
  } else {
    background(#FFFFFF);
    ui.EndScreen(timer.Value(), player);
  }

  //Global Matrix pop
  popMatrix();
}

void keyPressed() {
  input.press(key);
}

void keyReleased() {
  input.release(key);
}
