class Wire {

  float posX;
  float baseX;

  float posY;
  float baseY;

  color  colour;
  boolean solved = false;
  
  float targetX;
  float targetY;

  Wire(float newBaseX, color newColor) {
    baseX = newBaseX;
    posY = 50;
    baseY = 450;
    posX = newBaseX;
    targetX = random(-100,600);
    targetY = random(-100, 400);
    colour =  color(newColor);
  }

  void run(float mX, float mY) {
    display();
    move(mX, mY);
  }

  void move(float mX, float mY) {
    if (! solved && mousePressed && dist( posX, posY, mX, mY) < 25) {
      posX = mX;
      posY = mY;
      
      if (dist( posX, posY, targetX, targetY ) < 5){
        solved = true;
        posX = targetX;
        posY = targetY;
        colour = color(40, 162, 168);
      }
    }
  }

  void display() {
    float midBaseX = baseX - (baseX - posX);
    float midPosX = posX - (posX - baseX);

    fill(150);
    ellipse(baseX, baseY, 20, 20);

    noFill();
    stroke(colour, 150);
    strokeWeight(20);
    bezier(baseX, baseY, midBaseX, baseY, midPosX, posY, posX, posY);
    strokeWeight(10);
    stroke(colour);
    bezier(baseX, baseY, midBaseX, baseY, midPosX, posY, posX, posY);
    strokeWeight(1);
    stroke(255);
    bezier(baseX, baseY, midBaseX, baseY, midPosX, posY, posX, posY);

    fill(200);
    ellipse(posX, posY, 20, 30);
    
    fill(colour, 200);
    ellipse(targetX, targetY, 20, 30);
  }
}
