class Player extends Cell {
  int factor = 4;
  Player(PVector pos_) {
    super(pos_);
  }

  void drawPlayer() {
    fill(0, 0, 255, 225);
    noStroke();
    rect(start.x+factor, start.y+factor, spaceCol-2*factor, spaceRow-2*factor);
  }
  
  void endPlayer() {
     fill(255, 255, 0, 225);
    noStroke();
    rect(start.x+factor, start.y+factor, spaceCol-2*factor, spaceRow-2*factor);
  }
}