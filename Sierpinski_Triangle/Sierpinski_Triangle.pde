PVector point1, point2, point3;
float lerpStep;
int order;
ArrayList<Triangle> triangles;
void setup() {
  size(921, 800);
  point1 = new PVector(width/2, 10);
  point2 = new PVector(width-10, height-10);
  point3 = new PVector(10, height-10);
  triangles = new ArrayList<Triangle>();
}

void draw() {
  background(0);
  if (lerpStep < .5)
    lerpStep+=.5;
  else
    lerpStep=.5;
  for (Triangle t : triangles)
  t.show();
}

void mousePressed() {
 drawTriangle(++order, point1, point2, point3, color(0, 255, 0)); 
}

void drawTriangle(int order, PVector p1, PVector p2, PVector p3, color c) {
  if (order == 0) {
    triangles.add(new Triangle(p1, p2, p3, c));
  } else {
    PVector p12 = midPoint(p1, p2);
    PVector p23 = midPoint(p2, p3);
    PVector p31 = midPoint(p3, p1);
    drawTriangle(order - 1, p1, p12, p31, color (0, 255, 0));
    drawTriangle(order - 1, p12, p2, p23, color(255, 0, 0));
    drawTriangle(order - 1, p31, p23, p3, color(0, 0, 255));
    //drawTriangle(order - 1, p12, p23, p31, color(200, 0, 255));
    //drawTriangle(0, p1, p2, p3, color(0, 255, 0));
  }
}

PVector midPoint(PVector p1, PVector p2) {
  return PVector.lerp(p1, p2, lerpStep);
}
