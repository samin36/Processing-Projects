ArrayList<Line> lines;
float spacing;
Line l1, l2, l3;
ArrayList<Line> nextStep;
int order;
float angle;
void setup() {
  size(800, 800);
  spacing = 100;
  lines = new ArrayList<Line>();
  nextStep = new ArrayList<Line>();
  l1 = new Line(new PVector(spacing, height-spacing*2), new PVector(width-spacing, height-spacing*2));
  l2 = new Line(l1.end.copy(), l1.rotateBy(PI/3));
  l3 = new Line(l2.end.copy(), l1.start.copy());
  lines.add(l1);
  lines.add(l2);
  lines.add(l3);
  drawFlake(order, lines);
  if (order==0)
    nextStep.addAll(lines);
}

void draw() {
  background(0);
  for (Line curr : nextStep) {
    pushMatrix();
    translate(curr.start.x, curr.start.y);
//    rotate(angle);
    curr.showLine();
    popMatrix();
  }
  //angle+=1;
}

void mousePressed() {
  drawFlake(++order, lines);
}

void drawFlake(int order, ArrayList<Line> l) {
  if (order > 0) {
    nextStep.clear();
    for (Line curr : l) {
      nextStep.addAll(curr.getFourLines(5*PI/3));
      //println(nextStep.size());
    }
    drawFlake(order - 1, (ArrayList<Line>) nextStep.clone());
  }
}
