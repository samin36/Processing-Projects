class Ship {
  PVector pos, vel, acc;
  ArrayList<Bullet> bullets;
  float space, angle, turnAngle, radius;
  PShape ship, head;
  PShape[] thrusters;
  boolean slowDown, thrust;

  Ship(PVector loc) {
    reset(loc);
  }

  void reset(PVector loc) {
    pos = (loc==null) ? new PVector(width/2, height/2) : loc;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    space = 25;
    radius = space*.85;

    bullets = new ArrayList<Bullet>();
    ship = createShape(GROUP);
    head = createShape(TRIANGLE, -space, space*.75, space, space*.75, 0, -space*1.2);
    thrusters = new PShape[2];
    thrusters[0] = createShape(RECT, -space*.75, space*.75, 10, 20);
    thrusters[1] = createShape(RECT, space*.45, space*.75, 10, 20);
    head.setFill(0);
    head.setStroke(color(200, 0, 255));
    head.setStrokeWeight(2);
    for (int i = 0; i < thrusters.length; i++) {
      thrusters[i].setFill(0);
      thrusters[i].setStroke(0);
      thrusters[i].setStrokeWeight(1.5);
    }
    ship.addChild(head);
    ship.addChild(thrusters[0]);
    ship.addChild(thrusters[1]);
  }

  void applyForce(PVector force) {
    acc.add(force);
    acc.mult(.3);
  }

  void update() {
    vel.add(acc);
    vel.limit(16);
    pos.add(vel);
    acc.mult(0);

    shipAsteriodCollision();
    bulletAsteriodCollision();
    bulletCheck();
  }

  void shipAsteriodCollision() {
    for (int a = 0; a < asteriods.size(); a++) {
      Asteriod curr = asteriods.get(a);
      if (hit(curr)) {
        asteriods.remove(curr);
        reset(null);
        break;
      }
    }
  }

  void bulletAsteriodCollision() {
    for (int i = 0; i < bullets.size(); i++) {
      Bullet curr = bullets.get(i);
      for (int j = 0; j < asteriods.size(); j++) {
        Asteriod a = asteriods.get(j);
        if (curr.collideWithAsteriod(a)) {
          duplicateAsteroids(a);
          asteriods.remove(a);
          j--;
          bullets.remove(curr);
          i--;
          explosions.add(new Explosions(new PVector(a.pos.x, a.pos.y), a.maxRadius));
          break;
        }
      }
    }
  }

  void duplicateAsteroids(Asteriod parent) {
    if (parent.maxRadius > parent.threshold) {
      float per = random(.4, .6);
      float r1 = parent.maxRadius*per, r2 = parent.maxRadius*(1-per);
      if (r1 > parent.threshold)  asteriods.add(new Asteriod(parent.pos.copy(), r1));
      if (r2 > parent.threshold)  asteriods.add(new Asteriod(parent.pos.copy(), r2));
    }
  }

  void bulletCheck() {
    for (int i = 0; i < bullets.size(); i++) {
      Bullet curr = bullets.get(i);
      if (curr.outOfBounds()) {
        bullets.remove(curr);
        i--;
      }
    }
  }

  void show() {
    for (Bullet b : bullets) { 
      // b.edges();
      b.update();
      b.show();
    }
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    shape(ship);
    popMatrix();
  }

  boolean hit(Asteriod a) {
    return (dist(pos.x, pos.y, a.pos.x, a.pos.y) <= a.avgRadius+radius);
  }



  void addBullet() {
    if (!isShooting) {
      PVector position = new PVector(pos.x, pos.y);
      bullets.add(new Bullet(position, angle));
    }
  }

  void thrust() {
    if (thrust) {
      applyForce(PVector.fromAngle(angle-PI/2));
      thrusters[0].setFill(color(0, 255, 0, 180));
      thrusters[1].setFill(color(0, 255, 0, 180));
    } else {
      thrusters[0].setFill(0);
      thrusters[1].setFill(0);
    }
  }

  void edges() {
    if (pos.x > width+space) pos.x = -space;
    if (pos.x < -space) pos.x = width+space;
    if (pos.y < -space) pos.y = height+space;
    if (pos.y > height+space) pos.y = -space;
  }


  void setTurnAngle(float a) {
    turnAngle = a;
  }

  void turn() {
    angle+=turnAngle;
  }

  void slowDown() {
    if (slowDown) {
      vel.mult(.98);
    }
  }
}
