class Explosions {
  PVector loc;
  float millis;
  float radius;
  boolean exploded;
  Explosions(PVector pos, float r) {
    loc = pos;
    millis = 1000000;
    radius = r;
  }
  
  boolean exploded() {
   return exploded; 
  }

  void startExplosion() {
    millis = millis();   
    exploded = true;
  }
  
  void showExplosion() {
   imageMode(CENTER);
   image(explode, loc.x, loc.y, radius, radius);
  }

  boolean hasTimeEnded() {
    return (millis()-millis > 200);
  }
}
