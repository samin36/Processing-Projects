class Line {
  float x, y, x2, y2;
  color c;
  float strokeWeight;
  Line(float x_, float y_, float x2_, float y2_) {
    x = x_;
    y = y_;
    x2 = x2_;
    y2 = y2_;
    c = color(0, 255, 0);
  }

  void drawLine() {
    stroke(c);
    strokeWeight(1.5);
    noFill();
    beginShape();
    vertex(x, y);
    vertex(x2, y2);
    endShape(CLOSE);
  }
  void update() {
    y-=5;
    y2-=5;
  }
}