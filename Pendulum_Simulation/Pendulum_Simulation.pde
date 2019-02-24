Pendulum[] pend;
void setup() {
  size(1000, 1100);
  pend = new Pendulum[50];
  pend[0] = new Pendulum(width/2, 0, 300);
  for (int i = 1; i < pend.length; i++) {
    Pendulum prev = pend[i-1];
    pend[i] = new Pendulum(prev.posBall.x, prev.posBall.y, prev.len*.99);
  }
  background(0);
}

void draw() {
  background(0);
  pend[0].update();
  pend[0].show();
  for (int i = 1; i < pend.length; i++) {
    Pendulum curr = pend[i];
    connect(curr, pend[i-1]);
    curr.update();
    curr.show();
  }
  

}

void connect(Pendulum curr, Pendulum prev) {
  curr.posLine.x = prev.posBall.x;
  curr.posLine.y = prev.posBall.y;
}

void keyPressed() {
  if (keyCode == LEFT)
    changeFactor(true);
  else if (keyCode == RIGHT)
  changeFactor(false);
}

void changeFactor(boolean increase) {
  for (int i = 0; i < pend.length; i++) {
    if (!increase)
      pend[i].lenFactor-=.01;
    else 
      pend[i].lenFactor+=.01;
   pend[i].lenFactor = constrain(pend[i].lenFactor, .98, 1.02);
  }
}