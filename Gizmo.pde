class Gizmo {

  void messureLines(float a, float b) {
    pushMatrix();
    stroke(#66FF48);
    strokeWeight(2);
    noFill();
    translate(500, 336, a);
    box (width, 0, b);
    popMatrix();
  }
}
