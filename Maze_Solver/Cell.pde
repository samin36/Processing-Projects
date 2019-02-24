class Cell {
  PVector right, bottom, start;
  boolean isVisited, tried, backtrack;
  int w, h, r, b;
  color c;
  float weight;
  // float angle;
  Cell(PVector start) {
    this.start = start;
    w = spaceCol;
    h = spaceRow;
    r=1;
    b=1;
    weight = 3;
    c = color(0, 255, 0);
    right = new PVector(start.x+w, start.y+h);
    bottom = new PVector(start.x, start.y+h);
    isVisited = false;
    tried = false;
  }


  void drawCurr() {
    noStroke();
    fill(255, 0, 0);
    rect(start.x, start.y, w, h);
  }

  void drawIfVisited(color c, float factor) {
    if (isVisited) {
      noStroke();
      fill(c);
      rect(start.x+factor, start.y+factor, w-1.5*factor, h-1.5*factor);
    }
  }

  void drawIfTried(color c, float factor) {
    if (backtrack) {
      noStroke();
      fill(c);
      rect(start.x+factor, start.y+factor, w-2*factor, h-2*factor);
    } else if (tried) {
      noStroke();
      fill(255-red(c), 255-green(c), 255-blue(c));
      rect(start.x+factor, start.y+factor, w-2*factor, h-2*factor);
    }
  }
  void drawLines() {
    //0 means don't draw and 1 means draw
    strokeWeight(weight);
    strokeCap(SQUARE);
    if (r==1) {
      stroke(c);
      line(start.x+spaceCol, start.y, right.x, right.y);
    }
    if (b==1) {
      stroke(c);
      line(right.x, right.y, bottom.x, bottom.y);
    }
  }

  void setTried() {
    tried = true;
  }

  boolean tried() {
    return tried;
  }

  void setVisited() {
    isVisited = true;
  }

  boolean isVisited() {
    return isVisited;
  }
}
