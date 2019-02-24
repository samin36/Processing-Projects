class Cell {
  PVector left, top, right, bottom, start;
  boolean isVisited;
  int w, h, l, t, r, b;
  Cell(PVector start) {
    this.start = start;
    w = spaceCol;
    h = spaceRow;
    l=1;
    t=1;
    r=1;
    b=1;
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
   fill(255, 255, 0);
   rect(start.x, start.y, w, h);
  }

  void drawIfVisited() {
    if (isVisited) {
      noStroke();
      fill(0);
      rect(start.x, start.y, w, h);
    }
  }

  void drawLines() {
    //0 means don't draw and 1 means draw
    //this.l = l;
    //this.t = t;
    //this.r = r;
    //this.b = b;
    stroke(0, 255, 0);
    strokeWeight(2);
    if (l==1)
      line(left.x, left.y, bottom.x, bottom.y);
    if (t==1)
      line(start.x, start.y, top.x, top.y);
    if (r==1)
      line(top.x, top.y, right.x, right.y);
    if (b==1)
      line(right.x, right.y, bottom.x, bottom.y);
  }

  void setVisited() {
    isVisited = true;
  }

  boolean isVisited() {
    return isVisited;
  }
}