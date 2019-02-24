class Disk {
  final int firstPlayer = -1, secondPlayer = -2;
  PVector pos, vel, stopLoc;
  int currentPlayer;
  color c;
  Disk(int player) {
    pos = new PVector(spaceCols/2, spaceRows/2);
    vel = new PVector();
    stopLoc = new PVector(spaceCols/2, spaceRows/2);
    currentPlayer = player;
    if (currentPlayer == firstPlayer)
      c = color(255, 255, 0);
    else
      c = color(255, 0, 0);
  }
  void setPos(PVector pos_) {
    pos = new PVector(pos_.x, pos_.y);
  }
  int getWhichPlayer() {
    return currentPlayer;
  }

  boolean closeToStop() {
    return (dist(pos.x, pos.y, stopLoc.x, stopLoc.y) < 1);
  }

  void update() {
    if (!(dist(pos.x, pos.y, stopLoc.x, stopLoc.y) < 1)) {
      pos.add(vel);
    } else {
      //vel.mult(0);
      //acc.mult(0);
    }
  }

  void drawDisk() {
    noStroke();
    fill(c);
    ellipse(pos.x, pos.y, spaceCols-24, spaceRows-24);
  }
}