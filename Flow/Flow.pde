int[][] board = { //<>// //<>//
  {0, 0, 0, 0, 0, 0}, 
  {0, 1, 0, 0, 1, 0}, 
  {0, 0, 2, 0, 3, 0}, 
  {4, 0, 3, 0, 0, 0}, 
  {5, 0, 0, 2, 0, 4}, 
  {0, 5, 0, 0, 0, 0}
};
float space;
color curr;
PVector startLoc, currLoc, prevLoc;
boolean start;
void setup() {
  size(600, 600);
  space = width/board.length;
}

void draw() {
  background(0);
  if (mousePressed && !start) {
    PVector loc = getLocation();
    int num = (loc!=null) ? board[int(loc.y)][int(loc.x)] : 0;
    if (num!=0 && num <= 5) {
      start = true;
      startLoc = loc.copy();
      currLoc = loc.copy();
    }
  } else if (mousePressed && start) {
    PVector loc = getLocation();      
    int startNum = board[int(startLoc.y)][int(startLoc.x)]*10;
    int num = (loc!=null) ? board[int(loc.y)][int(loc.x)] : 0;
    if (num==0) {
      board[int(loc.y)][int(loc.x)] = startNum;
      currLoc = loc.copy();
    } else if (num==startNum/10 && loc.dist(startLoc) > 1) {
      start = false;
    } else if (num==startNum && prevLoc!=null && !prevLoc.equals(loc)) {
      board[int(currLoc.y)][int(currLoc.x)] = 0;
      currLoc = loc.copy();
    }
    prevLoc = loc.copy();
  } else if (!mousePressed && start) {
    start = false;
  }
  drawBoard();
}

PVector getLocation() {
  int x = ceil(mouseX/space)-1, y = ceil(mouseY/space)-1;
  x = constrain(x, 0, 5);
  y = constrain(y, 0, 5);
  return new PVector (x, y);
}


void drawBoard() {
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[i].length; j++) {
      float x = (2*i*space+space)/2, y = (2*j*space+space)/2;
      int num = board[j][i];
      rectMode(CENTER);
      noFill();
      stroke(255);
      strokeWeight(3);
      rect(x, y, space, space);
      fill(getColor(num));
      noStroke();
      if (num!=0) {
        if (num <= 5)
          ellipse(x, y, space*.65, space*.65);
        else {
          fill(getColor(num/10));
          rect(x, y, space*.45, space*.45);
        }
      }
    }
  }
}

boolean nextTo(int num1, int num2) {
  return (num1*10==num2 || num2*10==num1 || num1==num2);
}

color getColor(int num) {
  switch(num) {
  case 1:
    return color(255, 255, 0);
  case 2:
    return color(0, 255, 0);
  case 3:
    return color(255, 165, 0);
  case 4:
    return color(0, 0, 255);
  case 5:
    return color(255, 0, 0);
  default:
    return color(0);
  }
}