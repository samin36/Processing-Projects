class Floor {
  PVector pos;
  float h_;
  Floor(float x, float y, float h) {
    pos = new PVector(); 
    pos.x = x;
    pos.y = y;
    h_ = h;
  }
  void addFloor() {
    fill(0, 255, 0, 210);
    rectMode(CORNER);
    rect(pos.x, pos.y, width, h_);
  }
  void defFloor() {
    fill(0);

    rectMode(CORNER);
    rect(pos.x, pos.y, width, h_);
  }
}