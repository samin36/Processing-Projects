class Maze {
  int cols, rows, spaceCol, spaceRow, visitCount;
  int millisToCreate, numOfSteps, millisToSolve;
  PrintWriter output;
  ArrayList<Cell> cells, stack, triedStack;
  Cell curr, finder;
  boolean moved;
  PVector end;
  Maze(int cols_, int rows_, int spaceRow_, int spaceCol_) {
    cols = cols_; 
    rows = rows_;
    spaceCol = spaceCol_;
    spaceRow = spaceRow_;
    cells = new ArrayList<Cell>();
    stack = new ArrayList<Cell>();
    triedStack = new ArrayList<Cell>();
    numOfSteps = 0;
    for (int x = 0; x < width; x+=spaceCol) {
      for (int y = 0; y < height; y+=spaceRow) {
        cells.add(new Cell(new PVector(x, y)));
      }
    }
    visitCount = 0;
    // curr = cells.get(int(random(cells.size())));
    curr = cells.get(0);
    curr.setVisited();
    finder = new Cell(new PVector(0, 0));
    output = createWriter("steps.txt");
    end = new PVector(width-spaceCol, height-spaceCol);
    //curr.drawCurr();
  }

  void getVisitCount() {
    int count = 0;
    for (Cell c : cells)
      if (c.isVisited())
        count++;
    visitCount = count;
  }

  void drawMaze() {
    for (Cell c : cells) {
      float red = map(finder.start.dist(end), 0, end.dist(new PVector(0, 0)), 255, 0);    
      float green = map(finder.start.dist(end), 0, end.dist(new PVector(0, 0)), 0, 255);
      c.drawIfVisited(color(127, 0, 140), c.weight);
      c.drawIfTried(color(red, green, 0), c.weight);
      c.drawLines();
    }
    if (visitCount < cells.size()) {
      millisToCreate = millis();
      if (hasNeighbors(curr)) {
        curr.drawCurr();
        Cell neighbor = getRandNeigh(curr);
        stack.add(curr);
        removeWall(curr, neighbor);
        curr = neighbor;
        curr.setVisited();
      } else if (stack.size()!=0) {
        curr = stack.get(stack.size()-1);
        stack.remove(stack.size()-1);
      }
      getVisitCount();
    } else if (finder.start.dist(end) > 1) {
      //end = stack.get(stack.size()-1).start.copy();
      millisToSolve = millis();
      finder.drawCurr();
      moved = canmove(0, 1);
      if (!moved)
        moved = canmove(1, 0);
      if (!moved)
        moved = canmove(0, -1);
      if (!moved)
        moved = canmove(-1, 0);
      if (!moved && triedStack.size()!=0) {
        finder.setTried();
        finder.backtrack=false;
        finder = triedStack.get(triedStack.size()-1);
        triedStack.remove(triedStack.size()-1);
      }
    } else if (finder.start.equals(end)) {
      finder.drawCurr();
      output.println("Time to create maze: " + ((millisToCreate/(1000*3600) % 24)) + " hours " + ((millisToCreate/(1000*60)) % 60) + " minutes " + ((millisToCreate/1000) % 60) + " seconds\n");
      output.println("Time to solve maze: " + abs(((millisToCreate-millisToSolve)/(1000*3600) % 24)) + " hours " + abs(((millisToCreate-millisToSolve)/(1000*60) % 60)) + " minutes " + abs((((millisToCreate-millisToSolve)/1000) % 60)) + " seconds\n");
      output.println("Number of steps to solve: " + numOfSteps);
      output.flush();
      output.close();
      save("last_instance.png");
      exit();
    }
  }

  boolean canmove(int x, int y) {
    if (x==0&&y==1) {
      Cell curr = getNeighbor(finder.start.copy());
      Cell below = (getNeighbor(new PVector(finder.start.x, finder.start.y+spaceRow)));
      if (curr!=null && curr.b==0 && !below.tried()) {
        curr.setTried();
        curr.backtrack=true;
        triedStack.add(curr);
        finder = below;
        //println("down");
        numOfSteps++;
        // output.println("down" + "\n");
        return true;
      }
    } else if (x==0&&y==-1) {
      Cell up = getNeighbor(new PVector(finder.start.x, finder.start.y-spaceRow)); 
      if (up!=null && up.b==0 && !up.tried()) {
        Cell curr = getNeighbor(finder.start.copy());
        curr.setTried();
        curr.backtrack=true;
        triedStack.add(curr);
        finder = up;
        // println("up");
        numOfSteps++;
        // output.println("up" + "\n");
        return true;
      }
    } else if (x==1&&y==0) {
      Cell curr = getNeighbor(finder.start.copy());
      Cell right = getNeighbor(new PVector(finder.start.x+spaceCol, finder.start.y));
      if (curr!=null && curr.r==0 && !right.tried()) {
        curr.setTried();
        curr.backtrack=true;
        triedStack.add(curr);
        finder = right;
        //  println("right");
        numOfSteps++;
        // output.println("right" + "\n");
        return true;
      }
    } else if (x==-1&&y==0) {
      Cell left = getNeighbor(new PVector(finder.start.x-spaceCol, finder.start.y));
      if (left!=null && left.r==0 && !left.tried()) {
        Cell curr = getNeighbor(finder.start.copy());
        curr.setTried();
        curr.backtrack=true;
        triedStack.add(curr);
        finder = left;
        //  println("left");
        numOfSteps++;
        //  output.println("left" + "\n");
        return true;
      }
    }
    return false;
  }

  void removeWall(Cell c, Cell n) {
    if (c.start.x==n.start.x && c.start.y==n.start.y+spaceRow) {
      n.b=0;
    } else if (c.start.x==n.start.x+spaceCol && c.start.y==n.start.y) {
      n.r=0;
    } else if (c.start.x==n.start.x-spaceCol && c.start.y==n.start.y) {
      c.r=0;
    } else if (c.start.x==n.start.x && c.start.y==n.start.y-spaceRow) {
      c.b=0;
    }
  }

  Cell getRandNeigh(Cell c) {
    PVector[] neigh = new PVector[4];
    //0=above, 1=left, 2=right, 3=below
    neigh[0] = new PVector(c.start.x, c.start.y-spaceRow);
    neigh[1] = new PVector(c.start.x-spaceCol, c.start.y);
    neigh[2] = new PVector(c.start.x+spaceCol, c.start.y);
    neigh[3] = new PVector(c.start.x, c.start.y+spaceRow);

    int rand = int(random(neigh.length));
    while ((getNeighbor(neigh[rand])==null || (getNeighbor(neigh[rand]).isVisited()))) {
      rand = int(random(neigh.length));
    }
    return getNeighbor(neigh[rand]);
  }

  boolean hasNeighbors(Cell c) {
    //checks if unvisited neighbors
    PVector above, left, right, below;
    above = new PVector(c.start.x, c.start.y-spaceRow);
    left = new PVector(c.start.x-spaceCol, c.start.y);
    right = new PVector(c.start.x+spaceCol, c.start.y);
    below = new PVector(c.start.x, c.start.y+spaceRow);
    if (getNeighbor(below) != null && !getNeighbor(below).isVisited())
      return true;
    else if (getNeighbor(above) != null && !getNeighbor(above).isVisited())
      return true;
    else if (getNeighbor(left) != null && !getNeighbor(left).isVisited())
      return true;
    else if (getNeighbor(right) != null && !getNeighbor(right).isVisited())
      return true;
    else
      return false;
  }

  Cell getNeighbor(PVector loc) {
    for (Cell c : cells)
      if (dist(loc.x, loc.y, c.start.x, c.start.y) < 1)
        return c;
    return null;
  }
}