import java.util.*; //<>//
int row, col, rowSpace, colSpace;
Grid grid;
int[] xStep = {-1, -2, -2, -1, 1, 2, 2, 1};
int[] yStep = {-2, -1, 1, 2, 2, 1, -1, -2};
int count = 0;
void setup() {
  size(600, 600, P2D); 
  row = col = 4;
  rowSpace = height / row;
  colSpace = width / col;
  grid = new Grid();
  tour(colSpace/2, rowSpace/2, 1);
  // for (Grid.Block b : grid.soln)
  //  println(b.num);
  // println(count);
}

void draw() {
  background(255);
  grid.showGrid();
}

void tour(int x, int y, int pos) {
  grid.getBlock(x, y).setNum(pos);
  grid.getBlock(x, y).setVisitedTo(true);

  if (pos >= row*col) {
    //if (count < 305)
    //  grid.soln = (ArrayList<Grid.Block>) (grid.blocks.clone());
    //    if (grid.howManyVisited()==col*row)
    if (count==47) {
      grid.transferBlocks();
    } 
    println(count);

    grid.getBlock(x, y).setNum(0);
    grid.getBlock(x, y).setVisitedTo(false);
    count++;
    return;
  }

  for (int i = 0; i < 8; i++) {
    int newX = x + xStep[i]*colSpace;
    int newY = y + yStep[i]*rowSpace;
    if (isValid(newX, newY) && !grid.getBlock(newX, newY).visited) {
      tour(newX, newY, pos+1);
    }
  }
  grid.getBlock(x, y).setNum(0);
  grid.getBlock(x, y).setVisitedTo(false);
}


boolean isValid(int x, int y) {
  return (x > 0 && x < width && y > 0 && y < height);
}
