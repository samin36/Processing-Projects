class Pendulum {
  PVector posLine, posBall;
  float len;
  float angVel, angAcc, vel;
  float angle;
  float gravity, r, lenFactor;
  Pendulum(float x, float y, float len_) {
    posLine = new PVector(x, y);
    posBall = new PVector(x, y+len_);
    len = len_;
    angVel = random(.08, .18);
    angAcc = 0;
    angle = 0;
    lenFactor = 1;
    gravity = random(.0088, .017);
    r = len * .01;
    // println(r);
    //vel = 1/(r);
    vel = (angVel*500)/r;
  }

  void update() {
    posBall.x=posLine.x + len*sin(angle);
    posBall.y=posLine.y + len*cos(angle);
    angAcc = gravity / r * sin(-angle);
    angle+=angVel;
    angVel+=angAcc;
    angVel*=random(.99, .999);
    len*=lenFactor;
  }

  void movePoints() {
    posLine.x+=vel;
    if (posLine.x > width - 50 || posLine.x < 50)
      vel*=-1;
  }

  void show() {
    stroke(0, 255, 0);
    strokeWeight(3);
    line(posLine.x, posLine.y, posBall.x, posBall.y);
    noStroke();
    fill(255, 0, 0);
    ellipse(posBall.x, posBall.y, len * .2, len * .2);
  }
}