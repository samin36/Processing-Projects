ArrayList<Particle> flame;
float sX, sY, radius, alpha;
PImage shrek;
color particleColor = color(255, map(mouseX, 0, width, 80, 255), 80);
void setup() {
  size(800, 800); 
  flame = new ArrayList<Particle>();
  sX = width/2;
  radius = 55;
  alpha = 255;
  sY = height - radius;
  shrek = loadImage("shrek.png");
  //sY = height/2;
  for (int i = 0; i < flame.size(); i++) {
    flame.add(new Particle(sX, sY, radius, alpha, particleColor));
  }
  background(0);
}

void draw() {
  flame.add(new Particle(sX, sY, radius, alpha, particleColor));
  particleColor = color(255, map(mouseX, 0, width, 80, 255), 80);
  background(0);
  for (int i = 0; i < flame.size(); i++) {
    for (int j = i; j < flame.size(); j++) {
      if (flame.get(i).checkCollision(flame.get(j))) {
        flame.get(j).col = color(50, 255-map(mouseX, 0, width, 70, 255), 255-80);
        if (random(1) < .5)
          flame.get(j).alpha-=2;
        else
          flame.get(j).alpha+=3;
      }
    }
  }
  for (int i = 0; i < flame.size(); i++) {
    Particle curr = flame.get(i);
    if (curr.alpha < 0) {
      flame.remove(i);
      i--;
    }
  }
  for (Particle p : flame) {
    p.flameParticle();
    //p.accelerateParticle();
    p.avoidMouse();
    //p.drawParticle();
    p.drawImageParticle(shrek);
  }
  moveParticle();
  numOfParticles();
}
int num = 0;
void moveParticle() {
  sX+=num;
  if (sX<=radius/2)
    num*=-1;
  else if (sX>=(width-radius/2))
    num*=-1;
}

void numOfParticles() {
  textSize(100);
  fill(particleColor);
  text(flame.size(), 30, 120);
}