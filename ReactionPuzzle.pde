class ReactionPuzzle extends GameObject {    
    Timer nextRoomDelayTimer = new Timer(2);
    
    float sliderSize = 170;
    float targetSize = 40;
    float posX = 250;
    float posY = 250;
    
    float pointer1 = 250;
    float pointer2 = 250;
    float pointer3 = 250;
    float pointer4 = 250;
    float speed1 = 5;
    float speed2 = -5;
    float speed3 = 4;
    float speed4 = -4;
    
    color pointerColor = color(176, 9, 9);
    color targetColor = color(40, 26, 61);
    boolean solved = false;
    
    PImage background;
    PImage flame;
    
    
    ReactionPuzzle() {
        super("ReactionPuzzle", 0, 0, 0, 0);
        background = loadImage("ReactionPuzzleBackground.png");
        flame = loadImage("flame.png");
    }
    
    @Override
    void draw() {  
        pushMatrix();
        translate(150, 200);
        
        rectMode(CENTER);
        textAlign(CENTER, CENTER);
        imageMode(CENTER);
        
        display();
        if (!solved) {
            move();
            rectMode(CORNER);
            textAlign(LEFT, BASELINE);
            imageMode(CORNER);
            
            popMatrix();
            return;
        }
        
        if (!nextRoomDelayTimer.isFinished()) { 
            rectMode(CORNER);
            textAlign(LEFT, BASELINE);
            imageMode(CORNER);
            
            popMatrix();
            return;
        }
        
        try { 
            sceneManager.goToScene("kitchen");
        }
        catch(Exception exception) { 
            println(exception.getMessage());
        }
        
        rectMode(CORNER);
        textAlign(LEFT, BASELINE);
        imageMode(CORNER);
        
        popMatrix();
    }
    
    void display() {
        image(background, 250, 200, 800, 800);
        
        //    if(solved) {
        //      textSize(64);
        //      fill(0);
        //      text("Correct", posX, -100);
        //  } else {
        //      textSize(32);
        //      fill(0);
        //      text("Press button when pointers on target", posX, -100);
        //  }
        
        fill(pointerColor);
        image(flame, posX + 200, pointer1, 150, 150);
        image(flame, posX - 200, pointer2, 150, 150);
        image(flame, pointer3, posY - 200, 150, 150);
        image(flame, pointer4, posY + 200, 150, 150);
    }
    
    @Override
    public void mouseClicked() {
        solve(mouseX - 150, mouseY - 200);
    }
    
    void solve(float mX, float mY) {
        if (dist(posX, posY, mX, mY) < 75) {
            if (pointer1 > posY - targetSize && pointer1 < posY + targetSize && pointer3 > posX - targetSize && pointer3 < posX + targetSize) {
                correctSound.play();
                pointerColor = color(43, 135, 32);
                solved = true;
                nextRoomDelayTimer.start();
            } else {
                wrongSound.play();
                pointer1 = posX - sliderSize;
                pointer2 = posX + sliderSize;
                pointer3 = posY - sliderSize;
                pointer4 = posY + sliderSize;
            }
        }
    }
    
    void move() {
        pointer1 += speed1;
        pointer2 += speed2;
        pointer3 += speed3;
        pointer4 += speed4;
        
        if (pointer1 > posY + sliderSize || pointer1 < posY - sliderSize) {
            speed1= -speed1;
        }
        if (pointer2 > posY + sliderSize || pointer2 < posY - sliderSize) {
            speed2= -speed2;
        }
        if (pointer3 > posX + sliderSize || pointer3 < posX - sliderSize) {
            speed3= -speed3;
        }
        if (pointer4 > posX + sliderSize || pointer4 < posX - sliderSize) {
            speed4= -speed4;
        }
    }
}
