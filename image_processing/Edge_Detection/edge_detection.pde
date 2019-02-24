PImage img;
void setup() {
  size(600, 600);
  img = loadImage("frog.jpg");
  img.resize(width, height);
}

void draw() {

  loadPixels();

  for (int x = 1; x < width - 1; x++) {
    for (int y = 1; y < height - 1; y++) {
      int pix = x + y * width, pixLeft = (x-1) + y * width;
      int pixRight = (x+1) + y * width, pixUp = x + (y-1) * width;
      int pixDown = x + (y+1) * width;
      float avgR = (red(img.pixels[pix]) + red(img.pixels[pixLeft]) + red(img.pixels[pixRight]) + red(img.pixels[pixUp]) + red(img.pixels[pixDown])) / 10;
      float avgG = (green(img.pixels[pix]) + green(img.pixels[pixLeft]) + green(img.pixels[pixRight]) + green(img.pixels[pixUp]) + green(img.pixels[pixDown])) / 10;
      float avgB = (blue(img.pixels[pix]) + blue(img.pixels[pixLeft]) + blue(img.pixels[pixRight]) + blue(img.pixels[pixUp]) + blue(img.pixels[pixDown])) / 10;
      pixels[pix] = color(avgR, avgG, avgB);
    }
  }

  updatePixels();
}
