class HShape {
  Line left, middle, right;
  PVector initialLoc;
  float len;
  HShape(PVector loc, float len_) {
    initialLoc = loc;
    len = len_;
    initializeShape();
  }

  void initializeShape() {
    middle = new Line(initialLoc.x-len/2, initialLoc.y, initialLoc.x+len/2, initialLoc.y);
    left = new Line(initialLoc.x-len/2, initialLoc.y-len/2, initialLoc.x-len/2, initialLoc.y+len/2);
    right = new Line(initialLoc.x+len/2, initialLoc.y-len/2, initialLoc.x+len/2, initialLoc.y+len/2);
  }

  void showShape() {
    middle.show();
    left.show();
    right.show();
  }

  class Line {
    PVector start, end;
    Line(float startX, float startY, float endX, float endY) {
      start = new PVector(startX, startY);
      end = new PVector(endX, endY);
    }

    PVector getStart() {
      return start.copy();
    }

    PVector getEnd() {
      return end.copy();
    }

    void show() {
      stroke(0, 255, 0);
      strokeWeight(2);
      line(start.x, start.y, end.x, end.y);
    }
  }
}
