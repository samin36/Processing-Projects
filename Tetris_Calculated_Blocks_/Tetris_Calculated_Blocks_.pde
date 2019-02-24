int space;
Shape shape, next;
int boundLeft, boundRight;
ArrayList<Shape> doneShapes;
void setup() {
  size(1000, 800);
  space = 50;
  boundLeft = int(width*.25);
  boundRight = int(width*.75);
  shape = new Shape(new PVector(width/2, -space*3), int(random(7)), 1);
  doneShapes = new ArrayList<Shape>();
}

void draw() {
  background(60);
  showNext();
  if (shape.done) {
    doneShapes.add(shape);
    int typ = next.type;
    next = new Shape(new PVector(width/2, -space*3), typ, 1);
    shape = next;
    next = null;
  } 
  shape.moveDown(1000);
  shape.show();
  //shape.moveDown();
  for (Shape prev : doneShapes)
    prev.show();
  drawGrid();
}

void keyPressed() {
  if (!shape.done) {
    if (keyCode == ' ') {
      shape.incrOtion();
      if (shape.outOfBounds())
        shape.decrOtion();
    }
    shape.move();
  }
}

void drawGrid() {
  strokeWeight(1.5);
  stroke(90);
  for (int x = boundLeft; x <= boundRight; x+=space) {
    line(x, 0, x, height);
  }
  for (int y = 0; y < height; y+=space) {
    line(boundLeft, y, boundRight, y);
  }
}


void showNext() {
  if (next==null) {
    next = new Shape(new PVector(width*.85, height*.45), int(random(7)), 1);
  }
  fill(39, 198, 165);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("next: ", width * .88, height * .25);
  next.show();
}
