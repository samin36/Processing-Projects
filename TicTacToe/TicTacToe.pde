Grid gridOne;
int numRows = 100, numCols = 100;
String xo = "X";
//"X" = x and false = "O"
String[] xoSpaces;
PVector[] locs;
boolean play = true;
void setup() {
  size(900, 900);
  startOver();
}
void startOver() {
  gridOne = new Grid(numCols, numRows);
  locs = new PVector[numRows * numCols];
  calcLocs();
  xoSpaces = new String[numCols * numRows];
  for (int i = 0; i < xoSpaces.length; i++) {
    xoSpaces[i] = "N";
  }
}

void draw() {
  background(0);
  gridOne.drawGrid();
  play = checkIfWinning();
  checkIfTie();
  drawShape();
  println(checkIfSpecificWinning(xoSpaces, "X"));
  if (!play)
    startOver();
}

void drawShape() {
  float shrinkGrow = 1;
  for (int i = 0; i < xoSpaces.length; i++) {
    PVector curr = locs[i];
    if (xoSpaces[i] != null) {
      noFill();
      float strokeScale = 3*10;
      strokeWeight(strokeScale/numRows);
      float scale = (3*125*width) * shrinkGrow;
      if (xoSpaces[i].equals("X")) {
        stroke(0, 255, 0);
        ellipse(curr.x, curr.y, scale/(numRows*600), scale/(numCols*600));
      } else if (xoSpaces[i].equals("O")) {
        stroke(255, 0, 0);
        rectMode(CENTER);
        rect(curr.x, curr.y, scale/(numRows*600), scale/(numCols*600));
      }
    }
  }
}

void calcLocs() {
  PVector initial = new PVector(gridOne.spaceCol/2, gridOne.spaceRow/2), prev = new PVector(0, 0);
  locs[0] = initial;
  int count = 1;
  for (int i = 0; i < numRows; i++) {
    if (i > 0) {
      locs[count] = new PVector(gridOne.spaceCol/2, gridOne.spaceRow/2 + i * gridOne.spaceRow, count);
      count++;
    }
    for (int j = 1; j < numCols; j++) {
      prev = locs[count-1];
      locs[count]= new PVector(prev.x + gridOne.spaceCol, prev.y, count);
      count++;
    }
  }
}

int checkIfClicked() {
  int pos = 0;

  float minDist = 999999;
  for (PVector p : locs) {
    if (dist(p.x, p.y, mouseX, mouseY) < minDist) {
      minDist = dist(p.x, p.y, mouseX, mouseY);
      pos = int(p.z);
    }
  }
  if (xoSpaces[pos].equals("N")) {
    xoSpaces[pos] = xo;
    if (xo.equals("X")) {
      xo = "O";
    } else {
      xo = "X";
    }
  }
  return pos;
}

void mousePressed() {
  if (play)
    checkIfClicked();
}

void checkIfTie() {
  int Ncount = 0;
  for (String curr : xoSpaces) {
    if (curr.equals("N"))
      Ncount++;
  }
  if (Ncount==0)
    startOver();
}

boolean checkIfSpecificWinning(String[] board, String player) {
  if ((board[0]==player && board[1]==player && board[2]==player) ||
    (board[3]==player && board[4]==player && board[5]==player) ||
    (board[6]==player && board[7]==player && board[8]==player) ||
    (board[0]==player && board[3]==player && board[6]==player) ||
    (board[1]==player && board[4]==player && board[7]==player) ||
    (board[2]==player && board[5]==player && board[8]==player) ||
    (board[0]==player && board[4]==player && board[8]==player) ||
    (board[2]==player && board[4]==player && board[6]==player))
    return true;
  else
    return false;
}

boolean checkIfWinning() {
  //Horizontal check
  for (int i = 0; i < xoSpaces.length; i+=numCols) {
    int count = 0;
    for (int j = i; j < i + numCols; j++) {
      if (xoSpaces[i].equals(xoSpaces[j]) && xoSpaces[i] != "N")
        count++;
    }
    if (count==numCols)
      return false;
  }
  //Vertical check
  for (int i = 0; i < numCols; i+=1) {
    int count = 0;
    for (int j = i; j < xoSpaces.length; j+=numCols) {
      if (xoSpaces[i].equals(xoSpaces[j]) && xoSpaces[i] != "N")
        count++;
    }
    if (count==numCols)
      return false;
  }

  //Diagonal check
  int count1 = 0, count2 = 0;
  for (int k = 0, j = (numCols-1); k < xoSpaces.length && j < xoSpaces.length; k+=(numCols+1), j+=(numCols-1)) {
    if (xoSpaces[0].equals(xoSpaces[k]) && xoSpaces[0] != "N")
      count1++;
    if (xoSpaces[numCols-1].equals(xoSpaces[j]) && xoSpaces[numCols-1] != "N")
      count2++;
  }
  if (count1 == numCols || count2 == numCols)
    return false;

  return true;
}