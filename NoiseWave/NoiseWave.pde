float yOff;
void setup() {
  size(640, 360);
}

void draw() {
  background(51);
  fill(255);
  beginShape();
  smooth();
  float xOff = yOff;
  for (float x = 0; x <= width; x+=10) {
    float h = map(noise(xOff), 0, 1, 200, 300);
    vertex(x, h);
    xOff+=.05;
  }
  // xOff=.01*frameCount;
  yOff+=.01;
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
}