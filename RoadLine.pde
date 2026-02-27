class RoadLine {
  float LineStart;
  float Length;


  RoadLine(float lineStart, float length) {
    LineStart = lineStart;
    Length = length;
  }


  public void Line(float laneOffset) {
    pushMatrix();

    translate(500+laneOffset, 337, LineStart);
    rotateY(0.0);
    fill(255);
    
    noStroke();
    box(-4, 0, Length);
    popMatrix();
   
  }
  public void update (float speed) {
     LineStart +=speed;
  }
}
