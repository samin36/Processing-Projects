int cols, rows, spaceCol, spaceRow;  //<>// //<>//
Tile[][] tiles, grid, columns;
Tile[] curr;
boolean moved, gameOver;
void setup() {
  size(800, 800);
  cols = 4;
  rows = 4;
  spaceCol = floor(width/cols);
  spaceRow = floor(height/rows);
  tiles = new Tile[cols][rows];
  grid = new Tile[cols][rows];
  moved = false;
  gameOver = false;
  addTile(1);
  textFont(createFont("Ubuntu-B.ttf", 64));
  for (int x=0; x<grid.length; x++) {
    for (int y=0; y<grid[x].length; y++) {
      grid[x][y] = new Tile(new PVector(x*spaceCol, y*spaceRow));
    }
  }
}

void restart() {
  tiles = new Tile[cols][rows];
  moved = false;
  gameOver = false;
  addTile(2);
}

void addTile(int numTimes) {
  for (int i = 0; i < numTimes; i++) {
    int randCol = int(random(cols)), randRow = int(random(rows)); 
    if (tiles[randRow][randCol]==null) {
      tiles[randRow][randCol] = new Tile(new PVector(randCol*spaceCol, randRow*spaceRow));
      tiles[randRow][randCol].score = 2;
    } else {
      i--;
    }
  }
}

void draw() {
  background(185, 172, 159); 
  grid();
  if (boardFilled() && !moved) {
    textAlign(CENTER);
    textSize(60);
    fill(255);
    text("Game Over! Click to restart", width/2, height*.5);
    gameOver = true;
  } else {
    for (Tile[] currArray : tiles) 
      for (Tile curr : currArray)
        if (curr!=null) {
          curr.approach();
          curr.drawTile();
        }
  }
}

void mousePressed() {
  if (boardFilled() && !moved)
    restart();
}

boolean boardFilled() {
  for (Tile[] currArray : tiles) 
    for (Tile curr : currArray)
      if (curr==null)
        return false;
  return true;
}

void grid() {
  for (Tile[] currArray : grid)
    for (Tile curr : currArray)
      if (curr!=null) {
        curr.drawGrid(color(204, 192, 180));
      }
}

void keyPressed() {
  if (!gameOver) {
    if (keyCode==LEFT) {
      moveTile(-1, 0);
    } else if (keyCode == RIGHT) {
      moveTile(1, 0);
    } else if (keyCode == UP) {
      moveTile(0, -1);
    } else if (keyCode == DOWN) {
      moveTile(0, 1);
    }
  }
}

Tile[] getCols(int index) {
  Tile[] col = new Tile[rows];
  for (int r = 0; r < tiles.length; r++) {
    col[r] = tiles[r][index];
  }
  return col;
}

Tile[] getRows(int index) {
  Tile[] row = new Tile[rows];
  for (int c = 0; c < tiles[index].length; c++) {
    row[c] = tiles[index][c];
  }
  return row;
}

void moveTile(int x, int y) {
  moved = false;
  columns = new Tile[cols][1];
  for (int c = 0; c < cols; c++)
    if (x==0)
      columns[c] = getCols(c);
    else
      columns[c] = getRows(c);
  for (int i = 0; i < cols; i++) {
    curr = columns[i];
    if (x==-1||y==-1)
      upleft(x, y, i);
    else
      downright(x, y, i);
  }
  if (moved)
    addTile(1);
}

Tile getNeighbor(PVector loc, int x, int y) {
  PVector neigh = new PVector(loc.x+x*spaceCol, loc.y+y*spaceRow);
  for (Tile[] t : tiles)
    for (Tile curr : t)
      if (curr!=null)
        if (curr.pos.dist(neigh)<1)
          return curr;
  return null;
}

void setTileToNull(PVector loc) {
  int colmn = int(loc.x/spaceCol);
  int row = int(loc.y/spaceRow);
  tiles[row][colmn] = null;
}

//void moveTileTo(int score, PVector loc) {
//  int colmn = int(loc.x/spaceCol);
//  int row = int(loc.y/spaceRow);
//  tiles[row][colmn] = new Tile(loc);
//  tiles[row][colmn].score = score;
//}
void moveTileTo(int score, PVector initialPos, PVector loc) {
  int colmn = int(loc.x/spaceCol);
  int row = int(loc.y/spaceRow);
  tiles[row][colmn] = new Tile(loc);
  tiles[row][colmn].score = score;
  tiles[row][colmn].setGoal(loc.copy());
}


boolean bounds(int index, int x, int y) {
  return (x==-1&&y==0 || x==0&&y==-1) ? (index > 0) : 
    ((x==1&&y==0 || x==0&&y==1) ? (index < cols-1) :
    false);
}

void downright(int x, int y, int i) {
  for (int index = curr.length-1; index>=0; index--) {
    if (x==0)
      columns[i] = getCols(i);
    else
      columns[i] = getRows(i);
    curr = columns[i];
    Tile tile = curr[index];
    if (bounds(index, x, y) && tile!=null) {
      Tile neighbor = getNeighbor(tile.pos, x, y);
      if (neighbor==null) {
        PVector newPos = new PVector(
          tile.pos.x+x*spaceCol, 
          tile.pos.y+y*spaceRow);
        println(tile.pos, newPos);
        moveTileTo(tile.score, tile.pos.copy(), newPos);
        setTileToNull(tile.pos);
        index+=2;
        moved = true;
      } else if (neighbor.score == tile.score) {
        setTileToNull(neighbor.pos);
        moveTileTo(tile.score*2, tile.pos.copy(), neighbor.pos);
        setTileToNull(tile.pos);
        // index+=2;
        moved = true;
      } else 
      continue;
    }
  }
}

void upleft(int x, int y, int i) {
  for (int index = 0; index < curr.length; index++) {
    if (x==0)
      columns[i] = getCols(i);
    else
      columns[i] = getRows(i);
    curr = columns[i];
    Tile tile = curr[index];
    if (bounds(index, x, y) && tile!=null) {
      Tile neighbor = getNeighbor(tile.pos, x, y);
      if (neighbor==null) {
        PVector newPos = new PVector(
          tile.pos.x+x*spaceCol, 
          tile.pos.y+y*spaceRow);
        moveTileTo(tile.score, tile.pos.copy(), newPos);
        setTileToNull(tile.pos);
        index-=2;
        moved = true;
      } else if (neighbor.score == tile.score) {
        setTileToNull(neighbor.pos);
        moveTileTo(tile.score*2, tile.pos.copy(), neighbor.pos);
        setTileToNull(tile.pos);
        // index-=2;
        moved = true;
      } else 
      continue;
    }
  }
}
