class Block {

  PVector loc;
  boolean isHinge;

  Block(PVector loc_, boolean isHinge_) {
    loc = loc_;
    isHinge = isHinge_;
  }

  void setHinge(boolean isHinge_) {
    isHinge = isHinge_;
  }

  void setLoc(PVector loc_) {
    loc = loc_.copy();
  }

  void show() {
    if (isHinge) {
      fill(255, 220, 0);
    } else {
      fill(255, 0, 0);
    }
    noStroke();
    rectMode(CENTER);
    rect(loc.x, loc.y, size * .9, size * .9);
    //textAlign(CENTER, CENTER);
    //fill(0);
    //textSize(12);
    //text(""+floor(loc.x)+","+floor(loc.y), loc.x, loc.y);
  }
}
