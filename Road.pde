class Road {
  float LaneOffset = 0;
  float speed = 0;
  ArrayList<RoadLine> roadLines = new ArrayList<RoadLine>();



  public void DrawRoad (float laneOffset, float speed) {
    RoadLines(speed);
    LaneOffset = laneOffset;
    OffRoad();
    TheRoad();
    //Lines();
    LeftRoadSide();
    RightRoadSide();
  }
  public void OffRoad() {
    pushMatrix();

    translate(500+LaneOffset, 344, 0);
    rotateY(0.0);
    fill(28, 107, 4);
    stroke(0);
    box(1350, 6, 910);
    popMatrix();
  }

  public void TheRoad() {
    pushMatrix();

    translate(500+LaneOffset, 341, 0);
    rotateY(0.0);
    fill(163, 163, 163);
    stroke(0);
    box(335, 6, 910);
    popMatrix();
  }

  public void Lines() {
    pushMatrix();

    translate(500+LaneOffset, 337, -350);
    rotateY(0.0);
    fill(255);
    stroke(163);
    box(-4, 0, 107);
    popMatrix();
  }

  void RoadLines(float speed) {
    int linesAmount = 12;
    float lineStart = 435;
    float length = 20;
    float spacing = 50;
    for (int i = 0; i < linesAmount; i++) {
      //if (i==0) roadLines.add(new RoadLine(lineStart, length));
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
    stroke(163);
    box(-4, 4, 920);
    popMatrix();
  }
  public void RightRoadSide() {
    pushMatrix();

    translate(333+LaneOffset, 336, 80);
    rotateY(0.0);
    fill(255);
    stroke(163);
    box(-4, 4, 920);
    popMatrix();
  }
}
