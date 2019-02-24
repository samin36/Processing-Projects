Button[] buttons; //<>//
SimonToneGenerator tones;
float space, pause;
float[] btnFreq = {209, 252, 310, 415, 60};
int[] sequence;
boolean wrong, userTurn, startGame;
int duration, seqCount, numSequence;

void setup() {
  size(800, 800);
  space = width/2;
  duration = 420;
  pause = 50;
  buttons = new Button[4];
  buttons[0] = new Button(0, 0, space, color(0, 255, 0), btnFreq[0], 0);
  buttons[1] = new Button(space, 0, space, color(255, 0, 0), btnFreq[1], 1);
  buttons[2] = new Button(space, space, space, color(255, 255, 0), btnFreq[2], 2);
  buttons[3] = new Button(0, space, space, color(0, 0, 255), btnFreq[3], 3);
  tones = new SimonToneGenerator(this, duration);
  numSequence = 1;
  randSequence();
  wrong = false;
}

void randSequence() {
  sequence = new int[numSequence];
  for (int i = 0; i < sequence.length; i++) { 
    sequence[i] = int(random(4));
  }
}

void addSequence() {
  sequence = append(sequence, int(random(4)));
  tones.setDuration(tones.maxDuration-25*sequence.length);
}

void draw() {
  background(0);

  tones.checkMillis();
  if (startGame)
    simonsTurn();

  display();
}

void simonsTurn() {
  if (!userTurn && seqCount < sequence.length) {
    if (millis() - tones.playMillis >= tones.maxDuration + pause) {
      Button curr = buttons[sequence[seqCount]];
      curr.setLight(true);
      tones.playTone(curr.freq);
      seqCount++;
      pause = 50;
    }
  } else if (!userTurn) {
    seqCount = 0;
    userTurn = true;
    tones.setDuration(duration);
  }
}

boolean isWrong(int quadID) {
  int correctNum = sequence[seqCount];
  if (quadID==correctNum) {
    seqCount++;
    return false;
  } else {
    seqCount=sequence.length*100;
    return true;
  }
}

void display() {
  for (Button b : buttons) {
    b.display();
  }
}

void reset(boolean wrong_) {
  seqCount=0;
  if (!wrong_) {
    addSequence();
    pause = duration;
  } else {
    randSequence();
    pause = duration * 2;
  }
  userTurn = false;
}

void mousePressed() {
  tones.stopTone();
  for (Button b : buttons) {
    if (b.clickedOn()) { 
      b.setLight(true);
      wrong = (seqCount < sequence.length) ? isWrong(b.quadID) : true;
      if (seqCount == sequence.length) {
        wrong = false; 
        reset(wrong);
      }
      if (wrong) {
        tones.playTone(btnFreq[4]);
        reset(wrong);
      } else {
        tones.playTone(b.freq);
      }
    }
  }
}

void mouseReleased() {
  for (Button b : buttons)
    if (b.clickedOn())
      b.setLight(false);
}

void keyPressed() {
  if (keyCode == ' ')
    startGame = true;
}