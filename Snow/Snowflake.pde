class Snowflake {
  PVector pos, vel, acc;
  float x, y, r, ang;
  PImage img;
  Snowflake(PImage design_) {
    x = random(width);
    y = random(-50, -10);
    ang = 0;
    r = (random(1) < .7) ? random(25, 80) : random(5, 25);
    pos = new PVector(x, y);
    vel = new PVector(0, random(.5, 1));
    acc = new PVector();
    img = design_;
  }

  void sineWave() {
    pos.x+=sin(ang) * 2;
  }

  void applyForce(PVector force_) {
    PVector f = force_.copy();
    f.mult(r);
    acc.add(f);
  }

  void render() {
    stroke(0, 255, 0);
    strokeWeight(r);
    point(pos.x, pos.y);
  }

  void render_img(boolean rotate) {
    imageMode(CENTER);
    //tint(200, map(pos.y, 0, height, 0, 255), map(pos.x, 0, width, 0, 255));
    if (!rotate)
      image(img, this.pos.x, this.pos.y, this.r, this.r);
    else
      image(img, 0, 0, this.r, this.r);
  }

  void connect(Snowflake second) {
    strokeWeight(4);
    line(pos.x, pos.y, second.pos.x, second.pos.y);
  }

  void update() {
    vel.add(acc);
    vel.limit(r * .2);
    pos.add(vel);
    //acc.mult(0);
    ang+=.1;
  }
}