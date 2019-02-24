import gifAnimation.*;
Gif explode;

void setup() {
  size(800, 800);
  explode = new Gif(this, "explosion.gif");
  explode.noLoop();
  explode.play();
}

void draw() {
  background(0);
  imageMode(CENTER);
  image(explode, mouseX, mouseY, 100, 100);
}
