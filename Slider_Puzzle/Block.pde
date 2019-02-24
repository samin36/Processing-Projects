class Block {
  PImage filler;
  PVector loc, destination;
  int number, r, c;
  boolean showBlock, canMove, hasPair;
  float step;
  Block pair;

  Block(PVector pos, PImage part, int number_, int r_, int c_, boolean show) {
    loc = pos;
    filler = part;
    number = number_;
    r = r_;
    c = c_;
    showBlock = show;
    destination = new PVector(0, 0);
    step = (showBlock) ? .2 : 1;
  }

  void show() {
    if (showBlock) {
      image(filler, loc.x, loc.y, space, space);

      if (start) {
        fill(255);
        textAlign(CENTER, CENTER);
        textSize(32);
        text(number, loc.x + space*.20, loc.y + space*.20);
      }
    } else {
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(24);
      text("Moves:", loc.x + space*.5, loc.y + space*.25);
      textSize(32);
      text(moves, loc.x + space*.5, loc.y+space*.5);
    }
    if (start) {
      strokeWeight(2);
      stroke(255);
      noFill();
      rect(loc.x, loc.y, space, space);
    }
  }

  void move() {
    if (canMove) {
      if (loc.dist(destination) != 0) {
        loc.lerp(destination, step);
        if (step<.5) {
          step+=.05;
        }
      } else {
        destination = null;
        canMove = false;
        step = (showBlock) ? .2 : 1;
        nullPair();
      }
    }
    // updateIndex();
  }

  void setMovement(PVector dest) {
    if (!canMove) {
      canMove = true;
      destination = dest;
    }
  }

  void updateIndex() {
    r = int(loc.y/space);
    c = int(loc.x/space);
  }

  void setPair(Block b) {
    pair = b; 
    hasPair = true;
  }

  void nullPair() {
    pair = null;
    hasPair = false;
  }
}
