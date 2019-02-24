class Blob {
  PVector loc, vel;
  float r;
 Blob(float x, float y) {
   loc = new PVector(x, y);
   vel = PVector.random2D();
   vel.mult(random(20, 25));
   r = random(4000, 6000);
 }
 
 void update() {
  loc.add(vel);
  vel.x = (loc.x > width || loc.x < 0) ? vel.x*=-1 : vel.x;
  vel.y = (loc.y > height || loc.y < 0) ? vel.y*=-1 : vel.y;
 }
 
 void show() {
  noFill();
  stroke(255);
  ellipse(loc.x, loc.y, r*2, r*2);
 }
 
}