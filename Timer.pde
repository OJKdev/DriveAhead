class Timer {

float timer = 0;
float deltaTime;
int lastTime;

void reset() {
  lastTime = millis();
}

public float Value() {
  int currentTime = millis();
  deltaTime = (currentTime - lastTime) / 1000.0;
  lastTime = currentTime;

  timer += deltaTime;

  return timer;
}



}
