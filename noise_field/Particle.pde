class Particle { //<>//
  PVector pos, prevPos, vel, acc; 
  float h = 0;
  Particle() {
    pos = new PVector(random(width), random(height));
    prevPos = pos.copy();
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void update() {
    prevPos = pos.copy();
    vel.add(acc);
    vel.limit(random(4, 6));
    pos.add(vel);
    acc.mult(0);
  }

  void follow(PVector[] field) {
    int x = floor(pos.x/space), y = floor(pos.y/space);
    if (x >= cols)
      x-=1;
    if (y >= rows)
      y-=1;
    if (x < 0)
      x+=1;
    if (y < 0)
      y+=1;
    int index = y + x * rows;
    //println(field[index]);
    PVector force = field[index];
    applyForce(force);
  }


  void edges() {
    if (pos.x < 0) {
      pos.x = width;
      prevPos = pos.copy();
    }
    if (pos.x > width) {
      pos.x = 0;
      prevPos = pos.copy();
    } 
    if (pos.y < 0) {
      pos.y = height;
      prevPos = pos.copy();
    }
    if (pos.y > height) {
      pos.y = 0;
      prevPos = pos.copy();
    }
  }

  void applyForce(PVector f) {
    acc.add(f);
  }

  void show() {
    stroke(h, 255, 255, 5);
    strokeWeight(.4);
    line(pos.x, pos.y, prevPos.x, prevPos.y);
    prevPos = pos.copy();
    h+=.08;
    h = constrain(h, 0, 255);
  }
}
