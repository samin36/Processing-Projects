class Grid {
  ArrayList<Block> blocks, soln;
  Grid() {
    blocks = new ArrayList<Block>();
    soln = new ArrayList<Block>();
    instantiateGrid();
  }

  void transferBlocks() {
    for (Block b : blocks) {
      Block toAdd = new Block(b.loc.copy());
      toAdd.setNum(b.num);
      toAdd.setVisitedTo(b.visited);
      soln.add(toAdd);
    }
    sortBlocks();
  }

  void sortBlocks() {
    Collections.sort(soln);
  }

  void instantiateGrid() {
    for (int y = rowSpace / 2; y < height; y+=rowSpace) {
      for (int x = colSpace / 2; x < width; x+=colSpace) {
        blocks.add(new Block(new PVector(x, y)));
      }
    }
  }

  Block getBlock(int x, int y) {
    for (Block b : blocks)
      if (b.loc.equals(new PVector(x, y)))
        return b;
    return null;
  }

  int howManyVisited() {
    int count = 0;
    for (Block b : blocks)
      if (b.visited)
        count++;
    return count;
  }


  void showGrid() {
    for (int i = 0; i < soln.size() - 1; i++) {
      Block b = soln.get(i), bN = soln.get(i+1);
      b.showBlock();
      if (i==soln.size()-2) bN.showBlock();
      stroke(0);
      strokeWeight(1.5);
      line(b.loc.x, b.loc.y, bN.loc.x, bN.loc.y);
    }
  }

  class Block implements Comparable<Block> {
    PVector loc;
    boolean visited;
    int num;

    Block(PVector loc_) {
      loc = loc_;
      visited = false;
    }

    int compareTo(Block comparingTo) {
      if (num < comparingTo.num)
        return -1;
      else if (num > comparingTo.num)
        return 1;
      else
        return 0;
    }

    void setVisitedTo(boolean visited) {
      this.visited = visited;
    }

    void setNum(int num) {
      this.num = num;
    }

    void showBlock() {
      stroke(0);
      strokeWeight(2);
      noFill();
      rectMode(CENTER);
      rect(loc.x, loc.y, colSpace*.9, rowSpace*.9);
      //textAlign(CENTER, CENTER);
      //textSize(18);
      //fill(0);
     // text(num, loc.x, loc.y);
    }
  }
}
