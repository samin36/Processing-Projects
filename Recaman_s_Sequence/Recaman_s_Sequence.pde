boolean[] visited;
int count, number, sequence[], size, max;

void setup() {
  size(1800, 600);
  size = 500;
  visited = new boolean[size];
  sequence = new int[1];
  count = 1;
  number = 0;
  sequence[0] = number;
  computeSequence();
  maxNumber();
}

void computeSequence() {
  while (sequence.length < 100) {
    int backStep = number - count, 
      forwardStep = number + count;

    if (backStep > 0 && !visited[backStep]) {
      visited[backStep] = true;
      sequence = append(sequence, backStep);
      count++;
      number = backStep;
    } else {
      visited[forwardStep] = true;
      sequence = append(sequence, forwardStep);
      count++;
      number = forwardStep;
    }
  }
  printArray(sequence);
}

void maxNumber() {
  max = Integer.MIN_VALUE;
  for (int num : sequence)
    if (num > max)
      max = num;
}



void draw() {
  background(0);
  stroke(255);
  strokeWeight(2);
  line(0, height/2, width, height/2);

  for (int i = 0; i < sequence.length-1; i++) {
    int curr = sequence[i], next = sequence[i+1];
    float start = mapToWindow(curr), end = mapToWindow(next);
    if (curr < next) {
      drawShape(start, end, mapHeight(curr, next));
    } else {
      drawShape(start, end, height/2 + mapHeight(next, curr));
    }
  }
}

void drawShape(float start, float end, float h) {
  stroke(0, 255, 0);
  float midPoint = lerp(start, end, .5);
  line(start, height/2, midPoint, h);
  line(midPoint, h, end, height/2);
}

float mapHeight(int curr, int next) {
  float ratio = ((float)(next-curr)) / max;
  return (height/2 * ratio);
}

float mapToWindow(int val) {
  return map(val, 0, max, 0, width);
}
