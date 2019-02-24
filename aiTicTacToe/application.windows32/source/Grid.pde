class Grid {
  float cols, rows, spaceCol, spaceRow;
  color c;
  Grid(float cols, float rows) {
    this.cols = cols;
    this.rows = rows;
    recalculate();
    c = color(255);
  }
  void recalculate() {
    spaceCol = width/cols;
    spaceRow = height/rows;
  }

  void drawGrid() {
    stroke(c);
    strokeWeight(5);
    recalculate();
    for (int i = 0; i < cols; i++) {
      line(i*spaceCol, 0, i*spaceCol, height);
    }
    for (int j = 0; j < rows; j++) {
      line(0, j*spaceRow, width, j*spaceRow);
    }
    line(width-2, 0, width-2, height);
  }
}