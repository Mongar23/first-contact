class WirePuzzle extends GameObject {
  int itemCount = 5;
  Wire [] wire = new Wire[itemCount];
  boolean complete = false;
  boolean solved = false;
  Timer nextRoomDelayTimer = new Timer(2);

  WirePuzzle() {
    super("WirePuzzle", 0, 0, 0, 0);
    for (int i = 0; i < itemCount; i++) {
      wire[i] = new Wire(500/(itemCount+1)*(i+1));
    }
  }


  void display() {
    stroke(64, 45, 94);
    fill(40, 26, 61);
    rect(250, 200, 525, 625, 24);
    fill(64, 45, 94);
    rect(250, 250, 480, 480, 24);
    rect(250, -60, 480, 80, 24);

    if (complete) {
      textSize(64);
      fill(0);
      text("Correct", 250, -65);
    } else {
      textSize(42);
      fill(40, 26, 61);
      text("Scramble the wires", 250, -65);
    }
  }

  @Override
    void draw() {
    pushMatrix();
    translate(150, 200);

    rectMode(CENTER);
    textAlign(CENTER, CENTER);

    display();
    for (int i = 0; i < itemCount; i++) {
      wire[i].run(mouseX - 150, mouseY - 200);
    }
    solveCheck();

    if (complete) {
      if (!solved) {
        solved = true;
        nextRoomDelayTimer.start();
      }

      if (nextRoomDelayTimer.isFinished()) {
        try { 
          sceneManager.goToScene("paintingRoom");
        }
        catch(Exception exception) { 
          println(exception.getMessage());
        }
      }
    }

    rectMode(CORNER);
    textAlign(LEFT, BASELINE);

    popMatrix();
  }

  void solveCheck() {
    for (int i = 0; i < itemCount; i++) {
      if (wire[i].solved) {
        complete = true;
      } else {
        complete = false;
        return;
      }
    }
  }
}
