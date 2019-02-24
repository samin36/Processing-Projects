Blob[] blobs;
void setup() {
  size(700, 300);
  blobs = new Blob[1];
  for (int i = 0; i < blobs.length; i++)
    blobs[i] = new Blob(random(width), random(height));
}

void draw() { 
  loadPixels();
  for (int x = 0; x < width; x+=1) {
    for (int y = 0; y < height; y+=1) {
      int pixel = x + y * width;
      float sum = 0;
      for (Blob b : blobs) {
        float dist = dist(b.loc.x, b.loc.y, x, y);
        sum += b.r / dist;
      }
      pixels[pixel] = color(sum-constrain(mouseX,0, 255));
    }
  }
  updatePixels();
  for (Blob b : blobs) 
    b.update();
}