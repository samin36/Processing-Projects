import gifAnimation.*;

ArrayList<Asteriod> asteriods;
Ship ship;
boolean isShooting;
Gif explode;
ArrayList<Explosions> explosions;

void setup() {
  size(1500, 900);
  //fullScreen();
  asteriods = new ArrayList<Asteriod>();
  explosions = new ArrayList<Explosions>();
  ship = new Ship(null);
  addAsteriods(1, "in");
  explode = new Gif(this, "explosion.gif");
  explode.play();
}

void addAsteriods(int num, String inOut) {
  for (int n = 0; n < num; n++) {
    PVector loc;
    if (inOut.equals("in"))
    loc = new PVector(random(-100, width+100), random(-100, height+100));
    else
    loc = (new PVector(random(-120, 0), random(height, height+120)));
    while (loc.dist(ship.pos) < 50) {
      loc = new PVector(random(width), random(height));
    }
    asteriods.add(new Asteriod(loc, 0));
  }
}

void draw() {
  background(0);


  if (asteriodDeficiency()) addAsteriods(int(random(5)), "out");

  for (Asteriod curr : asteriods) {
    curr.edges();
    curr.update();
    curr.show();
  }

  for (Explosions e : explosions) {
    if (!e.exploded())
      e.startExplosion();
    e.showExplosion();
  }

  for (int i = 0; i < explosions.size(); i++) {
    Explosions curr = explosions.get(i);
    if (curr.hasTimeEnded()) {
      explosions.remove(curr);
      i--;
    }
  }

  shipStuff();
}

boolean asteriodDeficiency() {
  return (asteriods.size() <= 1);
}

void shipStuff() {
  ship.thrust();
  ship.slowDown();
  ship.edges();
  ship.update();
  ship.turn();
  ship.show();
}

void keyPressed() {
  if (keyCode == UP) {
    ship.slowDown = false;
    ship.thrust = true;
  }
  if (keyCode == RIGHT) { 
    ship.setTurnAngle(.08);
  }
  if (keyCode == LEFT) { 
    ship.setTurnAngle(-.08);
  }
  if (keyCode == ' ') {
    ship.addBullet();
    isShooting = true;
  }
}

void keyReleased() {
  if (keyCode == UP) {
    ship.slowDown = true;
    ship.thrust = false;
  }

  if (keyCode == ' ')
    isShooting = false;

  ship.setTurnAngle(0);
}


void mousePressed() {
  // a.add(new Asteriod(new PVector(mouseX, mouseY)));
  explode.noLoop();
}
