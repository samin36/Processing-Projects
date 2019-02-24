PImage img;
final int[][] MATRIX = { {0, 2}, 
  {2, 0} };

void setup() {
  size(800, 800);
  img = loadImage("image.PNG");
  transformImage();
}

void draw() {
  background(255);
  translate(width/2, height/2);
  transformImage();
  drawGrid();
  //  drawImg();
}

void drawImg() {
  //img.resize(width / 2, height/2);
  image(img, -img.width/2, -img.height/2);
}

void transformImage() {
  loadPixels();
  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int index = x + y * img.width;
      color imgColor = img.pixels[index];
      int x_ = (x + (width/2 - img.width/2));
      int y_ = (y + (height/2 - img.height/2));
      int tempX = MATRIX[0][0] * x_ + MATRIX[0][1] * y_;
      y_ = MATRIX[1][0] * x_ + MATRIX[1][1] * y_;
      x_ = tempX;
      int windowIndex = x_ + y_ * width;
      pixels[windowIndex] = imgColor;
    }
  }
  updatePixels();
}

void drawGrid() {
  stroke(0);
  strokeWeight(2);
  line(0, -height/2, 0, height/2);
  line(-width/2, 0, width/2, 0);
}
