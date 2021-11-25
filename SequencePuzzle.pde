class SequencePuzzle extends GameObject {
    
    Timer nextRoomDelayTimer = new Timer(2);
    
    int sequenceLength = 4;
    int tileCount = 9;
    int[] sequence = new int[tileCount];
    
    boolean[] correct = new boolean[sequenceLength];
    float[] posX = new float[sequenceLength];
    float[] posY = new float[sequenceLength];
    
    boolean showSequenceOn = true;
    int time = 0;
    float size = 350 / 3;
    
    boolean complete = false;
    PImage background;
    PImage blueTile;
    PImage redTile;
    PImage greenTile;
    
    SequencePuzzle() {
        super("SequencePuzzle", 0, 0, 0, 0);
        background = loadImage("SequencePuzzleBackground.png");
        blueTile = loadImage("SequencePuzzleTileBlue.png");
        redTile = loadImage("SequencePuzzleTileRed.png");
        greenTile = loadImage("SequencePuzzleTileGreen.png");
        sequence = scramble(9);
        for (int i = 0; i < sequenceLength; i++) {
            correct[i] = false;
            
            posX[i] = size * (sequence[i] % 3) + size / 2 + 75;
            if (sequence[i] < 3) {
                posY[i] = size / 2 + 50;
            } else if (sequence[i] < 6) {
                posY[i] = size * 1.5 + 50;
            } else {
                posY[i] = size * 2.5 + 50;
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
        imageMode(CENTER);
        
        strokeWeight(5);
        display();
        showSequence();
        
        if (correct[sequenceLength - 1]) {
            if (!complete) {
                correctSound.play();
                nextRoomDelayTimer.start();
                complete = true;
            } 
            
            if (nextRoomDelayTimer.isFinished()) {
                try { 
                    sceneManager.goToScene("bedRoom");
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
    
    void display() {        
        image(background, 250, 200, 800, 800);
        
        for (int i = 0; i < sqrt(tileCount); i++) {
            for (int j = 0; j < sqrt(tileCount); j++) {
                float posX = size * (i % 3) + size / 2 + 75;
                float posY = size * (j % 3) + size / 2 + 50;
                
                image(blueTile, posX, posY, size, size);
                textSize(80);
                fill(40,26, 61);
                text(i + j * 3 + 1, posX, posY - 12);
            }
        }
        
        for (int i = 0; i < sequenceLength; i++) {
            if (correct[i]) {
                stroke(50, 105, 47);
                image(greenTile, posX[i], posY[i], size, size);
                fill(46,94, 43);
                text(sequence[i] + 1, posX[i], posY[i] - 12);
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
        wrongSound.play();
        
        startSequence();
        for (int i = 0; i < sequenceLength; i++) {
            correct[i] = false;
        }
    }
    
    void showSequence() {
        if (showSequenceOn) {
            for (int i = 0; i < sequenceLength; i++) {
                if (time > i * 30 && time < (i + 1) * 30) {
                    stroke(150, 29, 29);
                    image(redTile, posX[i], posY[i], size, size);
                    fill(148, 30, 30);
                    text(sequence[i] + 1, posX[i], posY[i] - 12);
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
