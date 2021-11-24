class Mirror {

  float posX;
  float posY;
  int number;
  boolean placed = false;

  Mirror(int newNumber) {
    posX = random(20, 450);
    posY = random(20, 450);
    number = newNumber;
  }

  void display() {
    stroke(56, 42, 4);
    fill(143, 109, 9);
    strokeWeight(3);
    ellipse(posX, posY, 40, 50);

    stroke(255, 150);
    strokeWeight(1);
    fill(133, 129, 118);
    arc(posX, posY, 30, 40, PI, PI + QUARTER_PI);
    arc(posX, posY, 30, 40, HALF_PI, HALF_PI + QUARTER_PI);
    arc(posX, posY, 30, 40, PI + HALF_PI, TWO_PI+QUARTER_PI);

    fill(0);
    textSize(32);
    text(number, posX, posY);
  }

  void run(float mX, float mY) {
    if (!placed && mousePressed && dist( posX, posY, mX, mY ) < 25) {
      posX = mX;
      posY = mY;
    }
    display();
  }
}
