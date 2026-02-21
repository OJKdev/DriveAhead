class Player {
  float PlayerX;
  float PlayerY;
  float PlayerZ;

  Player (float x, float y, float z) {
    PlayerX = x;
    PlayerY = y;
    PlayerZ = z;
  }

  void update(float x, float y, float z, boolean drawGizmo) {
    PlayerX = x;
    PlayerY= y;
    PlayerZ = z;
    if (drawGizmo) drawGizmo(x,y,z);
  }
  void drawGizmo (float x, float y, float z) {
    pushMatrix();
    stroke(#66FF48);
    strokeWeight(5);
    
     translate(500+x, y, z);
    box (50, 50, 50);
    print("playergizmo");
    popMatrix();
    
    
    
  }
}
