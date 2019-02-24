PImage img;
float threshold;
Point[] points;
boolean[][] locations;
int count;

void setup() {
  size(600, 600, P2D);
  img = loadImage("frog.jpg");
  img.resize(width, height);
  threshold = 80;
  points = new Point[width*height];
  points[count] = new Point(randomPVector());
  locations = new boolean[width][height];
  locations[points[count].getX()][points[count].getY()] = true;
  count = 1;

  while (count < width * height) {
    PVector rand = randomPVector();
    Point point = new Point(rand);
    if (!locations[point.getX()][point.getY()]) {
      points[count] = new Point(rand);
      locations[point.getX()][point.getY()] = true;
      count++;
    }
  }
}

void draw() {
  background(0);
  println(true);

  for (int i = 0; i < 1; i++) {
    for (Point curr : points) {
      if (curr!=null) {
        curr.show();
        curr.update();
      }
    }
  }
}

PVector randomPVector() {
  return new PVector(int(random(width)), int(random(height)));
}

class Point {
  PVector loc, vel, acc;
  color col;
  Point(PVector loc) {
    this.loc = loc;
    vel = new PVector(0, 0);
    setRandAcc();
    col = img.get(int(loc.x), int(loc.y));
  }

  int getX() {
    return (int) (loc.x);
  }

  int getY() {
    return (int) (loc.y);
  }

  void setRandAcc() {
    acc = PVector.random2D().mult(2);
  }

  void show() {
    noStroke();
    stroke(col);
    strokeWeight(1);
    point(loc.x, loc.y);
  }

  void update() {
    vel.add(acc);
    loc.add(vel);
    loc.x = constrain(loc.x, 0, width);
    loc.y = constrain(loc.y, 0, height);

    color col2 = img.get(int(loc.x), int(loc.y));
    float dist = dist(red(col), green(col), blue(col), red(col2), green(col2), blue(col2));
    if (dist > threshold) {
      acc.mult(0);
      vel.mult(0);
    } else {
      setRandAcc();
    }
  }
}
