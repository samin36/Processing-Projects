HShape[] currentFour;
float req;
void setup() {
  size(800, 800);
  req = width*.4;
}

void draw() {
  background(0);
  addShape(new HShape(new PVector(width/2, height/2), width*.4));
}


void addShape(HShape h) {
  h.showShape();
  if (h.len >= req) {
    addShape(new HShape(h.left.getStart(), h.len*.5));
    addShape(new HShape(h.left.getEnd(), h.len*.5));
    addShape(new HShape(h.right.getStart(), h.len*.5));
    addShape(new HShape(h.right.getEnd(), h.len*.5));
  }
}
