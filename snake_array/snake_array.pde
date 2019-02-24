int[] x, y;
float count = 0;
int numPos = 50;
PShape s;
void setup() {
  size(800, 800);
  x = new int[numPos];
  y = new int[numPos];
  for (int i = 0; i < numPos; i++) {
    x[i] = 0;
    y[i] = 0;
  }
  //s = loadShape("vector.svg");
  background(255);
}

void draw() {
  background(255);
  noStroke();
  shift();
  float noise = tan(noise(count/10, count));
  x[numPos-1] = int(map(noise, 0, 1, 0, width));
  count+=.01;
  noise = noise(count, numPos);
  y[numPos-1] = int(map(noise, 0, 1, 0, height));
  //x[numPos-1] = mouseX;
  //y[numPos-1] = mouseY;
  for (int i = 0; i < numPos; i++) {
    int weight = int(map(i, 0, numPos, 0, 65));
    if (i % 1 != 0) {
      noFill();
      //fill(map(mouseX, 0, width, 0, 195), map(mouseY, 0, height, 0, 185), weight+150);
    } else {
      fill(map(weight, 0, 65, 0, 75));
    }
    ellipse(x[i], y[i], weight, weight);
    //stroke(0);
    //line(x[i], y[i], x[i] + weight, y[i] + weight);
  }
}

void shift() {
  for (int i = 0; i < numPos-1; i+=1) {
    x[i] = x[i+1];
    y[i] = y[i+1];
  }
}