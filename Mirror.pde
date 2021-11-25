class Mirror {

  float posX;
  float posY;
  int number;
  boolean placed = false;
  PImage mirror;

  Mirror(int newNumber) {
    posX = random(20, 450);
    posY = random(20, 450);
    number = newNumber;
    mirror = loadImage("Mirror.png");
  }

  void display() {    
    image(mirror, posX, posY, 50, 60);

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
