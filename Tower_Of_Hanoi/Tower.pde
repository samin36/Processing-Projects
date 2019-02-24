class Tower {
  PVector location, toPutDisk;
  char name;
  float towerHeight, baseWidth, baseHeight;
  Tower (char name) {
    this.name = name;
    switch (name) {
    case s : 
      location = new PVector(width/6, height-50);
      break;
    case d :
      location = new PVector(2*width/3 + width/6, height-50);
      break;
    case h : 
      location = new PVector(width/3 + width/6, height-50);
      break;
    }
    baseWidth = width/6.3;
    baseHeight = 20;
    towerHeight = (location.y-baseHeight)-height/2;
    toPutDisk = new PVector(location.x, location.y-baseHeight*2);
  }

  void drawTower() {
    rectMode(RADIUS);
    fill(0, 255, 0);
    //stroke(0, 0, 255);
    strokeWeight(2);    
    rect(location.x, location.y, baseWidth, baseHeight);
    fill(255, 0, 0);
    rect(location.x, height/2, 8, towerHeight);
    textAlign(CENTER, CENTER);
    fill(0, 0, 255);
    textSize(baseHeight*1.25);
    text(name, location.x, location.y);
  }
  
  void addedDisk() {
   toPutDisk = new PVector(toPutDisk.x, toPutDisk.y-baseHeight*2); 
  }
  
  void removedDisk() {
   toPutDisk = new PVector(toPutDisk.x, toPutDisk.y+baseHeight*2); 
  }
  
  PVector getAvailableLoc() {
   return toPutDisk.copy(); 
  }
  
  char getTowerName() {
   return name; 
  }
}
