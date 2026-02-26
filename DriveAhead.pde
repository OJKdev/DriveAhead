import processing.sound.*;
SawOsc saw;
SinOsc sq;

String pName = "";



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

float currentFreqL;
float currentFreqH;




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
  ui = new UI();

  saw = new SawOsc(this);
  saw.play();
  sq = new SinOsc(this);
  sq.play();
  //gizmo = new Gizmo();
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

    pushMatrix();
    //background(#00080F);
    float cycleLength = 600.0;
    float ti = (timer.timer) % cycleLength;

    float phase = map(ti, 0, cycleLength, 0, TWO_PI);
    float dayAmount = (sin(phase - HALF_PI) + 1) * 0.5;

    color nightColor = color(0, 8, 15);
    color dayColor   = color(135, 206, 235);
    color bgColor = lerpColor(nightColor, dayColor, dayAmount);

    background(bgColor);

    // Ljuset
    float ambientR = lerp(0, 200, dayAmount);
    float ambientG = lerp(0, 200, dayAmount);
    float ambientB = lerp(0, 220, dayAmount);

    ambientLight(ambientR, ambientG, ambientB);
    popMatrix();
    pushMatrix();
    //Ui

    odometer.countDistance(drive.value(), timer.deltaTime);
    //hint(DISABLE_DEPTH_TEST);

    ui.odometer(odometer.distanceKm);
    ui.speedoMeter(drive.value());
    ui.elapsedTime(timer.Value());
    ui.countPoints();


    popMatrix();

    //Controllers
    steering.wheel();
    drive.pedals();
    hl.HeadLight(steering.value());
    road.DrawRoad(steering.value(), drive.value());
    player.update(0, 311, 500, false);//bool enables player gizmo
    traffic.spawn(drive.value(), steering.value());
    sound();

    //gizmo.messureLines(-1423, 0);

    pushMatrix();
    //Ui

    ambientLight(255, 255, 255);
    odometer.countDistance(drive.value(), timer.deltaTime);
    //hint(DISABLE_DEPTH_TEST);

    ui.odometer(odometer.distanceKm);
    ui.speedoMeter(drive.value());
    ui.elapsedTime(timer.Value());
    ui.countPoints();


    popMatrix();


    //hint(ENABLE_DEPTH_TEST);
  } else {
    background(#FFFFFF);


    saw.stop();

    sq.stop();

    ui.EndScreen(timer.Value(), player);
  }

  //Global Matrix pop
  popMatrix();
}

void keyPressed() {


  if (ui.skipaAhead == true) {
    if (key == BACKSPACE && pName.length() > 0) {
      pName = pName.substring(0, pName.length()-1);
    } else if (key == ENTER || key == RETURN) {
      println("Du skrev: " + pName);
      START = true;
      player.alive=true;
      ui.skipaAhead = false;
    } else if (key != CODED) {
      pName += key;
    }
  } else input.press(key);
}

void keyReleased() {
  input.release(key);
}


void daynight() {
}

void sound () {
  if (drive.gearRate >= 0.4) {
    currentFreqL = 0;
    currentFreqH = 50;
  }
  if (drive.gearRate <= 0.4 && drive.gearRate >= 0.15) {
    currentFreqL = 0;
    currentFreqH = 250;
  }
  if (drive.gearRate <= 0.15 && drive.gearRate >= 0.05) {
    currentFreqL = 0;
    currentFreqH = 200;
  }
  if (drive.gearRate <= 0.05 && drive.gearRate >= 0.01) {
    currentFreqL = 0;
    currentFreqH = 150;
  }
  if (drive.gearRate <= 0.01) {
    currentFreqL = 0;
    currentFreqH = 100;
  }



  float fr = map(drive.value(), 0, 20, currentFreqL, currentFreqH);
  fr = constrain(fr, 0, 10000);
  float frs = map(drive.value(), 0, 20, currentFreqL-20, currentFreqH-20);
  frs = constrain(frs, 0, 10000);
  println(drive.gearRate);

  saw.freq(fr);
  sq.freq(frs);
}
