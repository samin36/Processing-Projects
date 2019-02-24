Maze m;
int cols, rows, spaceCol, spaceRow;
void setup() {
  size(800, 800);
  cols = 50;
  rows = (cols * height/width);
  spaceCol = width/cols;
  spaceRow = height/rows;
  m = new Maze(cols, rows, spaceCol, spaceRow);
}

void draw() {
  background(0);
  m.drawMaze();
}
