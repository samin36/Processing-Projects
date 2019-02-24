float hB, wB, numOf, angle;
ArrayList<Floor> floor;
Floor defFloor;
ArrayList<Obs> obs;
int[] mapCombo;
PVector boxPos, boxVel, def = new PVector(0, 0);
PImage frog;
void setup() {
  size(800, 800);
  preload();
  frog = loadImage("frog.png");
}

void preload() {
  hB = 40;
  wB = hB;
  boxPos = new PVector(width/2, height-(hB/2));
  boxVel = new PVector();
  numOf = (height-hB)/hB;
  floor = new ArrayList<Floor>();
  obs = new ArrayList<Obs>();
  defFloor = new Floor(0, height-hB, hB);
  mapCombo = randMap();
  createMap();
}


void draw() {
  background(0);
  defFloor.defFloor();
  for (Obs o : obs) {
    o.addObs();
    o.update();
  }
  for (Floor f : floor)
    f.addFloor();
  if (!onFloor() && onObs().equals(def) && !onDefFloor())
    preload();
  else if (!onFloor())
    attachToObs();
  drawPlayer();
}

void attachToObs() {
  boxVel = onObs();
  boxPos.add(boxVel);
}

void drawPlayer() {
  pushMatrix();
  translate(boxPos.x, boxPos.y);
  rotate(angle+radians(90));
  fill(255, 200);
  rectMode(CENTER);
  rect(0, 0, wB, hB);
  fill(0, 0, 255, 200);
  rect(0, -5, wB*.3, hB*.3);
  popMatrix();
  //image(frog, boxPos.x, boxPos.y, wB, hB);
}

boolean onDefFloor() {
  if (boxPos.x > defFloor.pos.x && boxPos.x < (defFloor.pos.x+width) && boxPos.y > defFloor.pos.y && boxPos.y < (defFloor.pos.y+hB))
    return true;
  return false;
}

boolean onFloor() {
  for (Floor f : floor)
    if (boxPos.x > f.pos.x && boxPos.x < (f.pos.x+width) && boxPos.y > f.pos.y && boxPos.y < (f.pos.y+hB))
      return true;
  return false;
}

PVector onObs() {
  for (Obs o : obs) 
    if (boxPos.x > o.pos.x && boxPos.x < (o.pos.x+o.w_) && boxPos.y > o.pos.y && boxPos.y < (o.pos.y+hB))
      return new PVector(o.vel.x, o.vel.y);
  return def;
}

void createMap() {
  for (int y = 0; y < mapCombo.length; y++) {
    if (mapCombo[y]==0) {
      float w = random(150, width-200);
      float x = random(-w, width+w);
      obs.add(new Obs(x, y*hB, w, hB));
    } else {
      floor.add(new Floor(0, y*hB, hB));
    }
  }
}

int[] randMap() {
  int[] map = new int[int(numOf)];
  for (int i = 0; i < map.length; i++) {
    map[i] = (random(100) < 30) ? 1 : 0;
  }
  return map;
}

void keyPressed() {
  switch(keyCode) {
  case LEFT: 
    boxVel.x=-wB;
    boxVel.y=0;
    boxPos.add(boxVel);
    break;
  case RIGHT:
    boxVel.x=wB;
    boxVel.y=0;
    boxPos.add(boxVel);
    break;
  case UP:
    boxVel.y=-hB;
    boxVel.x=0;
    boxPos.add(boxVel);
    break;
  case DOWN:
    boxVel.y=hB;
    boxVel.x=0;
    boxPos.add(boxVel);
    break;
  }
  boxPos.x = constrain(boxPos.x, wB/2, width-(wB/2));
  boxPos.y = constrain(boxPos.y, hB/2, height-(hB/2));
  angle = atan2(boxVel.y, boxVel.x);
  boxVel.mult(0);
}