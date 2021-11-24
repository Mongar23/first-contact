class MirrorPuzzle extends GameObject
{
  Mirror[] mirrors = new Mirror[4];
  float [] posX = new float[mirrors.length];
  float [] posY = new float[mirrors.length];
  float [] target = new float[mirrors.length];

  boolean finish = false;
  boolean [] mirrorActive = new boolean[mirrors.length];
  color laserColor = color(255, 0, 0);

  float startY;
  float endY;

  Timer nextRoomDelayTimer = new Timer(2);

  MirrorPuzzle() {
    super("MirrorPuzzle", 0, 0, 0, 0);
    for (int i = 0; i < mirrors.length; i++) {
      mirrors[i] = new Mirror(i);
      mirrorActive[i] = false;
    }
    startY = 400;
    endY = 100;
    posX[0] = 250;
    posY[0] = startY;
    target[1] = 250;
    target[3] = endY;
  }

  void checkMirrorPos() {
    if (mirrors[0].posY > startY - 10 && mirrors[0].posY < startY + 10 && mirrors[0].posX < 220) {
      mirrorActive[0] = true;
      mirrors[0].placed = true;
      posX[0] = mirrors[0].posX;
      posY[0] = mirrors[0].posY;
    }
    if (mirrorActive[0]) {
      if (mirrors[0].posY > startY + 10 || mirrors[0].posY < startY - 10) {
        mirrorActive[0] = false;
      }
    }

    for (int i = 1; i < mirrors.length; i+=2) {
      if (mirrorActive[i-1]) {
        if (mirrors[i].posX > mirrors[i-1].posX - 10 && mirrors[i].posX < mirrors[i-1].posX + 10 && 
          mirrors[i].posY > target[i] - 5 && mirrors[i].posY < target[i] + 5) {
          mirrorActive[i] = true;
          mirrors[i].placed = true;
          posX[i] = mirrors[i].posX;
          posY[i] = mirrors[i].posY;
        }
      } else if (mirrors[i].posX > posX[i-1] + 10 || mirrors[i].posX < posX[i-1] - 10) {
        mirrorActive[i] = false;
      }
    }

    for (int i = 2; i < mirrors.length; i+=2) {
      if (mirrorActive[i-1]) {
        if (mirrors[i].posY > mirrors[i-1].posY - 10 && mirrors[i].posY < mirrors[i-1].posY + 10 && mirrors[i].posX > 280) {
          mirrorActive[i] = true;
          mirrors[i].placed = true;
          posX[i] = mirrors[i].posX;
          posY[i] = mirrors[i].posY;
        }
      } else if (mirrors[i].posY > posY[i-1] + 10 || mirrors[i].posY < posY[i-1] - 10) {
        mirrorActive[i] = false;
      }
    }
  }

  void display() {
    stroke(64, 45, 94);
    fill(40, 26, 61);
    rect(250, 200, 525, 625, 24);
    fill(64, 45, 94);
    rect(250, 250, 480, 480, 24);
    rect(250, -50, 480, 80, 24);


    if (finish) {
      laserColor = color(0, 255, 0);
      textSize(64);
      fill(laserColor);
      text("Correct", 250, -50);
      if (nextRoomDelayTimer.isFinished()) {
        try { 
          sceneManager.goToScene("bathRoom");
        }
        catch(Exception exception) { 
          println(exception.getMessage());
        }
      }
    } else {
      textSize(38);
      fill(40, 26, 61);
      text("Connect the laser to the circle", 250, -50);
    }

    stroke(laserColor, 100);
    strokeWeight(8);
    line(0, startY, posX[0], startY);
    stroke(laserColor);
    strokeWeight(3);
    line(0, startY, posX[0], startY);

    if (mirrorActive[0]) {
      for (int i = 1; i < mirrors.length; i+=2) {
        if (mirrorActive[i]) {
          stroke(laserColor, 100);
          strokeWeight(8);
          line(posX[i-1], posY[i-1], posX[i-1], posY[i]);
          stroke(laserColor);
          strokeWeight(3);
          line(posX[i-1], posY[i-1], posX[i-1], posY[i]);
        } else {
          stroke(laserColor, 100);
          strokeWeight(8);
          line(posX[i-1], posY[i-1], posX[i-1], 0);
          stroke(laserColor);
          strokeWeight(3);
          line(posX[i-1], posY[i-1], posX[i-1], 0);
        }
      }
      if (mirrorActive[1]) {
        for (int i = 2; i < mirrors.length; i+=2) {
          if (mirrorActive[i]) {
            stroke(laserColor, 100);
            strokeWeight(8);
            line(posX[i-1], posY[i-1], posX[i], posY[i-1]);
            stroke(laserColor);
            strokeWeight(3);
            line(posX[i-1], posY[i-1], posX[i], posY[i-1]);
          } else {
            stroke(laserColor, 100);
            strokeWeight(8);
            line(posX[i-1], posY[i-1], 500, posY[i-1]);
            stroke(laserColor);
            strokeWeight(3);
            line(posX[i-1], posY[i-1], 500, posY[i-1]);
          }
        }
      }
    }

    if (mirrorActive[mirrors.length-1]) {
      stroke(laserColor, 100);
      strokeWeight(8);
      line(posX[mirrors.length-1], posY[mirrors.length-1], 500, posY[mirrors.length-1]);
      stroke(laserColor);
      strokeWeight(3);
      line(posX[mirrors.length-1], posY[mirrors.length-1], 500, posY[mirrors.length-1]);
      if (posY[mirrors.length-1] > endY - 10 && posY[mirrors.length-1] < endY + 10) {
        if (!finish) {
          finish = true;
          nextRoomDelayTimer.start();
        }
      }
    }
    noFill();
    stroke(40, 26, 61);
    strokeWeight(8);
    rect(250, 250, 500, 500, 24);

    fill(40, 26, 61);
    strokeWeight(6);
    rect(250, 120, 50, 235);
    rect(250, 380, 50, 235);
    circle(490, endY, 25);
  }

  @Override 
    void draw() {
    pushMatrix();
    translate(150, 200);

    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    display();
    checkMirrorPos();
    for (int i = 0; i < mirrors.length; i++) {
      mirrors[i].run(mouseX - 150, mouseY - 200);
    }

    rectMode(CORNER);
    textAlign(LEFT, BASELINE);

    popMatrix();
  }
}
