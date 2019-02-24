class Asteriod {
  PVector pos, vel;
  int numVertices;
  float[] radii;
  PShape asteriod;
  float offset, inc, rotateAng, angVel, maxRadius, avgRadius, threshold;

  Asteriod(PVector loc, float r) {
    pos = loc;
    numVertices = int(random(5, 13));
    maxRadius = (r==0) ? (random(125, 175)) : r;
    radii = new float[numVertices];
    inc = random(5);
    angVel = random(-.05, .05);
    threshold = 20;

    if (maxRadius < 50) {
      vel = PVector.sub(ship.pos, pos);
      vel.normalize();
    } else {
      vel = PVector.random2D();
    }
    vel.mult(random(1.3, 3.3));

    for (int i = 0; i < radii.length; i++) {
      radii[i] = noise(offset)*maxRadius;
      offset+=inc;
      avgRadius+=radii[i];
    }
    avgRadius = avgRadius / radii.length;

    createAsteriod();
  }

  void update() {
    pos.add(vel);
    createAsteriod();
    rotateAng+=angVel;
  }

  void edges() {
    if (pos.x > width+avgRadius) pos.x = -avgRadius;
    if (pos.x < -avgRadius) pos.x = width+avgRadius;
    if (pos.y < -avgRadius) pos.y = height+avgRadius;
    if (pos.y > height+avgRadius) pos.y = -avgRadius;
  }

  void show() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotateAng);
    shape(asteriod);
    popMatrix();
  }

  void createAsteriod() {
    pushStyle();
    asteriod = createShape();
    asteriod.beginShape();
    asteriod.noFill();
    asteriod.stroke(255);
    asteriod.strokeWeight(2);
    for (int i = 0; i < numVertices; i++) {
      float x, y, angle = map(i, 0, numVertices, 0, TWO_PI);
      x = radii[i] * cos(angle);
      y = radii[i] * sin(angle);
      asteriod.vertex(x, y);
    }
    asteriod.endShape(CLOSE);
    popStyle();
  }
}
