
class Player {
  float PlayerX;
  float PlayerY;
  float PlayerZ;
  float zLength = 50;
  float Pos;
  boolean overlap = false;
  boolean alive = true;

  Player (float x, float y, float z) {
    PlayerX = x;
    PlayerY = y;
    PlayerZ = z;
  }

  void update(float x, float y, float z, boolean drawGizmo) {
    PlayerX = x;
    PlayerY= y;
    PlayerZ = z;
    Pos = z + zLength/2;
    if (drawGizmo) drawGizmo(x, y, z);
  }
  void drawGizmo (float x, float y, float z) {
    pushMatrix();
    stroke(#66FF48);
    strokeWeight(5);
    noFill();
    translate(500+x, y, z);
    box (50, 50, zLength);
    popMatrix();
  }
}
