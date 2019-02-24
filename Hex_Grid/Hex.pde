class Hex {
  PVector[] pos;
  float x, y, r, ang, angVel;
  color c;
  Hex(float x_, float y_, float r_, float angVel_) {
    pos = new PVector[6];
    x = x_;
    y = y_ - r_;
    r = r_;
    calculate(x, y, r);
    c = color(map(sin(angVel_), -1, 1, 0, 255), 255, 0);
    ang = PI/2;
  }

  void calculate(float x, float y, float r) {
    pos[0] = new PVector(x, y);
    pos[1] = new PVector(pos[0].x + sin(PI/3)*r, pos[0].y + cos(PI/3)*r);
    pos[2] = new PVector(pos[1].x, pos[1].y+r);
    pos[3] = new PVector(pos[0].x, pos[0].y + 2*r);
    pos[4] = new PVector(pos[0].x - sin(PI/3)*r, pos[2].y);
    pos[5] = new PVector(pos[4].x, pos[1].y);
  }

  void drawHex() {
    pushMatrix();
    translate(x, y + r);
    calculate(0, 0 - r, r);
    rotate(ang);
    beginShape();
    noFill(); 
    strokeWeight(3);
    stroke(c);
    vertex(pos[0].x, pos[0].y);
    vertex(pos[1].x, pos[1].y);
    vertex(pos[2].x, pos[2].y);
    vertex(pos[3].x, pos[3].y);
    vertex(pos[4].x, pos[4].y);
    vertex(pos[5].x, pos[5].y);
    endShape(CLOSE);
    popMatrix();
    ang+=angVel;
  }
}