class Tile {
  PVector pos;
  PVector goal;
  int score, factor;
  Tile(PVector pos_) {
    score = 2;
    pos = pos_;
  }

  void approach() {
    if (goal!=null && !pos.equals(goal)) {
      pos.lerp(goal, 1);
      println(pos, goal);
    }
  }

  void setGoal(PVector goal_) {
    goal = goal_;
  }

  void drawTile() {
    color c = 0;
    switch (score) {
    case 2: 
      c = color(237, 228, 217);
      break;
    case 4: 
      c = color(236, 224, 199);
      break;
    case 8:
      c = color(241, 178, 120);
      break;
    case 16:
      c = color(244, 150, 99);
      break;
    case 32:
      c = color(246, 124, 95);
      break;
    case 64:
      c = color(246, 94, 59);
      break;
    case 128:
      c = color(237, 207, 114);
      break;
    case 256:
      c = color(237, 204, 97);
      break;
    case 512:
      c = color(237, 200, 80);
      break;
    case 1024:
      c = color(237, 197, 63);
      break;
    case 2048:
      c = color(237, 194, 46);
      break;
    default: 
      c = color(200, 190, 45);
      break;
    }
    factor=20;
    noStroke();
    fill(c);
    rect(pos.x+factor, pos.y+factor, spaceCol-factor*2, spaceRow-factor*2, factor*.4);
    drawText();
  }

  void drawGrid(color c) {
    fill(c);
    factor=20;
    noStroke();
    rect(pos.x+factor, pos.y+factor, spaceCol-factor*2, spaceRow-factor*2, factor*.4);
  }

  void drawText() {
    color c = color(255);
    if (score==2 || score==4)
      c = color(118, 110, 101);
    else 
    c = color(255);
    fill(c);
    if (score < 1024)
      textSize(72);
    else
      textSize(64);
    textAlign(CENTER, CENTER);
    text(score, pos.x+spaceCol/2, pos.y+spaceRow*.45);
  }
}
