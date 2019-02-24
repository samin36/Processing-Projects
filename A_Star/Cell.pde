class Cell {
  PVector pos;
  int f, h, g;
  int type;
  final int DIAGCOST = 14, LINEARCOST = 10;
  //type:0 for cell and 1 for obstacle
  Cell parent;
  boolean inClosedSet;
  Cell(PVector pos_, int type_) {
    pos = pos_;
    type = type_;
    f = 0; 
    h = 0;
    g = 0;
    inClosedSet = false;
  }


  void setParent(Cell parent) {
    this.parent = parent;
  }

  Cell getCurrParent() {
    return parent;
  }


  void drawCells(color c) {
    fill(c);
    //stroke(0);
    noStroke();
    //strokeWeight(1.5);
    ellipseMode(CORNER);
    ellipse(pos.x, pos.y, spaceCol*.7, spaceRow*.7);
   // rect(pos.x, pos.y, spaceCol, spaceRow);
   // triangle(pos.x, pos.y, (spaceCol+2*pos.x)/2, pos.y+spaceRow, pos.x+spaceCol, pos.y);
  }

  void gCost() {
    if (parent!=null) {
      if (parent.pos.dist(pos)==diagDist) {
        g=parent.g + DIAGCOST;
      } else {
        g = parent.g + LINEARCOST;
      }
    }
  }

  int gCost(PVector pos) {
    if (pos.dist(this.pos)==diagDist) {
      return DIAGCOST;
    } else {
      return LINEARCOST;
    }
  }

  void hCost() {
    float dx = abs(endSq.pos.x - pos.x), dy = abs(endSq.pos.y - pos.y);
    if (allowDiagonals)
      h = floor(max(dx, dy));
    else
      h = floor(dx+dy);
    //println(h);
  }

  float max(float dx, float dy) {
    return (dx > dy) ? dx : dy;
  }

  void fCost() {
    f = h + g;
  }

  void totalCost() {
    gCost();
    hCost();
    fCost();
  }


  void setType(int type) {
    this.type = type;
  }
}