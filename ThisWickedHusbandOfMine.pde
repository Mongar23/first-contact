import processing.sound.*;

final int windowWidth = 800;
final int windowHeight = windowWidth;

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();

SoundFile mainTheme;
SoundFile glassCrash;
SoundFile wrongSound;
SoundFile correctSound;

void settings() {
    size(windowWidth, windowHeight);
}

void setup() {    
    int startTime = millis();
    // --------------------------------------START UP-----------------------------------------------------------------------------------------------------------
    Collectable hallKey = new Collectable("hallKey", "key.png");
    mainTheme = new SoundFile(this, "mainTheme.mp3");
    mainTheme.amp(0.25f);
    glassCrash = new SoundFile(this, "GlassCrash.mp3");
    wrongSound = new SoundFile(this, "ErrorSound.mp3");
    correctSound = new SoundFile(this, "CorrectSound.mp3");
    correctSound.amp(0.75f);
    
    
    // --------------------------------------MAIN MENU----------------------------------------------------------------------------------------------------------
    Scene mainMenu = new Scene("mainMenu", "white1x1.png");
    GameObject startPainting = new GameObject("mainMenu_painting", 10, 25, 530, 750, "paintingNormal.jpg");
    startPainting.setHoverImage("paintingGhost.jpg");
    mainMenu.addGameObject(startPainting);
    mainMenu.addGameObject(new GameObject("mainMenu_logo", 570, 25, 200, 635, "logo.png"));
    MoveToSceneObject startButton = new MoveToSceneObject("startGame", 570, 685, 200, 90, "startButton_idle.png", "livingRoom");
    startButton.setHoverImage("startButton_selected.png");
    mainMenu.addGameObject(startButton);
    sceneManager.addScene(mainMenu);
    
    // --------------------------------------MAIN GAME----------------------------------------------------------------------------------------------------------
    
    Scene livingRoom = new Scene("livingRoom", "10LR_Background.png");
    livingRoom.addGameObject(new Draggable("Painting", 775, 300, 130, 206, "9LR_Painting.png"));
    livingRoom.addGameObject(new Draggable("Lamp", 550, 400, 195, 266, "8LR_Lamp.png"));
    livingRoom.addGameObject(new Draggable("LoungeChair", 440, 550, 250, 134, "7LR_LoungeChair.png"));
    livingRoom.addGameObject(new Draggable("Couch", 75, 570, 336, 133, "6LR_Couch.png"));
    livingRoom.addGameObject(new Draggable("Table", 575, 615, 187, 104, "5LR_Table.png"));
    livingRoom.addGameObject(new Draggable("Fan", 60, 530, 96, 206, "4LR_Fan.png"));
    livingRoom.addGameObject(new Draggable("Box", 670, 565, 87, 86, "3LR_Box.png"));
    livingRoom.addGameObject(new Draggable("Cigs", 640, 615, 58, 50, "2LR_Cigs.png"));
    livingRoom.addGameObject(new Draggable("LightFixture", 100, 0, 608, 470, "1LR_LightFixture.png"));
    MoveToSceneObject livingRoomToHall = new MoveToSceneObject("livingRoom-to-hall", 50, 350, 50, 50, "arrowLeft.png", "hall");
    livingRoom.addGameObject(new RequireObject("livingRoomLock", 50, 350, 50, 50, "lock.png", "You need to find the key first!", hallKey, livingRoomToHall));
    livingRoom.addGameObject(new MoveToSceneObject("lingRoom-to-kitchen", 400, 50, 50, 50, "arrowUp.png", "reactionPuzzle"));
    sceneManager.addScene(livingRoom);
    
    Scene reactionPuzzleScene = new Scene("reactionPuzzle", "white1x1.png");
    ReactionPuzzle reactionPuzzle = new ReactionPuzzle();
    reactionPuzzleScene.addGameObject(reactionPuzzle);
    sceneManager.addScene(reactionPuzzleScene);
    
    Scene kitchen = new Scene("kitchen", "11K_Background.png");
    kitchen.addGameObject(new CollectableObject("hallKey", 70, 442, 50, 50, hallKey));
    kitchen.addGameObject(new Draggable("10K_Bin", 293, 498, 57, 76, "10K_Bin.png"));
    kitchen.addGameObject(new Draggable("9K_Fridge", 321, 353, 146, 231, "9K_Fridge.png"));
    kitchen.addGameObject(new Draggable("8K_Counter", 423, 336, 416, 339, "8K_Counter.png"));
    kitchen.addGameObject(new Draggable("7K_Table", -73, 467, 272, 187, "7K_Table.png"));
    kitchen.addGameObject(new Draggable("6K_Chair", 364, 575, 119, 192, "6K_Chair.png"));
    kitchen.addGameObject(new Draggable("5K_Chair", 213, 536, 121, 196, "5K_Chair.png"));
    kitchen.addGameObject(new Draggable("4K_Chair", 440, 563, 140, 208, "4K_Chair.png"));
    kitchen.addGameObject(new Draggable("3K_Table", 209, 630, 310, 190, "3K_Table.png"));
    kitchen.addGameObject(new Draggable("2K_TV", -61, 255, 234, 156, "2K_TV.png"));
    kitchen.addGameObject(new Draggable("1K_Microwave", 64, 447, 95, 59, "1K_Microwave.png"));
    kitchen.addGameObject(new MoveToSceneObject("kitchen-to-livingRoom", 100, 700, 50, 50, "arrowDown.png","livingRoom"));
    kitchen.addGameObject(new MoveToSceneObject("kitchen-to-bedRoom", 650, 700, 50, 50, "arrowDown.png","sequencePuzzle"));
    sceneManager.addScene(kitchen);
    
    Scene sequencePuzzleScene = new Scene("sequencePuzzle", "white1x1.png");
    SequencePuzzle sequencePuzzle = new SequencePuzzle();
    sequencePuzzleScene.addGameObject(sequencePuzzle);
    sceneManager.addScene(sequencePuzzleScene);
    
    Scene bedRoom = new Scene("bedRoom", "9B_Background.png");
    bedRoom.addGameObject(new MoveToSceneObject("bedRoom-to-kitchen", 400, 50, 50, 50, "arrowUp.png","kitchen"));
    bedRoom.addGameObject(new MoveToSceneObject("bedRoom-to-bathRoom", 400, 700, 50, 50, "arrowDown.png","mirrorPuzzle"));
    GameObject bedMirror = new GameObject("Mirror", 183, 162, 130, 294, "8B_Mirror.png");
    bedMirror.setClickedImage("8B_MirrorCracked.png");
    bedRoom.addGameObject(bedMirror);
    bedRoom.addGameObject(new Draggable("Dresser", -50, 364, 280, 204, "7B_Dresser.png"));
    bedRoom.addGameObject(new Draggable("Bedside", 0,0, 800, 800, "6B_Bedside.png"));
    bedRoom.addGameObject(new Draggable("Bed", 150, 380, 601, 272, "5B_Bed.png"));
    bedRoom.addGameObject(new Draggable("Bedside", 100, 0, 800, 800, "4B_Bedside.png"));
    bedRoom.addGameObject(new Draggable("Plant", 5, 287, 121, 85, "3B_Plant.png"));
    bedRoom.addGameObject(new Draggable("Lamp", 400, 250, 193, 245, "2B_Lamp.png"));
    bedRoom.addGameObject(new Draggable("Lamp1", 670, 230, 213, 275, "1B_Lamp.png"));
    sceneManager.addScene(bedRoom);
    
    Scene mirrorPuzzleScene = new Scene("mirrorPuzzle", "white1x1.png");
    MirrorPuzzle mirrorPuzzle = new MirrorPuzzle();
    mirrorPuzzleScene.addGameObject(mirrorPuzzle);
    sceneManager.addScene(mirrorPuzzleScene);
    
    Scene bathRoom = new Scene("bathRoom", "7BR_Background.png");
    GameObject mirror = new GameObject("Mirror", 123, 162, 262, 219, "5BR_Mirror.png");
    mirror.setClickedImage("5BR_MirrorCracked.png");
    bathRoom.addGameObject(mirror);   
    bathRoom.addGameObject(new Draggable("Towelrack", 411, 393, 114, 102, "4BR_Towelrack.png"));
    bathRoom.addGameObject(new Draggable("Sink", 106, 364, 314, 283, "3BR_Sink.png"));
    bathRoom.addGameObject(new Draggable("Tub", 446, 470, 354, 200, "2BR_Tub.png"));
    bathRoom.addGameObject(new Draggable("Throne", 7, 467, 158, 195, "1BR_Throne.png"));
    bathRoom.addGameObject(new MoveToSceneObject("bathRoom-to-bedRoom", 650, 50, 50, 50, "arrowUp.png","bedRoom"));
    MoveToSceneObject bathRoomToHall = new MoveToSceneObject("bathRoom-to-hall", 50, 350, 50, 50, "arrowLeft.png","hall");
    bathRoom.addGameObject(new RequireObject("livingRoomLock", 50, 350, 50, 50, "lock.png", "You need to find the key first!", hallKey, bathRoomToHall));
    sceneManager.addScene(bathRoom);
    
    Scene hall = new Scene("hall", "2HW_Background.png");
    hall.addGameObject(new Draggable("Plant", 143, 535, 96, 96, "1HW_Plant.png"));
    hall.addGameObject(new MoveToSceneObject("hall-to-bathRoom", 700, 700, 50, 50, "arrowRight.png","bathRoom"));
    hall.addGameObject(new MoveToSceneObject("hall-to-paintingRoom", 350, 50, 50, 50, "arrowUp.png","wirePuzzle"));
    sceneManager.addScene(hall);
    
    Scene wirePuzzleScene = new Scene("wirePuzzle", "white1x1.png");
    WirePuzzle wirePuzzle = new WirePuzzle();
    wirePuzzleScene.addGameObject(wirePuzzle);
    sceneManager.addScene(wirePuzzleScene);
    
    Scene paintingRoom = new Scene("paintingRoom", "8PR_Background.png");
    paintingRoom.addGameObject(new Draggable("Painting", 320, 280, 190, 236, "7PR_Painting.png"));
    paintingRoom.addGameObject(new Draggable("Plant", 100, 500, 212, 166, "6PR_Plant.png")); 
    paintingRoom.addGameObject(new Draggable("WallLight", 200, 180, 416, 434, "5PR_WallLight.png"));
    paintingRoom.addGameObject(new Draggable("BigCanvas", 600, 375, 243, 314, "4PR_BigCanvas.png"));
    paintingRoom.addGameObject(new Draggable("Canvas", 450, 500, 201, 161, "3PR_Canvas.png"));
    paintingRoom.addGameObject(new Draggable("Chair", 20, 540, 341, 230, "2PR_Chair.png"));
    paintingRoom.addGameObject(new Draggable("Lamp", 0, 700, 292, 426, "1PR_Lamp.png"));
    paintingRoom.addGameObject(new MoveToSceneObject("paintingRoom-to-hall", 350, 700, 50, 50, "arrowDown.png", "hall"));
    sceneManager.addScene(paintingRoom); 
    
    mainTheme.loop();
    println("Setup time: " + (millis() - startTime) + "ms!");
}

void draw() {
    sceneManager.getCurrentScene().draw(windowWidth, windowHeight);
    sceneManager.getCurrentScene().updateScene();
    inventoryManager.clearMarkedForDeathCollectables();
}

void mouseMoved() {
    sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {
    sceneManager.getCurrentScene().mouseClicked();
}

void mousePressed() {
    sceneManager.getCurrentScene().mousePressed();
}

void mouseReleased() {
    sceneManager.getCurrentScene().mouseReleased();
}

void mouseDragged() {
    sceneManager.getCurrentScene().mouseDragged();
}
