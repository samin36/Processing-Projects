int cols, rows, spaceCol, spaceRow, visitCount;
ArrayList<Cell> cells, stack;
Cell curr;
Player player, end;
boolean showandmovePlayer, add;
PVector[] trail;
void setup() {
  size(1000, 1000);
  cols = 10;
  rows = 10;
  visitCount = 0;
  spaceCol = width/cols;
  spaceRow = height/rows;
  cells = new ArrayList<Cell>();
  stack = new ArrayList<Cell>();
  for (int x = 0; x < width; x+=spaceCol) {
    for (int y = 0; y < height; y+=spaceRow) {
      cells.add(new Cell(new PVector(x, y)));
    }
  }
  curr = cells.get(int(random(cells.size())));
  //curr = cells.get(0);
  curr.setVisited();
  player = new Player(curr.start.copy());
  end = null;
  showandmovePlayer = false;
  trail = new PVector[0];
  //println(curr.start.x, curr.start.y);
  //curr.drawCurr();
  add = false;
}

void getVisitCount() {
  int count = 0;
  for (Cell c : cells)
    if (c.isVisited())
      count++;
  visitCount = count;
}

void draw() {
  background(map(curr.start.x, 0, width, 0, 255), 50, map(curr.start.y, 0, height, 0, 255));
  for (Cell c : cells) {
    c.drawIfVisited();
    c.drawLines();
  }

  if (showandmovePlayer) {
    player.drawPlayer();
    end.endPlayer();
    for (PVector p : trail) {
      fill(255, 0, 0, 120);
      noStroke();
      if (p!=null)
        rect(p.x+player.factor, p.y+player.factor, spaceCol-2*player.factor, spaceRow-2*player.factor);
      else
        println("null");
    }
  }


  if (visitCount < cells.size()) {
    if (hasNeighbors(curr)) {
      curr.drawCurr();
      Cell neighbor = getRandNeigh(curr);
      stack.add(curr);
      removeWall(curr, neighbor);
      curr = neighbor;
      curr.setVisited();
    } else if (stack.size()!=0) {
      curr = stack.get(int(random(stack.size())));
    }
    getVisitCount();
  } else {
    showandmovePlayer = true;
    end = new Player(curr.start.copy());
  }
}

void removeWall(Cell c, Cell n) {
  if (c.start.x==n.start.x && c.start.y==n.start.y+spaceRow) {
    c.t=0;
    n.b=0;
  } else if (c.start.x==n.start.x+spaceCol && c.start.y==n.start.y) {
    c.l=0;
    n.r=0;
  } else if (c.start.x==n.start.x-spaceCol && c.start.y==n.start.y) {
    c.r=0;
    n.l=0;
  } else if (c.start.x==n.start.x && c.start.y==n.start.y-spaceRow) {
    c.b=0;
    n.t=0;
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

void keyPressed() {
  PVector above, left, right, below;
  above = new PVector(player.start.x, player.start.y-spaceRow);
  left = new PVector(player.start.x-spaceCol, player.start.y);
  right = new PVector(player.start.x+spaceCol, player.start.y);
  below = new PVector(player.start.x, player.start.y+spaceRow);
  if (add)
    trail = (PVector[]) (append(trail, player.start.copy()));
  if (showandmovePlayer) {
    if (keyCode==UP && getNeighbor(above)!=null && getNeighbor(above).b!=1) {
      player.start.y-=spaceRow;
    } else if (keyCode==DOWN && getNeighbor(below)!=null && getNeighbor(below).t!=1) {
      player.start.y+=spaceRow;
    } else if (keyCode==LEFT && getNeighbor(left)!=null && getNeighbor(left).r!=1) {
      player.start.x-=spaceCol;
    } else if (keyCode==RIGHT && getNeighbor(right)!=null && getNeighbor(right).l!=1) {
      player.start.x+=spaceCol;
    }
    add = notInTrail(player.start.copy());
    player.start.x = constrain(player.start.x, 0, width-spaceCol);
    player.start.y = constrain(player.start.y, 0, height-spaceRow);
  }
}

boolean notInTrail(PVector p) {
  for (int i = 0; i < trail.length; i++) {
    PVector pvector = trail[i];
    if (pvector != null && pvector.dist(p) < 1) {
      trail[i] = null;
      return false;
    }
  }
  return true;
}