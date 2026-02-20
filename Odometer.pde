class Odometer {
  float distanceKm = 0;
  float distanceMeters;
  
  void countDistance (float playerSpeed, float deltaTime) { 
  float speedMs = playerSpeed / 3.6;

  distanceMeters  += speedMs * deltaTime;
  distanceKm = distanceMeters / 100.0;
  
  }
  
}
