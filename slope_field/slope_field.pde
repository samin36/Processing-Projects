float xInt, yInt, space;
float max = 5, inc;
void setup() {
  size(600, 600);
  space = ((width/2-40)/max);
}

void draw() {
  background(255);
  translate(width/2, height/2);
  xInt = yInt = .5;
  drawAxis();
  rotate(PI);
  for (float x = -max; x <= max; x+=xInt) {
    for (float y = -max; y <= max; y+=yInt) {
      float angle = calcAngle(x, y);
      pushMatrix();
      translate(x*space, y*space);
      rotate(angle+inc);
      stroke(0);
      strokeWeight(3);
      line(-space*(xInt*.2/.5), 0, space*(xInt*.2/.5), 0);
      popMatrix();
    }
  }
  if (inc <= 0*PI)
    inc+=.08;
}

float calcAngle(float x, float y) {
  float slope = pow(x,2)+pow(y,2);
  //return atan2(sin(x), 1);
  float angle = atan(slope);
  return angle;
}
void drawAxis() {
  float jump = max/xInt;
  for (float i = -max*space; i <= max*space; i+=space*(max/jump)) {
    if (i>-.5 && i<.5) {
      stroke(75);
      strokeWeight(4);
    } else {
      stroke(55);
      strokeWeight(1.5);
    }
    line(i, -max*space, i, max*space);
    line(-max*space, i, max*space, i);
  }
  textSize(20);
  fill(255, 0, 0);
  text(int(-max), -max*space-30, 0);
  text(int(max), max*space+10, 0);
  text(int(max), 0, -max*space-10);
  text(int(-max), 0, max*space+30);
}