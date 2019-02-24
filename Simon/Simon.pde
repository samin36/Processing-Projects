final int RED = 1, BLUE = 2, GREEN = 3, YELLOW = 4;
int space, offset, tempOff, num, count;
ArrayList<Integer> seq;
int curr, index;
boolean begin;
void setup() {
  size(800, 800);
  seq = new ArrayList<Integer>();
  space = width/2;
  offset = tempOff = 5;
  for (int i = 0; i < 2; i++) {
    int rand = int(random(1, 5));
    if (i==0)
      seq.add(rand);
    else if (rand!=seq.get(i-1))
      seq.add(rand);
    else
      i--;
  }
  println(seq.toArray());
  num = 1;
}

void draw() {
  background(0);
  if (begin) {
    frameRate(num);
    if (index < seq.size())
      curr = seq.get(index);
    else {
      curr = 0;
      num = 10;
      begin=false;
    }
  }
  if (index>=seq.size()) {
    frameRate(num);
  }
  drawSimon();
  if (begin)
    index++;
}
void mousePressed() {
  int quad = tappedOn();
  if (!begin && index > 0) {
    curr = quad;
    check(quad);
  }
}

void keyPressed() {
  if (keyCode==' ')
    begin=true;
}

void check(int tappedNum) {
  int curr = (count < seq.size()) ? seq.get(count) : 0;
  if (tappedNum!=curr) 
    println("WRONG"); 
  else
    count++;
  if (count==seq.size()) 
  println("ALL CORRECT!");
}


int tappedOn() {
  if (mouseX > 0 && mouseX < space && mouseY > 0 && mouseY < space)
    return 1;
  else if (mouseX > space && mouseX < 2*space && mouseY > 0 && mouseY < space)
    return 2;
  else if (mouseX > space && mouseX < 2*space && mouseY > space && mouseY < 2*space)
    return 3;
  else if (mouseX > 0 && mouseX < space && mouseY > space && mouseY < 2*space)
    return 4;
  else
    return 0;
}

void drawSimon() {
  for (int i = 1; i <= 4; i++) {
    fill(getColor(i));
    stroke(0);
    strokeWeight(10);
    if (i==1) {
      if (curr==i) {
        tempOff = offset;
        // frameRate(1);
        offset=50;
      }
      rect(offset, offset, space-2*offset, space-2*offset);
      offset = tempOff;
      tempOff = 5;
    } else if (i==2) {
      if (curr==i) {
        tempOff = offset;
        // frameRate(1);
        offset=50;
      }
      rect(space + offset, offset, space - 2*offset, space - 2*offset);
      offset = tempOff;
      tempOff = 5;
    } else if (i==3) {
      if (curr==i) {
        tempOff = offset;
        // frameRate(1);
        offset=50;
      }
      rect(space + offset, space + offset, space - 2*offset, space - 2*offset);
      offset = tempOff;
      tempOff = 5;
    } else {
      if (curr==i) {
        tempOff = offset;
        // frameRate(1);
        offset=50;
      }
      rect(offset, space + offset, space - 2*offset, space - 2*offset);
      offset = tempOff;
      tempOff = 5;
    }
  }
  offset = tempOff = 5;
  curr=0;
  //  frameRate(60);
}

color getColor(int num) {
  if (num==RED)
    return color(255, 0, 0);
  else if (num==BLUE)
    return color(0, 0, 255);
  else if (num==GREEN)
    return color(0, 255, 0);
  else 
  return color(255, 255, 0);
}