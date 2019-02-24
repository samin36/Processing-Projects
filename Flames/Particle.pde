class Particle {
  float x, y, r, vx, vy, alpha, ay;
  color col;
  Particle(float x_, float y_, float r_, float alpha_, color col_) {
    x=x_;
    y=y_;
    r=r_;
    alpha=alpha_;
    vx=random((r_ *-4)/100, (r_ *4)/100);
    // vy=random((r_ * -35)/100, -1);
    vy=map(sin(tan(alpha)), -1, 1, -25, -5);
    ay=.1;
    col = col_;
  }

  void drawImageParticle(PImage image_) {
    imageMode(CENTER);
    image_.resize(int(r), int(r));
    image(image_, x, y);
  }

  void drawParticle() {
    //stroke(col, alpha);
    //strokeWeight(65);
    noStroke();
    fill(col, alpha);
    ellipse(x, y, r, r);
  }

  void avoidMouse() {
    if (dist(x, y, mouseX, mouseY) < r/2)
      alpha=0;
  }

  void flameParticle() {
    //changes position
    x+=vx;
    y+=vy;
    alpha-=(r*9)/100;
    //alpha-=random((r * 10)/100);
  }
  void accelerateParticle() {
    //changes velocity
    vy+=ay;
  }
  float getAlpha() {
    return alpha;
  }
  boolean checkCollision(Particle second) {
    float alphaSecond = second.alpha;
    float limit = 100;
    if (alphaSecond < limit && alpha < limit) {
      if (dist(second.x, second.y, x, y) < radius)
        return true;
    }
    return false;
  }
}