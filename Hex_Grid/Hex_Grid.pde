ArrayList<Hex> hexagons;
int cols, rows, spaceCol, spaceRow;
float percent, angle;
void setup() {
  size(800, 800);
  cols = 12;
  rows = 12;
  spaceCol = width/cols;
  spaceRow = height/rows;
  percent = 6;
  angle = 0;
  hexagons = new ArrayList<Hex>();
  for (int x = 1; x <= cols; x++) {
    for (int y = 0; y <= rows; y++) {
      hexagons.add(new Hex(x*spaceCol*perDec(1, percent), 
        y*spaceRow*perDec(1, 1), spaceCol*.6, angle));
        angle+=.1;
    }
  }
  shiftPoints();
  background(0);
}

float perDec(float val, float percent_) {
  return (val-(val*(percent_/100)));
}

void shiftPoints() {
  int val = cols+1;
  for (int i = val; i < cols*rows; i+=val*2) {
    for (int j = i; j < i+val; j++) {
      Hex curr = hexagons.get(j);
      curr.y+=spaceRow/2;
      curr.calculate(curr.x, curr.y, curr.r);
    }
  }
}

void draw() {
  background(0);
  for (int i = 0; i < hexagons.size(); i++) {
    hexagons.get(i).drawHex();
  }
}