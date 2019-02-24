Cell[][] grid, updatedGrid;
float dA = 1, dB = .5, feedRate = .03, killRate = .04;
void setup() {
  size(800, 800);
  grid = new Cell[width][height];
  updatedGrid = new Cell[width][height];

  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid.length; j++) {
      float a = 1;
      float b = 0;
      grid[i][j] = new Cell(a, b);
      updatedGrid[i][j] = new Cell(a, b);
    }
  }
  //for (int i = width/2-50; i < width/2+50; i++) {
  //  for (int j = height/2-50; j < height/2+50; j++) {
  //    grid[i][j].b=1;
  //  }
  //}
   createChemicals(width/2, height/2);
  background(255);
  //colorMode(HSB);
}

void createChemicals(float locX, float locY) {
  for (int i = 0; i < 100; i++) {
    int x = int(random(locX-100, locX+100));
    x = constrain(x, 1, width-1);
    int y = int(random(locY-100, locY+100));
    y = constrain(y, 1, height-1);
    grid[x][y] = new Cell(1, 1);
    updatedGrid[x][y] = new Cell(1, 1);
  }
}

void draw() {
  //  background(255);
  if (mousePressed)
  createChemicals(mouseX, mouseY);
  calculateNewValues();
  swap();

  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int loc = x + y * width;    
      pixels[loc] = color((grid[x][y].a-grid[x][y].b)*255);
    }
  }
  updatePixels();
}

void calculateNewValues() {
  for (int i = 1; i < grid.length-1; i++) {
    for (int j = 1; j < grid[i].length-1; j++) {
      float a = grid[i][j].a, b = grid[i][j].b;
      updatedGrid[i][j].a = a + (dA * laplace(grid, i, j, true) - a*b*b + feedRate*(1-a));
      updatedGrid[i][j].b = b + (dB * laplace(grid, i, j, false) + a*b*b - (killRate+feedRate)*b);
      updatedGrid[i][j].a = constrain(updatedGrid[i][j].a, 0, 1);
      updatedGrid[i][j].b = constrain(updatedGrid[i][j].b, 0, 1);
    }
  }
}

float laplace(Cell[][] temp, int locX, int locY, boolean a) {
  /*
 ->assigns weight to different positions
   ->the middle or cell at x,y has weight of -1
   ->sides have weight of .2
   ->diagonals have weight of .05
   */
  float sum = 0;
  if (a) {
    sum+=temp[locX][locY].a*-1;
    sum+=temp[locX-1][locY].a*.2;
    sum+=temp[locX+1][locY].a*.2;
    sum+=temp[locX][locY-1].a*.2;
    sum+=temp[locX][locY+1].a*.2;
    sum+=temp[locX-1][locY-1].a*.05;
    sum+=temp[locX+1][locY-1].a*.05;
    sum+=temp[locX-1][locY+1].a*.05;
    sum+=temp[locX+1][locY+1].a*.05;
  } else {
    sum+=temp[locX][locY].b*-1;
    sum+=temp[locX-1][locY].b*.2;
    sum+=temp[locX+1][locY].b*.2;
    sum+=temp[locX][locY-1].b*.2;
    sum+=temp[locX][locY+1].b*.2;
    sum+=temp[locX-1][locY-1].b*.05;
    sum+=temp[locX+1][locY-1].b*.05;
    sum+=temp[locX-1][locY+1].b*.05;
    sum+=temp[locX+1][locY+1].b*.05;
  }
  return sum;
}

void swap() {
  /*
 First, new values are calculated in updatedGrid from Grid
   Then, they are drawn to the screen
   Next frame, transfer the data from updatedGrid to the old Grid
   and set the updatedGrid to the old Grid although it is not neccessary since
   it will get overwritten
   */
  arrayCopy(updatedGrid, grid);
}

class Cell {
  float a, b;
  Cell(float a, float b) {
    this.a = a;
    this.b = b;
  }
}