void setup() {
  size(800, 800);
}

void draw() {
  background(0);
  drawLine(width/4, height, 300);
}

void drawLine(float x, float y, float len) {
  if (len > 5) {
    stroke(255);
    strokeWeight(2);
    pushMatrix();
    translate(x, y);
    rotate(PI/4);
    line(0, 0, 0, -len);
    popMatrix();
    drawLine(x, y-len, len/2);
  }
}
