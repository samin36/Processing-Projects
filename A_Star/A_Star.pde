int cols, rows;  //<>//
float spaceCol, spaceRow;
ArrayList<Cell> squares, openSet, closedSet, neighbors, optiPath;
boolean startSearch, pathFound, allowDiagonals;
float diagDist;
Cell currSq, endSq;
void setup() {
  size(800, 800);
  cols = 30;
  rows = cols / (width/height);
  spaceCol = width/cols;
  spaceRow = height/rows;
  diagDist = sqrt(pow(spaceCol, 2) + pow(spaceRow, 2));
  startSearch = false;
  pathFound = false;
  allowDiagonals = true;
  squares = new ArrayList<Cell>();
  openSet = new ArrayList<Cell>();
  closedSet = new ArrayList<Cell>();
  neighbors = new ArrayList<Cell>();
  optiPath = new ArrayList<Cell>();
  endSq = new Cell(new PVector(width-spaceCol, height-spaceRow), 0);
  for (int y = 0; y < height; y+=spaceRow) {
    for (int x = 0; x < width; x+=spaceCol) {
      int type = (random(1)<.5) ? 1 : 0;
      //int type = int(map(sin(angle), -1, 1, 0, 2));
      if (x==endSq.pos.x && y==endSq.pos.y || x==0 && y==0)
        type = 0;
      squares.add(new Cell(new PVector(x, y), type));
    }
  }
  endSq.setParent(null);
  currSq = squares.get(0);//new Cell(new PVector(0, 0), 0);
  currSq.type=0;
  currSq.setParent(null);
  openSet.add(currSq);
}

void draw() {
  background(255);
  for (Cell curr : squares) {
    if (curr.type==0)
      curr.drawCells(color(255));
    else 
    curr.drawCells(color(0));
  }
  if (!pathFound)
    mouseLocs();
  endSq.drawCells(color(255, 0, 150));
  if (startSearch) {
    if (openSet.size()==0) {
      println("No soln!");
      startSearch=false;
      return;
    }

    currSq = lowestFCost();
    closedSet.add(currSq);
    currSq.inClosedSet = true;
    openSet.remove(currSq);    

    if (closedSet.indexOf(getCell(endSq.pos, 1))!=-1) {
      //exit();
      endSq.setParent(currSq);
      startSearch = false;
      pathFound = true;
    }

    calcNeighbors(currSq);
    for (Cell neigh : neighbors) {
      if (neigh.inClosedSet) {
        continue;
      }       
      if (openSet.indexOf(neigh)==-1) {
        openSet.add(neigh);
        neigh.setParent(currSq);
        neigh.totalCost();
      } else {
        int tempG = neigh.g;
        int newG = neigh.gCost(currSq.pos.copy()) + currSq.g;
        if (newG < tempG) {
          neigh.setParent(currSq);
          neigh.g = newG;
          neigh.fCost();
        }
      }
    }
  }
  optiPath();
}

void optiPath() {
  optiPath.clear();
  //currSq.drawCells(color(180, 0, 210));
  if (closedSet.size()>0) {
    Cell temp = currSq;
    optiPath.add(temp);
    while (temp.parent!=null) {
      temp = temp.parent;
      optiPath.add(temp);
    }
  }
  drawPath(optiPath, color(180, 0, 255));
}

Cell lowestFCost() {
  Cell min = openSet.get(0);
  for (Cell c : openSet)
    if (c.f < min.f)
      min = c;
  return min;
}

void calcNeighbors(Cell curr) {
  neighbors.clear();
  Cell toAdd = null;
  for (int i = 1; i <= 8; i++) {
    switch(i) {
    case 1: 
      if (allowDiagonals)
        toAdd = getCell(new PVector(curr.pos.x-spaceCol, curr.pos.y-spaceRow), 1);
      break;
    case 2:
      toAdd = getCell(new PVector(curr.pos.x, curr.pos.y-spaceRow), 1);
      break;
    case 3:
      if (allowDiagonals)
        toAdd = getCell(new PVector(curr.pos.x+spaceCol, curr.pos.y-spaceRow), 1);
      break;
    case 4:
      toAdd = getCell(new PVector(curr.pos.x+spaceCol, curr.pos.y), 1);
      break;
    case 5:
      if (allowDiagonals)
        toAdd = getCell(new PVector(curr.pos.x+spaceCol, curr.pos.y+spaceRow), 1);
      break;
    case 6:
      toAdd = getCell(new PVector(curr.pos.x, curr.pos.y+spaceRow), 1);
      break;
    case 7:
      if (allowDiagonals)
        toAdd = getCell(new PVector(curr.pos.x-spaceCol, curr.pos.y+spaceRow), 1);
      break;
    case 8:
      toAdd = getCell(new PVector(curr.pos.x-spaceCol, curr.pos.y), 1);
      break;
    }
    if (toAdd!=null && !toAdd.inClosedSet)
      neighbors.add(toAdd);
  }
}

void drawPath(ArrayList<Cell> cell, color c) {
  stroke(c);
  //fill(c);
  noFill();
  strokeWeight(spaceCol*.2);
  beginShape(); 
  for (Cell curr : cell) {
    vertex(curr.pos.x + spaceCol/2, curr.pos.y + spaceRow/2);
    //rect(curr.pos.x, curr.pos.y, spaceCol, spaceRow);
    //PVector pos = curr.pos;
    //triangle(pos.x, pos.y, (spaceCol+2*pos.x)/2, pos.y+spaceRow, pos.x+spaceCol, pos.y);
  }
  endShape();
}



Cell getCell(PVector loc, float limit) {
  //returns the cell which is closest to the parameter loc
  //it is intended to return the cell which has the same values as loc
  //limit is the constraint
  for (Cell c : squares) {
    if (c.pos.dist(loc) < limit && c.type==0) {
      return c;
    }
  }
  return null;
}

void mouseLocs() {
  float xLoc = (int((mouseX/spaceCol))) *spaceCol;
  float yLoc = (int((mouseY/spaceRow))) *spaceRow;
  endSq.pos = new PVector(xLoc, yLoc);
}


void keyPressed() {
  if (keyCode=='D') {
    startSearch=true;
  }
}