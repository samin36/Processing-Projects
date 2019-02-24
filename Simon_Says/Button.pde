class Button {
  float x, y, size, freq;
  color dark, light;
  int quadID;
  boolean isLightOn = false;
  Button(float x_, float y_, float size_, color light_, float freq_, int quadID_) {
    x = x_;
    y = y_;
    size = size_;
    light = light_;
    freq = freq_;
    quadID = quadID_;
    dark = lerpColor(dark, light, .7);
  }

  void display() {
    stroke(0);
    strokeWeight(4);
    if (isLightOn)
      fill(light);
    else
      fill(dark);
    rectMode(CORNER);
    rect(x, y, size, size, 15);
  }

  boolean isLightOn() {
    return isLightOn;
  }

  void setLight(boolean change) {
    isLightOn = change;
  }

  boolean clickedOn() {
    return (mouseX > x && mouseX < x + size && mouseY > y && mouseY < size + y);
  }
}