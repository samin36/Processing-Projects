class Disk { //<>//
  int num;
  Tower start;
  int radius;
  char name;
  PVector location;
  PVector[] destinations;
  float diskHeight, step;
  boolean isMoving;
  int dest = 0;

  Disk (int num, Tower setTo) {
    this.num = num;
    start = setTo;
    radius = int(start.baseWidth - ((maxDisks-num)*13 + 10));
    name = start.getTowerName();
    location = start.getAvailableLoc();
    destinations = new PVector[3];
    start.addedDisk();
    diskHeight = start.baseHeight;
    step = .1;
  }

  void setDisk(Tower toSetTo) {
    start = toSetTo;
    destinations[destinations.length-1] = start.getAvailableLoc();
    destinations[0] = new PVector(location.x, height/2-start.towerHeight-(diskHeight+5));
    destinations[1] = new PVector(start.location.x, destinations[0].y);
    start.addedDisk();
  }

  void lerpToTower() {
    if (destinations[dest]!=null) {
      if (destinations[dest].equals(location)) {
        destinations[dest]=null;
        if (dest == destinations.length-1) {
          isMoving = false;
          dest=0;
        } else { 
          dest++;
        }
        step = .1;
      } else {
        location.lerp(destinations[dest], step);
        if (step<.5)
          step+=.1;
      }
    }
  }

  void drawDisk() {
    rectMode(RADIUS);
    fill(map(maxDisks-num, 1, maxDisks, 0, 255), 0, 255);
    strokeWeight(2);
    rect(location.x, location.y, radius, diskHeight);
    fill(255);
    textSize(diskHeight*1.25);
    textAlign(CENTER, CENTER);
    text(num, location.x, location.y);
  }

  void moveDisk(char moveTo) {
    isMoving = true;
    start.removedDisk();
    Tower whereToMove = (moveTo==s) ? towers[0] : (moveTo==h) ? towers[1] : towers[2];
    setDisk(whereToMove);
  }
}
