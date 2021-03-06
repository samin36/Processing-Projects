import java.util.Arrays;
import java.util.ArrayList;
Grid gridOne;
int numRows = 3, numCols = 3;
String huPlayer = "O", aiPlayer = "X";
String[] xoSpaces;
PVector[] locs;
boolean play = true;
color c = color(random(76));
void setup() {
  size(900, 900);
  startOver();
}
void startOver() {
  gridOne = new Grid(numCols, numRows);
  locs = new PVector[numRows * numCols];
  calcLocs();
  xoSpaces = new String[numCols * numRows];
  for (int i = 0; i < xoSpaces.length; i++) {
    xoSpaces[i] = "N";
  }
  play = true;
}

void draw() {
  background(c);
  gridOne.drawGrid();
  drawShape();

  if (!play)
    startOver();
}

void drawShape() {
  for (int i = 0; i < xoSpaces.length; i++) {
    PVector curr = locs[i];
    if (xoSpaces[i] != null) {
      noFill();
      float strokeScale = 3*10;
      strokeWeight(strokeScale/numRows);
      float scale = (3*125*width);
      if (xoSpaces[i].equals(huPlayer)) {
        stroke(0, 255, 0);
        ellipse(curr.x, curr.y, scale/(numRows*600), scale/(numCols*600));
      } else if (xoSpaces[i].equals(aiPlayer)) {
        stroke(255, 0, 0);
        rectMode(CENTER);
        rect(curr.x, curr.y, scale/(numRows*600), scale/(numCols*600));
      }
    }
  }
}

void calcLocs() {
  PVector initial = new PVector(gridOne.spaceCol/2, gridOne.spaceRow/2), prev = new PVector(0, 0);
  locs[0] = initial;
  int count = 1;
  for (int i = 0; i < numRows; i++) {
    if (i > 0) {
      locs[count] = new PVector(gridOne.spaceCol/2, gridOne.spaceRow/2 + i * gridOne.spaceRow, count);
      count++;
    }
    for (int j = 1; j < numCols; j++) {
      prev = locs[count-1];
      locs[count]= new PVector(prev.x + gridOne.spaceCol, prev.y, count);
      count++;
    }
  }
}

String whoWins(String player) {
  if (player.equals(huPlayer))
    return "Human wins";
  else if (player.equals(aiPlayer))
    return "Computer wins";
  else
    return "It's a tie";
}

void checkIfClicked() {
  int pos = 0;

  float minDist = 999999;
  for (PVector p : locs) {
    if (dist(p.x, p.y, mouseX, mouseY) < minDist) {
      minDist = dist(p.x, p.y, mouseX, mouseY);
      pos = int(p.z);
    }
  }
  if (xoSpaces[pos].equals("N")) {
    turn(xoSpaces, huPlayer, pos);
    //println(play);
    if (!checkIfTie()) {
      //println(play);
      if (!checkIfWin(xoSpaces, huPlayer))
        //println(play);
        turn(xoSpaces, aiPlayer, bestSpot());
    } else {
      println(whoWins("tie"));
      startOver();
    }
  }
}

int bestSpot() {
  return int(minimax(xoSpaces, aiPlayer).x);
  //return emptySquares(xoSpaces)[0];
}

PVector minimax(String[] board, String player) {
  int[] availSpots = emptySquares(board); 
  // println(play);
  if (checkIfWin(board, huPlayer)) {
    return new PVector(0, -1);
  } else if (checkIfWin(board, aiPlayer)) {
    return new PVector(0, 1);
  } else if (availSpots.length==0) {
    return new PVector(0, 0);
  }
  ArrayList<Move> moves = new ArrayList<Move>();
  for (int i = 0; i < availSpots.length; i++) {
    Move move = new Move();
    move.index = availSpots[i];
    board[availSpots[i]] = player;

    if (player.equals(aiPlayer)) {
      int result = int(minimax(board, huPlayer).y);
      move.score = result;
    } else {
      int result = int(minimax(board, aiPlayer).y);
      move.score = result;
    }

    board[availSpots[i]] = "N";
    moves.add(move);
  }
  int bestMove = 0;
  if (player==aiPlayer) {
    int bestScore=-1000000;
    for (int i = 0; i < moves.size(); i++) {
      if (moves.get(i).score > bestScore) {
        bestScore = moves.get(i).score;
        bestMove = i;
      }
    }
  } else {
    int bestScore=1000000;
    for (int i = 0; i < moves.size(); i++) {
      if (moves.get(i).score < bestScore) {
        bestScore = moves.get(i).score;
        bestMove = i;
      }
    }
  }
  return new PVector(moves.get(bestMove).index, moves.get(bestMove).score);
}

int[] emptySquares(String[] board) {
  int[] emptySpots = new int[0];
  for (int i = 0; i < board.length; i++) {
    if (xoSpaces[i].equals("N"))
      emptySpots = append(emptySpots, i);
  }
  return emptySpots;
}

void turn(String[] board, String player, int pos_) {
  board[pos_] = player;
  play = !checkIfWin(board, player);
  if (!play) {
    println(whoWins(player));
  }
}

void mousePressed() {
  if (play)
    checkIfClicked();
}

boolean checkIfTie() {
  int Ncount = 0;
  for (String curr : xoSpaces) {
    if (curr.equals("N"))
      Ncount++;
  }
  if (Ncount==0)
    return true;
  else
    return false;
}

boolean checkIfWin(String[] board, String player) {
  //Horizontal check
  for (int i = 0; i < board.length; i+=numCols) {
    int count = 0;
    for (int j = i; j < i + numCols; j++) {
      if (board[i].equals(player) && board[i].equals(board[j]) && board[i] != "N")
        count++;
    }
    if (count==numCols)
      return true;
  }
  //Vertical check
  for (int i = 0; i < numCols; i+=1) {
    int count = 0;
    for (int j = i; j < board.length; j+=numCols) {
      if (board[i].equals(player) && board[i].equals(board[j]) && board[i] != "N")
        count++;
    }
    if (count==numCols)
      return true;
  }

  //Diagonal check
  int count1 = 0, count2 = 0;
  for (int k = 0, j = (numCols-1); k < board.length && j < board.length; k+=(numCols+1), j+=(numCols-1)) {
    if (board[0].equals(player) && board[0].equals(board[k]) && board[0] != "N")
      count1++;
    if (board[numCols-1].equals(player) && board[numCols-1].equals(board[j]) && board[numCols-1] != "N")
      count2++;
  }
  if (count1 == numCols || count2 == numCols)
    return true;

  return false;
}

class Move {
  int score, index;
  Move() {
  }
}