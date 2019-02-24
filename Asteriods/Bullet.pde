class Bullet {
  PVector pos, vel;
  float size, angle;
  color col;
  Bullet(PVector loc, float ang) {
    pos = loc;
    vel = PVector.fromAngle(ang-PI/2).mult(18);
    size = ship.space/8;
    col = color(0, 255, 0);
    angle = ang;
  }

  void setPos(PVector pos) {
    this.pos = pos;
  }

  void edges() {
    if (pos.x > width+size) pos.x = -size;
    if (pos.x < -size) pos.x = width+size;
    if (pos.y < -size) pos.y = height+size;
    if (pos.y > height+size) pos.y = -size;
  }

  boolean outOfBounds() {
    return (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height);
  }

  boolean collideWithAsteriod(Asteriod a) {
    return (dist(pos.x, pos.y, a.pos.x, a.pos.y) < a.avgRadius);
  }

  void update() {
    pos.add(vel);
  }

  void show() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    pushStyle();
    noStroke();
    fill(col);
    ellipseMode(RADIUS);
    ellipse(0, 0, size, size);
    popStyle();
    popMatrix();
  }
}
