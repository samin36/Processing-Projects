import processing.video.*; //<>//
Capture cam;
int rows, cols, space;
Block[][] blocks;
Block blank, curr;
boolean start;
void setup() {
  size(600, 600, P2D);
  rows = cols = 5;
  blocks = new Block[rows][cols];
  space = width/cols;
  //img.resize(width, height);
  camSetup();
}

void initialize() {
  int count = 1;
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      int x = c*space, y = r*space;
      PImage partImg = null;//cam.get(x, y, space, space);
      boolean show = (count==rows*cols) ? false : true;
      blocks[r][c] = new Block(new PVector(x, y), partImg, count, r, c, true);
      if (!show)
        blank = blocks[r][c];
      count++;
    }
  }
  start = false;
}

void setImage() {
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      Block current = blocks[r][c];
      cam.read();
      current.filler = cam.get(c*space, r*space, space, space);
    }
  }
}

void camSetup() {
  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[6]);
  cam.start();
}

void draw() {
  background(0);


  if (start) {
    setImage();
    for (Block[] block : blocks)
      for (Block b : block) {
        b.move();
        b.show();
      }
  }

  if (!start) {
    cam.read();
    image(cam, 0, 0, width, height);
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
    curr = getBlock(mouseX, mouseY);
    if (curr!=null && !curr.canMove) {
      // println(curr.loc.dist(blank.loc));
      if (abs(space-curr.loc.dist(blank.loc)) < .00001) {
        PVector temp = curr.loc.copy();
        curr.setMovement(blank.loc.copy());
        blank.setMovement(temp);
      }
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
    initialize();
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
