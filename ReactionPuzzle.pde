class ReactionPuzzle extends GameObject {    
    Timer nextRoomDelayTimer = new Timer(2);
    
    float sliderSize = 170;
    float targetSize = 40;
    float posX = width / 2;
    float posY = height / 2;
    
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
    
    
    ReactionPuzzle() {
        super("ReactionPuzzle", 0, 0, 0, 0);
    }
    
    @Override
    void draw() {            
        display();
        if (!solved) {
            move();
            return;
        }
        
        if (!nextRoomDelayTimer.isFinished()) { return; }
        
        try { sceneManager.goToScene("kitchen"); }
        catch(Exception exception) { println(exception.getMessage()); }
    }
    
    void display() {
        rectMode(CENTER);
        
        strokeWeight(5);
        stroke(64, 45, 94);
        fill(40,26, 61);
        rect(posX, posY, 525, 625, 24);
        fill(64,45, 94);
        rect(posX, posY, 480, 480, 24);
        
        
        //image(background, 0, -100, 500, 600);
        
        if (solved) {
            textSize(64);
            fill(119, 70, 194);
            text("Correct", 10, 50);
        } else{
            textSize(30);
            fill(119, 70, 194);
            text("Press button when pointers on target", 10, 50);
        }
        
        noStroke();
        fill(100);
        circle(posX, posY, 200);
        fill(200);
        circle(posX, posY, 170);
        fill(200,0,0);
        stroke(180,0,0);
        circle(posX, posY, 150);
        
        
        strokeWeight(20);
        stroke(119, 70, 194);
        line(posX + 200, posY - sliderSize, posX + 200, posY + sliderSize);
        line(posX - 200, posY - sliderSize, posX - 200, posY + sliderSize);
        line(posX - sliderSize, posY + 200, posX + sliderSize, posY + 200);
        line(posX - sliderSize, posY - 200, posX + sliderSize, posY - 200);
        
        noStroke();
        fill(targetColor);
        rect(posX + 200, posY, 20, targetSize * 2);
        rect(posX - 200, posY, 20, targetSize * 2);
        rect(posX, posY + 200, targetSize * 2, 20);
        rect(posX, posY - 200, targetSize * 2, 20);
        
        fill(pointerColor);
        rect(posX + 200, pointer1, 50, 20, 24);
        rect(posX + 220, pointer1, 20, 30, 12);
        rect(posX + 180, pointer1, 20, 30, 12);
        
        rect(posX - 200, pointer2, 50, 20, 24);
        rect(posX - 220, pointer2, 20, 30, 12);
        rect(posX - 180, pointer2, 20, 30, 12);
        
        rect(pointer3, posY + 200, 20, 50, 24);
        rect(pointer3, posY + 220, 30, 20, 24);
        rect(pointer3, posY + 180, 30, 20, 24);
        
        
        rect(pointer4, posY - 200, 20, 50, 24);
        rect(pointer4, posY - 220, 30, 20, 24);
        rect(pointer4, posY - 180, 30, 20, 24);
        rectMode(CORNER);
    }
    
    @Override
    public void mouseClicked() {
        solve(mouseX, mouseY);
    }
    
    void solve(float mX, float mY) {
        if (dist(posX, posY, mX, mY) < 75) {
            if (pointer1 > posY - targetSize && pointer1 < posY + targetSize && pointer3 > posX - targetSize && pointer3 < posX + targetSize) {
                pointerColor = color(43, 135, 32);
                solved = true;
                nextRoomDelayTimer.start();
            } else {
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
