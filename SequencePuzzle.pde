class SequencePuzzle extends GameObject{
    
    Timer nextRoomDelayTimer = new Timer(2);
    
    int sequenceLength = 4;
    int tileCount = 9;
    int[] sequence = new int[tileCount];
    
    boolean[] correct = new boolean[sequenceLength];
    float[] posX = new float[sequenceLength];
    float[] posY = new float[sequenceLength];
    
    boolean showSequenceOn = true;
    int time = 0;
    float size = 480 / 3;
    
    boolean complete = false;
    
    SequencePuzzle() {
        super("SequencePuzzle", 0, 0, 0, 0);
        
        sequence = scramble(9);
        for (int i = 0; i < sequenceLength; i++) {
            correct[i] = false;
            
            posX[i] = size * (sequence[i] % 3) + size / 2 + 10;
            if (sequence[i] < 3) {
                posY[i] = size / 2 + 10;
            } else if (sequence[i] < 6) {
                posY[i] = size * 1.5 + 10;
            } else {
                posY[i] = size * 2.5 + 10;
            }
        }
    }
    
    int[] scramble(int count) {
        IntList scrambler = new IntList();
        for (int i = 0; i < count; i++) {
            scrambler.append(i);
        }
        scrambler.shuffle();
        return scrambler.array();
    }
    
    @Override
    void draw() {
        pushMatrix();
        translate(150, 200);
        
        rectMode(CENTER);
        textAlign(CENTER, CENTER);
        
        strokeWeight(5);
        display();
        showSequence();
        
        if (correct[sequenceLength - 1]) {
            if (!complete) {
                nextRoomDelayTimer.start();
                complete = true;
            }            
            
            if (nextRoomDelayTimer.isFinished()) {
                try { sceneManager.goToScene("bedRoom"); }
                catch(Exception exception) { println(exception.getMessage()); }
            }
        }
        
        rectMode(CORNER);
        textAlign(LEFT, BASELINE);
        
        popMatrix();
    }
    
    void display() {
        
        stroke(64, 45, 94);
        fill(40, 26,61);
        rect(250, 200, 525, 625, 24);
        fill(64, 45,94);
        rect(250, -50, 480, 80, 24);
        
        if (complete) {
            textSize(64);
            fill(0);
            text("Correct", 250, -50);
        } else{
            textSize(38);
            fill(40, 26,61);
            text("Fill in password", 250, -50);
        }
        
        for (int i = 0; i < sqrt(tileCount); i++) {
            for (int j = 0; j < sqrt(tileCount); j++) {
                float posX = size * (i % 3) + size / 2 + 10;
                float posY = size * (j % 3) + size / 2 + 10;
                fill(59,42, 87);
                stroke(55, 38, 82);     
                rect(posX, posY, size, size, 24);
                
                stroke(64, 45, 94);
                fill(73,52, 107);
                rect(posX, posY, size * 0.8, size * 0.8, 24);
                
                textSize(128);
                fill(40,26, 61);
                text(i + j * 3 + 1, posX, posY - 25);
            }
        }
        
        for (int i = 0; i < sequenceLength; i++) {
            if (correct[i]) {
                fill(59,122,56);
                stroke(50, 105, 47);
                rect(posX[i], posY[i], size * 0.8, size * 0.8, 24);
                
                fill(46,94, 43);
                text(sequence[i] + 1, posX[i], posY[i] - 25);
            }
        }
        
        
    }
    
    void solve(float mX, float mY) {
        if (!showSequenceOn) {
            if (!correct[0]) {
                if (mX > posX[0] - size / 2 && mX < posX[0] + size / 2 && mY > posY[0] - size / 2 && mY < posY[0] + size / 2) {
                    correct[0] = true;
                    return;
                } else {
                    wrong();
                }
            } else {
                for (int i = 1; i < sequenceLength; i++) {
                    if (!correct[i] && correct[i - 1]) {
                        if (mX > posX[i] - size / 2 && mX < posX[i] + size / 2 && mY > posY[i] - size / 2 && mY < posY[i] + size / 2) {
                            correct[i] = true;
                            return;
                        } else {
                            wrong();
                        }
                    }
                }
            }
        }
    }
    
    @Override
    public void mouseClicked() {
        solve(mouseX - 150, mouseY - 200);
    }
    
    void wrong() {
        startSequence();
        for (int i = 0; i < sequenceLength; i++) {
            correct[i] = false;
        }
    }
    
    void showSequence() {
        if (showSequenceOn) {
            for (int i = 0; i < sequenceLength; i++) {
                if (time > i * 30 && time < (i + 1) * 30) {
                    fill(179, 30, 30);
                    stroke(150, 29, 29);
                    rect(posX[i], posY[i], size * 0.8, size * 0.8, 24);
                    fill(148, 30, 30);
                    text(sequence[i] + 1, posX[i], posY[i] - 25);
                }
            }
            time += 1;
            if (time > sequenceLength * 30) {
                showSequenceOn = false;
            }
        }
    }
    
    void startSequence() {
        showSequenceOn = true;
        time = 0;
    }
}
