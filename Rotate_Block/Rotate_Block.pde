int cols, rows, size;
ArrayList<Block> blocks;
Block hinge;

void setup() {
  size(800, 800);
  cols = rows = 10;
  size = width / cols;
  blocks = new ArrayList<Block>();
}

void draw() {
  background(255);
  drawGrid();

  for (Block b : blocks) {
    b.show();
  }
  if (hinge!=null) {
    hinge.show();
  }
}

void keyPressed() {
  float[][] matrix = {{0, -1}, {1, 0}};
  rotateBlocks(matrix);
}

void mousePressed() {
  PVector mouseLoc = new PVector(floor(mouseX/size) * size + size/2, floor(mouseY/size) * size + size/2);

  deleteExistingBlock(mouseLoc);

  if (mouseButton == LEFT) {
    blocks.add(new Block(mouseLoc, false));
  } else if (mouseButton == RIGHT) {
    if (hinge!=null) {
      blocks.add(new Block(hinge.loc.copy(), false));
      hinge = null;
    }
    hinge = new Block(mouseLoc, true);
  }
}

void deleteExistingBlock(PVector loc) {
  for (Block b : blocks) {
    if (b.loc.equals(loc)) {
      blocks.remove(b);
      break;
    }
  }
}

void rotateBlocks(float[][] matrix) {
  if (hinge!=null) {
    for (Block b : blocks) {
      PVector prevLoc = b.loc.copy(); //<>//
      PVector newLoc = PVector.sub(prevLoc, hinge.loc);
      newLoc = new PVector(matrix[0][0]*newLoc.x + matrix[0][1]*newLoc.y, matrix[1][0]*newLoc.x + matrix[1][1]*newLoc.y);
      newLoc = PVector.add(hinge.loc, newLoc);
      b.setLoc(newLoc);
    }
  }
}



void drawGrid() {
  stroke(0);
  strokeWeight(2);
  for (int x = size; x < width; x+=size) {
    line(x, 0, x, height);
    for (int y = size; y < height; y+=size) {
      line(0, y, width, y);
    }
  }
}
