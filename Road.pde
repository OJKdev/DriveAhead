class Road {
  float LaneOffset = 0;
  float speed = 0;
  ArrayList<RoadLine> roadLines = new ArrayList<RoadLine>();

  public void DrawRoad (float laneOffset, float speed) {

    LaneOffset = laneOffset;


    OffRoad();

    RoadLines(speed);
    TheRoad();
    //Lines();
    LeftRoadSide();
    RightRoadSide();
  }
  public void OffRoad() {
    pushMatrix();

    translate(500+LaneOffset, 351, 0);
    rotateY(0.0);
    fill(28, 107, 4);
    noStroke();
    box(3000, 6, 1723);
    popMatrix();
  }

  public void TheRoad() {
    pushMatrix();

    translate(500+LaneOffset, 341, 354);
    rotateY(0.0);
    fill(255);
    noStroke();
    box(335, -2, 3234);
    popMatrix();
  }

  public void Lines() {
    pushMatrix();

    translate(500+LaneOffset, 337, -350);
    rotateY(0.0);
    fill(255);
    stroke(163);
    box(-4, 2, 107);
    popMatrix();
  }

  void RoadLines(float speed) {
    int linesAmount = 12;
    float lineStart = 435;
    float length = 20;
    float spacing = 50;
    for (int i = 0; i < linesAmount; i++) {

      roadLines.add(new RoadLine(lineStart-((length+spacing)*i), length));
      RoadLine line = roadLines.get(i);
      line.Line(LaneOffset);
      line.update(speed);
      if (line.LineStart > lineStart+spacing) line.LineStart = lineStart-((length+spacing)*(linesAmount-1));
    }
  }







  public void LeftRoadSide() {
    pushMatrix();

    translate(666+LaneOffset, 336, 80);
    rotateY(0.0);
    fill(255);
    noStroke();
    box(-4, 4, 2500);
    popMatrix();
  }
  public void RightRoadSide() {
    pushMatrix();

    translate(333+LaneOffset, 336, 80);
    rotateY(0.0);
    fill(255);
    noStroke();
    box(-4, 4, 2500);
    popMatrix();
  }
}
