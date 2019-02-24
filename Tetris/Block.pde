class Block {
  PVector loc;
  color c;
  int index;
  Block(PVector pos, color col, int i) {
    loc = pos;
    c = col;
    index = i;
  }

  void show(color str) {
    stroke(str);
    strokeWeight(3);
    fill(c);
    rect(loc.x, loc.y, space, space);
    //fill(255);
    //textAlign(CENTER, CENTER);
    //text(index, loc.x+space/2, loc.y+space/2);
  }

  void moveUp() {
    loc.add(new PVector(0, -space));
  }

  void moveDown() {
    loc.add(new PVector(0, space));
  }

  void moveLeft() {
    loc.add(new PVector(-space, 0));
  }

  void moveRight() {
    loc.add(new PVector(space, 0));
  }
}
