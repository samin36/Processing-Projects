float x0, y0, x, y;
int iteration, max_iteration;
float xtemp;
color c;
float xMin, xMax, yMin, yMax;
void setup() {
  size(800, 800);
  colorMode(HSB);
  max_iteration = 1000;
  xMin = -2.5;
  xMax = 1;
  yMin = -1.2;
  yMax = 1.2;
}

void draw() {
  background(0);
  loadPixels();
  for (int xP = 0; xP < width; xP++) {
    for (int yP = 0; yP < height; yP++) {
      x0 = map(xP, 0, width, xMin, xMax);
      y0 = map(yP, 0, height, yMin, yMax);
      x = 0;
      y = 0;
      iteration = 0;
      while (x*x + y*y < 4 && iteration < max_iteration) {
        xtemp = x*x - y*y + x0;
        y = 2*x*y + y0;
        x = xtemp;
        iteration+=40;
      }
      c = color(100, 255, map(iteration, 0, max_iteration, 0, 255));
      int loc = xP + yP * width;
      pixels[loc] = c;
    }
  }
  updatePixels();
}