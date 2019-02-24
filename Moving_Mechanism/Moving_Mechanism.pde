PVector pos, destination;
boolean canMove;
void setup() {
  size(600, 600);
  pos = new PVector(0, 0);
  destination = new PVector(0, 0);
}

void draw() {
  background(0);

  move();

  fill(200, 0, 255);
  strokeWeight(4);
  rect(pos.x, pos.y, width/2, height);
}

void keyPressed() {
  if (keyCode==RIGHT) {
    if (!canMove) {
      canMove=true;
      destination = new PVector(pos.x+width/2, pos.y);
    }
  }
  if (keyCode==LEFT) {
    if (!canMove) {
      canMove=true;
      destination = new PVector(pos.x-width/2, pos.y);
    }
  }
}

void move() {
  if (canMove) {
    if (pos.dist(destination) > .1) 
      pos.lerp(destination, .1);
    else 
    canMove=false;
  }
}
