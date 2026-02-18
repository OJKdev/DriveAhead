class Headlights {

  public void HeadLight(float laneOffset) {

    spotLight(253, 255, 193,
      400+laneOffset, 312, 793, // position (kameran)
      -4, 1, -5, // riktning
      PI/6.5, // vinkel (smalare = mer koncentrerad)
      3);
    spotLight(252, 253, 205,
      500+laneOffset, 326, 479, // position (kameran)
      0, 1, -5, // riktning
      PI/6.6, // vinkel (smalare = mer koncentrerad)
      45);
    spotLight(253, 255, 193,
      600+laneOffset, 311, 830, // position (kameran)
      4, 1, -5, // riktning
      PI/6.6, // vinkel (smalare = mer koncentrerad)
      3);
     /* spotLight(253, 253, 253,
      500.0, 267.0, 599.0, // position (kameran)
      -0.0, -0.6, -2.7, // riktning
      12.2, // vinkel (smalare = mer koncentrerad)
      7.0); */
      

    //HeadLightGizmo(x, y, z);
  }
  public void HeadLightGizmo(float x, float y, float z) {
    pushMatrix();

    stroke(200);
    translate(x, y, z);
    sphere(10);
    popMatrix();
  }
}
