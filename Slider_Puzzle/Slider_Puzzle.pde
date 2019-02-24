PImage img; //<>// //<>//
int rows, cols, space, moves;
Block[][] blocks;
Block blank, curr;
boolean start;
void setup() {
  size(600, 600);
  rows = cols = 3;
  blocks = new Block[rows][cols];
  space = width/cols;
  img = loadImage("jetha.jpg");
  img.resize(width, height);
  initialize();
}

void initialize() {
  int count = 1;
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      int x = c*space, y = r*space;
      PImage partImg = img.get(x, y, space, space);
      boolean show = (count==rows*cols) ? false : true;
      blocks[r][c] = new Block(new PVector(x, y), partImg, count, r, c, true);
      if (!show)
        blank = blocks[r][c];
      count++;
    }
  }
  start = false;
  moves=0;
}

void draw() {
  background(0);
  for (Block[] block : blocks)
    for (Block b : block) {
      b.move();
      b.show();
    }

  if (!start) {
    textSize(56);
    textAlign(CENTER, CENTER);
    fill(255, 0, 0);
    text("Press space to play", width/2, height/2);
  } else {
    if (hasWon()) {
      startOver();
    }
  }
}

void mousePressed() {
  if (start) {
    makeMove(mouseX, mouseY);
  }
}

void makeMove(float x, float y) {
  curr = getBlock(x, y);
  if (curr!=null && curr!=blank && !curr.canMove && !blank.canMove) {
    // println(curr.loc.dist(blank.loc));
    if (abs(space-curr.loc.dist(blank.loc)) < .00001) {
      PVector temp = curr.loc.copy();
      curr.setMovement(blank.loc.copy());
      blank.setMovement(temp);
      moves++;
    }
  }
}

Block getBlock(float x, float y) {
  for (Block[] block : blocks) {
    for (Block b : block) {
      if (x >= b.loc.x && x <= b.loc.x+space && y >= b.loc.y && y <= b.loc.y+space)
        return b;
    }
  }
  return null;
}

void keyPressed() {
  if (keyCode == ' ' && !start) {
    scramble();
    start = true;
    blank.showBlock = false;
  }
}

void scramble() {
  formPairs();
}

boolean hasWon() {
  int count = 1;
  for (int y = space/2; y < height; y+=space) {
    for (int x = space/2; x < width; x+=space) {
      Block toEval = getBlock(x, y);
      if (toEval!=null && (toEval.number!=count || toEval.hasPair))
        return false;
      count++;
    }
  }
  return true;
}

void startOver() {
  initialize();
}

void formPairs() {
  for (Block[] block : blocks) {
    for (Block b : block) {
      if (!b.hasPair) {
        Block random = blocks[int(random(rows))][int(random(cols))];
        while (random.hasPair) {
          random = blocks[int(random(rows))][int(random(cols))];
        }
        b.setPair(random);
        random.setPair(b);
        b.setMovement(random.loc.copy());
        random.setMovement(b.loc.copy());
      }
    }
  }
}
