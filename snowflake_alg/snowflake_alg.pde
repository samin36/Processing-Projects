//Koch snowflake
ArrayList<Line> flakes;
float level;
void setup() {
  size(1850, 600);
  flakes = new ArrayList<Line>();
  eqt();
  level = 1;
  //eqParts();
  // background(0);
}

void draw() {
  background(0);
  eqParts();
  for (Line lines : flakes) {
    // lines.update();
    lines.drawLine();
  }
  //level=256;
  textSize(64);
  fill(100, 255, 0);
  text(flakes.size(), 100, 128);
}

void eqt() {
  float dist = 2;
  flakes.add(new Line(dist/2, height-dist, width-dist/2, height-dist));
  //flakes.add(new Line(0, height, width, height/2));
  //flakes.add(new Line(width/2-dist, height/2+dist, width/2+dist, height/2+dist));
  //// flakes.add(new Line(random(width), random(height), random(width), random(height)));
  //float x = calcThird(flakes.get(0))[0], y = calcThird(flakes.get(0))[1];
  //Line f = flakes.get(0);
  //flakes.add(new Line(f.x, f.y, x, y));
  //flakes.add(new Line(x, y, f.x2, f.y2));
  //// flakes.add(new Line(0, height, width, 0));
}

void eqParts() {
  //step 2: cuts a line into three equal parts 
  //and removes original line
  for (int i = 0; i < flakes.size(); i+=4) {
    if (flakes.size() < level) {
      Line curr = flakes.get(i);

      float thirdX = calcPointX(1/3.0, curr), thirdY = calcPointY(1/3.0, curr);
      float third2X = calcPointX(2/3.0, curr), third2Y = calcPointY(2/3.0, curr);
      Line line1 = new Line(curr.x, curr.y, thirdX, thirdY);
      Line line2 = new Line(thirdX, thirdY, third2X, third2Y);
      Line line3 = new Line(third2X, third2Y, curr.x2, curr.y2);
      flakes.remove(i);
      flakes.add(i, line1);
      eqTriangle(line2, i);
      flakes.add(i+3, line3);
    }
  }
}
float calcPointX(float part, Line l) {
  return (l.x + (part) * (l.x2 - l.x));
}
float calcPointY(float part, Line l) {
  return (l.y + (part) * (l.y2 - l.y));
}
void eqTriangle(Line second, int loc) {
  //Draw eq. triangle using middle line as base
  //Formula Reference: https://math.stackexchange.com/questions/1183349/find-the-coordinate-of-third-point-of-equilateral-triangle
  Line secLeft = cloneLine(second), secRight = cloneLine(second);
  float newXpoint, newYpoint;
  newXpoint = calcThird(second)[0];
  newYpoint = calcThird(second)[1];
  secLeft.x2 = newXpoint;
  secLeft.y2 = newYpoint;
  secRight.x = newXpoint;
  secRight.y = newYpoint;
  flakes.add(loc+1, secLeft);
  flakes.add(loc+2, secRight);
}

float[] calcThird(Line l) {
  float[] ans = new float[2];
  float resX, resY;

  resX = (l.x+l.x2-sqrt(3)*(l.y-l.y2))/2.0;
  resY = (l.y+l.y2+sqrt(3)*(l.x-l.x2))/2.0;
  ans[0] = resX;
  ans[1] = resY;
  return ans;
}

Line cloneLine(Line l) {
  float x = l.x, y = l.y, x2 = l.x2, y2 = l.y2;
  return new Line(x, y, x2, y2);
}

void mousePressed() {
  level*=4;
}