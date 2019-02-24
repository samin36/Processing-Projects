String[] soln;
final char s = 'A', d = 'C', h = 'B';
int maxDisks;
Tower[] towers = new Tower[3];
Disk[] disks;
Disk current;
boolean startSolving, done;
int solnIndex;
void setup() {
  size(900, 600);
  maxDisks = 5;
  soln = new String[0];
  solveTower(maxDisks, s, d, h);
  solnIndex = 0;
  println(soln.length);
  towers[0] = new Tower(s);
  towers[1] = new Tower(h);
  towers[2] = new Tower(d);
  disks = new Disk[maxDisks];
  for (int i = 0; i < disks.length; i++) {
    disks[i] = new Disk(maxDisks-i, towers[0]);
  }
}

void draw() {
  background(0);
  drawTowers();
  moveAndDrawDisks();
  startMovement();
}

void startMovement() {
  if (startSolving && solnIndex < soln.length && !current.isMoving) {
    String moveLoc = soln[solnIndex];
    int number = Integer.valueOf(moveLoc.substring(0, 1));
    int index = maxDisks - number;
    char moveTo = moveLoc.charAt(1);
    current = disks[index];
    current.moveDisk(moveTo);
    solnIndex++;
  }
  //done = true;
}

void moveAndDrawDisks() {
  for (Disk curr : disks) {
    curr.lerpToTower();
    curr.drawDisk();
  }
}

void drawTowers() {
  for (Tower curr : towers) {
    curr.drawTower();
  }
}

void solveTower(int n, char source, char destination, char helper) {
  if (n==1) {
    soln = (String[]) append(soln, String.format("%d%c", n, destination));
    //println("Move disk " + n + " from " + source + " to " + destination);
  } else {
    solveTower(n-1, source, helper, destination);
    soln = (String[]) append(soln, String.format("%d%c", n, destination));
    solveTower(n-1, helper, destination, source);
  }
}

void keyPressed() {
  if (key==' ') {
    startSolving  = true;
    current = disks[maxDisks-1];
  }
}
