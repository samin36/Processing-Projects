ArrayList<Snowflake> snow;
PImage file;
ArrayList<PImage> textures;
PVector gravity;
void setup() {
  size(800, 800);
  snow = new ArrayList<Snowflake>();
  gravity = new PVector(0, .007);
  file = loadImage("f32.png");
  textures = new ArrayList<PImage>();
  preload();
}

void preload() {
  for (int x = 0; x < file.width; x+=32) {
    for (int y = 0; y < file.height; y+=32) {
      PImage img = file.get(x, y, 32, 32);
      textures.add(img);
    }
  }
}

void draw() {
  background(0);
  PImage design = textures.get((int)(random(textures.size())));
  snow.add(new Snowflake(design));
  for (Snowflake flake : snow) {
    pushMatrix();
    translate(flake.pos.x, flake.pos.y);
    rotate(flake.ang);
    flake.applyForce(gravity);
    // flake.render();
    flake.update();
    flake.sineWave();
    flake.render_img(true);
    popMatrix();
  }
  removeFlakes();
}


void removeFlakes() {
  for (int i = 0; i < snow.size(); i++) {
    if (snow.get(i).pos.y > height) {
      snow.remove(i);
      i--;
    }
  }
}