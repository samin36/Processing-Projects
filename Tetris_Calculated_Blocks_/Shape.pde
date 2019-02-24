class Shape { //<>//
  Block[] blocks;
  Block pivot;
  PVector pivLoc;
  int type;
  int otion;
  int millis;
  color c;
  boolean done;
  float theta;

  Shape(PVector pivLoc_, int type_, int orientation_) {
    type = type_;
    otion = orientation_;
    blocks = new Block[4];
    c = getColor();
    pivLoc = pivLoc_;
    theta = PI/2;
    pivot = new Block(pivLoc, c, 1);
    blocks[1] = pivot;
    makeShape();
  }

  void show() {
    for (Block b : blocks) {
      color str = (done) ? color(0) : color(255);
      b.show(str);
    }
  }

  void move() {
    switch (keyCode) {
    case DOWN:
      moveDown(-1);
      hasLanded();
      break;
    case LEFT:
      moveLeftRight(-1);
      if (outOfBounds()) moveLeftRight(1);
      break;
    case RIGHT:
      moveLeftRight(1);
      if (outOfBounds()) moveLeftRight(-1);
      break;
    case SHIFT:
      while (!done) {
        moveDown(-1);
        hasLanded();
      }
    }
  }

  void moveLeftRight(int dir) {
    for (Block b : blocks) {
      if (dir<0)
        b.moveLeft();
      else
        b.moveRight();
    }
  }

  void moveDown(int time) {
    if ((millis() - millis)>=time) {
      millis = millis();
      for (Block b : blocks)
        b.moveDown();
    }
    hasLanded();
  }

  void moveUp() {
    for (Block b : blocks)
      b.moveUp();
  }

  boolean outOfBounds() {
    //if (orientation!=otion) {
    //  otion = orientation;
    //  makeShape();
    //}
    for (Block b : blocks) {
      if (thereIsABlockNextTo(b) || b.loc.x < boundLeft || b.loc.x > boundRight-space)
        return true;
    }
    return false;
  }

  boolean thereIsABlockNextTo(Block b) {
    for (Shape curr : doneShapes) {
      for (Block pastBlocks : curr.blocks)
        if (pastBlocks.loc.equals(b.loc))
          return true;
    }
    return false;
  }

  void hasLanded() {
    for (Block b : blocks) {
      if (thereIsABlockBelow(b) || b.loc.y >= height-space) {
        done = true;
      }
    }
  }

  boolean thereIsABlockBelow(Block b) {
    PVector toCheck = new PVector(b.loc.x, b.loc.y+space);
    for (Shape curr : doneShapes) {
      for (Block pastBlocks : curr.blocks)
        if (pastBlocks.loc.equals(toCheck))
          return true;
    }
    return false;
  }

  color getColor() {
    color toReturn;
    switch(type) {
    case 0 : 
      toReturn = color(9, 239, 230); 
      break;
    case 1 : 
      toReturn = color(12, 12, 230); 
      break;
    case 2 : 
      toReturn = color(230, 128, 9); 
      break;
    case 3 : 
      toReturn = color(230, 230, 9); 
      break;
    case 4 : 
      toReturn = color(12, 230, 12); 
      break;
    case 5 : 
      toReturn = color(128, 12, 128); 
      break;
    case 6 : 
      toReturn = color(230, 12, 12); 
      break;
    default : 
      toReturn = 0; 
      break;
    }
    return toReturn;
  }

  void decrOtion() {
    otion--;
    makeShape();
  }

  void incrOtion() {
    switch(type) {
    case 0 : 
      if (otion==2)
        otion = 0;
      break;
    case 1 : 
      if (otion==4)
        otion = 0;
      break;
    case 2 : 
      if (otion==4)
        otion = 0;
      break;
    case 3 : 
      otion=0;
      break;
    case 4 : 
      if (otion==2)
        otion=0;
      break;
    case 5 : 
      if (otion==4)
        otion=0;
      break;
    case 6 : 
      if (otion==2)
        otion=0;
      break;
    default : 

      break;
    }
    otion++;
    makeShape();
  }

  void makeShape() {
    if (type==1) {
      if (otion==1) {
        blocks[0] = new Block(new PVector(pivLoc.x-space, pivLoc.y), c, 0);
        blocks[2] = new Block(new PVector(pivLoc.x+space, pivLoc.y), c, 2);
        blocks[3] = new Block(new PVector(pivLoc.x+space, pivLoc.y+space), c, 3);
      } else {
        rotateByTheta();
      }
    } else if (type==0) {
      if (otion==1) {
        blocks[0] = new Block(new PVector(pivLoc.x-space, pivLoc.y), c, 0);
        blocks[2] = new Block(new PVector(pivLoc.x+space, pivLoc.y), c, 2);
        blocks[3] = new Block(new PVector(pivLoc.x+2*space, pivLoc.y), c, 3);
      } else {
        rotateByTheta();
      }
    } else if (type==2) {
      if (otion==1) {
        blocks[0] = new Block(new PVector(pivLoc.x+space, pivLoc.y), c, 0);
        blocks[2] = new Block(new PVector(pivLoc.x-space, pivLoc.y), c, 2);
        blocks[3] = new Block(new PVector(pivLoc.x-space, pivLoc.y+space), c, 3);
      } else {
        rotateByTheta();
      }
    } else if (type==3) {
      if (otion==1) {
        blocks[0] = new Block(new PVector(pivLoc.x-space, pivLoc.y), c, 0);
        blocks[2] = new Block(new PVector(pivLoc.x, pivLoc.y+space), c, 2);
        blocks[3] = new Block(new PVector(pivLoc.x-space, pivLoc.y+space), c, 3);
      }
    } else if (type==4) {
      if (otion==1) {
        blocks[0] = new Block(new PVector(pivLoc.x+space, pivLoc.y), c, 0);
        blocks[2] = new Block(new PVector(pivLoc.x, pivLoc.y+space), c, 2);
        blocks[3] = new Block(new PVector(pivLoc.x-space, pivLoc.y+space), c, 3);
      } else {
        rotateByTheta();
      }
    } else if (type==5) {
      if (otion==1) {
        blocks[0] = new Block(new PVector(pivLoc.x-space, pivLoc.y), c, 0);
        blocks[2] = new Block(new PVector(pivLoc.x+space, pivLoc.y), c, 2);
        blocks[3] = new Block(new PVector(pivLoc.x, pivLoc.y+space), c, 3);
      } else {
        rotateByTheta();
      }
    } else if (type==6) {
      if (otion==1) {
        blocks[0] = new Block(new PVector(pivLoc.x-space, pivLoc.y), c, 0);
        blocks[2] = new Block(new PVector(pivLoc.x, pivLoc.y+space), c, 2);
        blocks[3] = new Block(new PVector(pivLoc.x+space, pivLoc.y+space), c, 3);
      } else {
        rotateByTheta();
      }
    }
  }

  void rotateByTheta() {
    for (int i = 0; i < blocks.length; i++) {
      if (i!=1) {
        Block curr = blocks[i];
        PVector cL = curr.loc.copy();
        PVector newLoc = PVector.sub(cL, pivLoc);
        newLoc = multiplyMatrix(newLoc);
        newLoc = PVector.add(pivLoc, newLoc);
        curr.setLoc(newLoc);
      }
    }
  }

  PVector multiplyMatrix(PVector nL) {
    float x = (cos(theta)*nL.x + -sin(theta) * nL.y); 
    float y = (sin(theta)*nL.x + cos(theta) * nL.y);
    return new PVector(x, y);
  }
}
