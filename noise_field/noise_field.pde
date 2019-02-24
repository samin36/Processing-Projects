float space, xOff, yOff, zOff, inc;
int cols, rows;
PVector[] flow_field;
ArrayList<Particle> particles;
//import controlP5.*;
//ControlP5 cp5;
//Slider spc;
void setup() {
  fullScreen(P2D);
  colorMode(HSB, 255);
  //size(600, 600);
  space = 50;
  cols = floor(width/space);
  rows = floor(height/space);
  inc = .14;
  //cp5 = new ControlP5(this);
  //cp5.addSlider("space")
  //  .setPosition(space/2, height-space/2)
  //  .setRange(1, 20)
  //  .setWidth(300);
  flow_field = new PVector[cols*rows];
  particles = new ArrayList<Particle>();
  for (int i = 0; i < 20000; i++) {
    particles.add(new Particle());
  }
  background(0);
}

void draw() {
  // background(255); 
  showField();
  for (Particle p : particles) {
    p.follow(flow_field);
    p.update();
    p.edges();
    p.show();
  }
}
void showField() {
  xOff = 0;
  for (int x = 0; x < cols; x++) {
    yOff = 0;
    for (int y = 0; y < rows; y++) {
      float angle = noise(xOff, yOff, zOff)*4*TWO_PI;
      PVector v = PVector.fromAngle(angle);
      v.setMag(.5);
      int index = y + x * rows;
      //store the velocity vector into a 1d array that is calculated by the index
      flow_field[index] = v;
      //stroke(0, 100);
      //strokeWeight(3);
      //pushMatrix();
      //translate(x*space, y*space);
      //rotate(v.heading());
      //line(0, 0, space*.5, 0);
      //popMatrix();
      yOff+=inc;
    }
    xOff+=inc;
  }
  zOff+=.001;
  //inc+=.0001;
}

void mousePressed() {
  save("background.png");
}
