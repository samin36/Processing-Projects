class Box {
  PVector loc;
  float size;
  Box(PVector pos, float s) {
    loc = pos;
    size = s;
  }

  void show() {
    //stroke(0);
    noStroke();
    fill(210, 0, 255);
    //fill(255);
    pushMatrix();
    translate(loc.x, loc.y, loc.z);
    box(size);
    popMatrix();
  }
}
