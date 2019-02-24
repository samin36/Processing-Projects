class Obs {
  PVector pos, vel, acc;
  float w_, h_;
  Obs(float x, float y, float w, float h) {
    pos = new PVector();
    vel = new PVector(random(-5, 5), 0);
    acc = new PVector(random(-.05, .05), 0);
    pos.x = x;
    pos.y = y;
    w_ = w;
    h_ = h;
  }

  void addObs() {
    fill(255, map(vel.x, -5, 5, 0, 155), 0, 210);
    rectMode(CORNER);
    rect(pos.x, pos.y, w_, h_);
  }

  void update() {
    vel.add(acc);
    pos.add(vel);
    if (pos.x+w_ < 0) {
      vel.x = random(-5, 5);
      pos.x=width;
    } else if (pos.x > width) {
      vel.x = random(-5, 5);
      pos.x=-w_;
    }
  }
}