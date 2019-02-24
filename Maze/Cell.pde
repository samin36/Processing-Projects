class Cell {
  PVector left, top, right, bottom, start;
  boolean isVisited;
  int w, h, l, t, r, b;
  // float angle;
  Cell(PVector start) {
    this.start = start;
    w = spaceCol;
    h = spaceRow;
    l=1;
    t=1;
    r=1;
    b=1;
    //  angle = 0;
    //top = new PVector(start.x+w, start.y);
    //right = new PVector(top.x, top.y+h);
    //bottom = new PVector(right.x-w, right.y);
    //left = new PVector(start.x, start.y);
    top = new PVector(start.x+w, start.y);
    right = new PVector(start.x+w, start.y+h);
    bottom = new PVector(start.x, start.y+h);
    left = new PVector(start.x, start.y);
    isVisited = false;
  }


  void drawCurr() {
    noStroke();
    fill(200, 255, 0);
    rect(start.x, start.y, w, h);
  }

  void drawIfVisited(color c) {
    if (isVisited) {
      noStroke();
      fill(c);
      rect(start.x, start.y, w, h);
    }
  }

  void drawLines() {
    //0 means don't draw and 1 means draw
    //this.l = l;
    //this.t = t;
    //this.r = r;
    //this.b = b;
    strokeWeight(2.5);
    strokeCap(SQUARE);
    //strokeJoin(ROUND);
    // color c = color(map(start.x, 0, width-spaceCol, 60, 255), map(sin(angle), -1, 1, 20, 200), map(start.y, 0, height-spaceCol, 0, 255));
    color c = color(200, 0, 255);
    if (l==1) {
      stroke(c);
      line(left.x, left.y, bottom.x, bottom.y);
    }
    if (t==1) {
      stroke(c);
      line(start.x, start.y, top.x, top.y);
    }
    if (r==1) {
      stroke(c);
      line(top.x, top.y, right.x, right.y);
    }
    if (b==1) {
      stroke(c);
      line(right.x, right.y, bottom.x, bottom.y);
    }
  }

  void setVisited() {
    isVisited = true;
  }

  boolean isVisited() {
    return isVisited;
  }
}