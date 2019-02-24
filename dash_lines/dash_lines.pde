
float rand;
float xSpace, ySpace;
float range;
float interval;
float strokeWeight;
boolean draw = true, save = true;
color c;

void setup() {
  size(800, 800);
  rand = random(10);
  range = random(0, 10);
  xSpace = 0;
  interval = 50;
  ySpace = interval;
  strokeWeight = interval * .4;
  background(0);
  c = color(0, 255, 0);
}

void draw() {
  //background(0);
  //stroke(map(ySpace, 0, height, 25, 210), 150, map(xSpace, 0, width, 15, 215));
  //stroke(random(0), random(255), random(0), random(200, 255));
  stroke(c);
  strokeWeight(strokeWeight);
  if (draw) {
    if (rand < range/(random(1, 3))) {
      line(xSpace, ySpace-interval, interval + xSpace, ySpace);
    } else {
      line(xSpace, ySpace, interval + xSpace, ySpace-interval);
    }
    xSpace+=interval;
    if (ySpace > height) {
      ySpace=interval;
      draw = false;
      save = false;
      //strokeWeight-=(strokeWeight*.15);
    }
    if (xSpace > width) {
      ySpace+=interval;
      xSpace = 0;
    } 
    range = random(0, 10);
    rand = random(range);
  }
  //if (save)
  //saveFrame("image/" + "dash_line####.tga");
}