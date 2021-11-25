class WirePuzzle extends GameObject {
  int itemCount = 5;
  Wire [] wire = new Wire[itemCount];
  color [] newColor= new color[itemCount];
  boolean complete = false;
  boolean solved = false;
  Timer nextRoomDelayTimer = new Timer(2);

  PImage background;

  WirePuzzle() {
    super("WirePuzzle", 0, 0, 0, 0);
    newColor[0] = color(36, 76, 99);
    newColor[1] = color(41, 38, 77);
    newColor[2] = color(35, 119, 129);
    newColor[3] = color(68, 80, 154);
    newColor[4] = color(54, 29, 52);

    background = loadImage("WirePuzzleBackground.png");

    for (int i = 0; i < itemCount; i++) {
      wire[i] = new Wire(500/(itemCount+1)*(i+1), newColor[i]);
    }
  }


  void display() {
    stroke(64, 45, 94);
    fill(40, 26, 61);
    rect(250, 200, 525, 625, 24);
    fill(64, 45, 94);
    rect(250, 250, 480, 480, 24);
    rect(250, -60, 480, 80, 24);

    image(background, 250, 200, 800, 800);

    //if (complete) {
    //  textSize(64);
    //  fill(0);
    //  text("Correct", 250, -65);
    //} else {
    //  textSize(42);
    //  fill(40, 26, 61);
    //  text("Scramble the wires", 250, -65);
    //}
  }

  @Override
    void draw() {
    pushMatrix();
    translate(150, 200);

    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    imageMode(CENTER);

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
    imageMode(CORNER);

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
