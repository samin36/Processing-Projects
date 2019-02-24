PVector[][] grid; //<>//
int numCols, numRows;
float spaceCols, spaceRows;
ArrayList<Disk> disks;
int whoseTurn;
PVector[] sides;
boolean winning;
float sC = 100, sR = 100;
void setup() {
  size(700, 700); 
  spaceCols = sC;
  spaceRows = sR;
  numCols = int((width/spaceCols));
  numRows = int((height/spaceRows)-1);
  grid = new PVector[numRows][numCols];
  preload();
  disks = new ArrayList<Disk>();
  disks.add(new Disk(int(random(-3, -1))));
  whoseTurn = disks.get(0).currentPlayer;
  sides = new PVector[2 * numCols + 2 * (numRows-2)];
  calcSides();
  winning = false;
}

void reset() {
  spaceCols = sC;
  spaceRows = sR;
  numCols = int((width/spaceCols));
  numRows = int((height/spaceRows)-1);
  grid = new PVector[numRows][numCols];
  preload();
  disks = new ArrayList<Disk>();
  disks.add(new Disk(int(random(-3, -1))));
  whoseTurn = disks.get(0).currentPlayer;
  sides = new PVector[2 * numCols + 2 * (numRows-2)];
  calcSides();
  winning = false;
}

void preload() {
  int index = 1;
  for (int r = 0; r < grid.length; r++) {
    for (int c = 0; c < grid[0].length; c++) {
      grid[r][c] = new PVector(spaceCols/2 + c * spaceCols, spaceRows/2 + ((r+1) * spaceRows), index);
      index++;
    }
  }
}

void draw() {
  background(0);
  if (disks.size()-1 == numRows * numCols) {
    println("Tie Game!");
    reset();
  }

  drawGrid();
  drawDisks();
}

void drawDisks() {
  for (Disk d : disks) {
    d.update();
    if (d.pos.y > spaceRows/2 && d.closeToStop())
      checkIfWinning(d);
    if (winning) {
      if (d.currentPlayer == -1)
        println("Yellow Wins!");
      else
        println("Red Wins!");
      reset();
    }
    // println(d.stopLoc.x, d.stopLoc.y);
    d.drawDisk();
  }
}

void drawGrid() {
  for (PVector[] posArray : grid) {
    for (PVector pos : posArray) {
      strokeWeight(4);
      stroke(0, 100, 255);
      //textSize(26);
      //fill(0, 255, 0);
      //textAlign(CENTER);
      //text(floor(pos.z), pos.x, pos.y+5);
      noFill();
      ellipse(pos.x, pos.y, spaceCols-20, spaceRows-20);
    }
  }
}

void keyPressed() {
  Disk curr = disks.get(disks.size()-1);
  if (keyCode == ' ') {
    whoseTurn = curr.currentPlayer;
    drop(curr);
  } else if (keyCode == LEFT) {
    curr.pos.x-=spaceCols;
  } else if (keyCode == RIGHT) {
    curr.pos.x+=spaceCols;
  }
  curr.pos.x = constrain(curr.pos.x, spaceCols/2, width-spaceCols/2);
}

void drop(Disk curr) {
  float slope = 1.0/(spaceCols), intercept = -1.0 * slope * spaceCols/2.0; 
  int colIndex = int((slope * curr.pos.x) + intercept);
  PVector loc = getCol(colIndex);
  if (loc != null) {
    curr.vel = new PVector(0, spaceCols/2);
    curr.stopLoc = new PVector(loc.x, loc.y);
    switchPlayer();
    disks.add(new Disk(whoseTurn));
    Disk newd = disks.get(disks.size()-1);
    newd.setPos(curr.pos.copy());
  }
}

PVector getCol(int colIndex) {
  //100 returned means the whole column is filled 
  //-1 or -2 means the slot is filled
  //method returns the index available in a column
  for (int r = grid.length-1; r >= 0; r--) {
    if (grid[r][colIndex].z != -1 && grid[r][colIndex].z != -2) {
      grid[r][colIndex].z = whoseTurn;
      return grid[r][colIndex];
    }
  }
  return null;
}

void switchPlayer() {
  whoseTurn = (whoseTurn == -1) ? -2 : -1;
}

void calcSides() {
  int index = 0;
  for (int r = 0; r < grid.length; r++) {
    for (int c = 0; c < grid[r].length; c++) {
      PVector curr = grid[r][c];
      if (r == 0 || r == grid.length-1)
        sides[index] = new PVector(curr.x, curr.y, curr.z);
      else {
        if (c == 0 || c == grid[r].length-1)
          sides[index] = new PVector(curr.x, curr.y, curr.z);
      }
    }
  }
}

void checkIfWinning(Disk curr) {
  winning = (calcDiag(curr, -1, -1) || calcDiag(curr, 1, -1) || calcDiag(curr, -1, 1) || calcDiag(curr, 1, 1));
  if (winning)
    curr.c=color(0, 255, 0, random(255));
}

boolean calcDiag(Disk c, int x, int y) {
  int player = c.currentPlayer;
  int i = 1;  
  while (i < 4) {
    PVector newLoc = new PVector(c.pos.x + x * i * spaceCols, c.pos.y + y * i * spaceRows);
    //println(x, y, i);
    //println(gridPlayer(newLoc));
    if (player != gridPlayer(newLoc))
      return false;
    else
      i++;
  }
  return true;
}

int gridPlayer(PVector p) {
  for (PVector[] g : grid)
    for (PVector a : g)
      if (dist(a.x, a.y, p.x, p.y) < 1)
        return int(a.z);
  return -3;
}

boolean checkIfSide(PVector l) {
  for (PVector p : sides)
    if (dist(p.x, p.y, l.x, l.y) < 1)
      return true;
  return false;
}