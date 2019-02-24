class Line {
  PVector start, end;
  float len;
  Line (PVector start, PVector end) {
    this.start = start;
    this.end = end;
    len = PVector.dist(start, end);
  }

  PVector rotateBy(float theta) {
    PVector pointToEnd = PVector.sub(end, start);
    if (theta > 0) pointToEnd = PVector.sub(start, end);
    float x = (cos(theta)*pointToEnd.x + -sin(theta) * pointToEnd.y); 
    float y = (sin(theta)*pointToEnd.x + cos(theta) * pointToEnd.y);
    pointToEnd = new PVector(x, y);
    if (theta < 0)
      return PVector.add(pointToEnd, start);
    else 
    return PVector.add(pointToEnd, end);
  }

  ArrayList<Line> getFourLines(float theta) {
    ArrayList<Line> ans = new ArrayList<Line>();
    Line l1 = new Line(start.copy(), PVector.lerp(start, end, 1.0/3));
    Line toRotate = new Line(l1.end.copy(), PVector.lerp(start, end, 2.0/3));
    Line l2 = new Line(toRotate.start.copy(), toRotate.rotateBy(theta));
    Line l3 = new Line(toRotate.rotateBy(theta), toRotate.end.copy());
    Line l4 = new Line(toRotate.end.copy(), end.copy());
    ans.add(l1);
    ans.add(l2);
    ans.add(l3);
    ans.add(l4);
    return ans;
  }

  void setStart(PVector s) {
    start = s;
  }

  void setEnd(PVector e) {
    end = e;
  }


  void showLine() {
    stroke(0, 255, 0);
    strokeWeight(1.5);
    noFill();
    //line(start.x, start.y, end.x, end.y);
    line(0, 0, end.x-start.x, end.y-start.y);
  }
}
