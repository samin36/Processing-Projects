float[] x, y, sample;
float noise_val = 0;
void setup() {
  size(800, 800);
  x = new float[50];
  y= new float[50];
  for (int i = 0; i < x.length; i++) {
    x[i] = 0;
    y[i] = 0;
  }
}

void draw() {
  background(255);
  shiftArray(x);
  shiftArray(y);
  x[0] = map(cos(noise_val), -1, 1, (3*width)/20, (17*width)/20);
  y[0] = map(sin(cos(4 * noise_val)), -1, 1, (3*height)/20, (17*height)/20);
  drawAllPoints();
  noise_val+=.1 * cos(noise(noise_val));
}

void drawAllPoints() {
  noStroke();
  for (int i = x.length-1; i >= 0; i--) {
    //fill(map(i, 0, x.length, 0, 255), 
    //  map(x[i], 0, width, 0, 255), 
    //  map(y[i], 0, height, 0, 255), 
    //  map(i, 0, x.length, 0, 255));
    fill(0, map(i, 0, x.length, 20, 100));
    ellipse(x[i], y[i], 75, 75);
  }
}

void shiftArray(float[] arr) {
  for (int i = arr.length-1; i > 0; i--) {
    arr[i] = arr[i-1];
  }
}