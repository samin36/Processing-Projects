class Triangle {
  PVector p1, p2, p3;
  color c;
  Triangle(PVector p1_, PVector p2_, PVector p3_, color c_) {
    p1 = p1_;
    p2 = p2_;
    p3 = p3_;
    c = c_;
  }

  void show() {
    fill(c);
    noFill();
    stroke(255);
    strokeWeight(2);
    triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
  }
}
