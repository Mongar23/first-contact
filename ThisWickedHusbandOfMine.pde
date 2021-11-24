final int windowWidth = 800;
final int windowHeight = windowWidth;

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();

void settings() {
    size(windowWidth, windowHeight);
}

void setup() {    
    Scene mainMenu = new Scene("mainMenu", "white1x1.png");
    GameObject startPainting = new GameObject("mainMenu_painting", 10, 25, 530, 750, "paintingNormal.jpg");
    startPainting.setHoverImage("paintingGhost.jpg");
    mainMenu.addGameObject(startPainting);
    mainMenu.addGameObject(new GameObject("mainMenu_logo", 570, 25, 200, 635, "logo.png"));
    MoveToSceneObject startButton = new MoveToSceneObject("startGame", 570, 685, 200, 90, "startButton_idle.png", "livingRoom");
    startButton.setHoverImage("startButton_selected.png");
    mainMenu.addGameObject(startButton);
    sceneManager.addScene(mainMenu);
    
    // --------------------------------------MAIN GAME--------------------------------------------------------------------------------------------------------
    Collectable hallKey = new Collectable("hallKey", "key.png");
    
    Scene livingRoom = new Scene("livingRoom", "10LR_Background.png");
  MoveToSceneObject livingRoomToHall = new MoveToSceneObject("livingRoom-to-hall", 50, 350, 50, 50, "arrowLeft.png", "hall");
  livingRoom.addGameObject(new RequireObject("toHallLock", 50, 350, 50, 50, "lock.png", "You need to find the key first!", hallKey, livingRoomToHall));
  livingRoom.addGameObject(new MoveToSceneObject("lingRoom-to-kitchen", 400, 50, 50, 50, "arrowUp.png", "reactionPuzzle"));
  livingRoom.addGameObject(new CollectableObject("hallKey", 200, 200, 50, 50, hallKey));
  livingRoom.addGameObject(new Draggable("Painting", 775, 300, 130, 206, "9LR_Painting.png"));
  livingRoom.addGameObject(new Draggable("Lamp", 550, 400, 195, 266, "8LR_Lamp.png"));
  livingRoom.addGameObject(new Draggable("LoungeChair", 440, 550, 250, 134, "7LR_LoungeChair.png"));
  livingRoom.addGameObject(new Draggable("Couch", 75, 570, 336, 133, "6LR_Couch.png"));
  livingRoom.addGameObject(new Draggable("Table", 575, 615, 187, 104, "5LR_Table.png"));
  livingRoom.addGameObject(new Draggable("Fan", 60, 530, 96, 206, "4LR_Fan.png"));
  livingRoom.addGameObject(new Draggable("Box", 670, 565, 87, 86, "3LR_Box.png"));
  livingRoom.addGameObject(new Draggable("Cigs", 640, 615, 58, 50, "2LR_Cigs.png"));
  livingRoom.addGameObject(new Draggable("LightFixture", 100, 0, 608, 470, "1LR_LightFixture.png"));
  sceneManager.addScene(livingRoom);
    
    Scene reactionPuzzleScene = new Scene("reactionPuzzle", "white1x1.png");
    ReactionPuzzle reactionPuzzle = new ReactionPuzzle();
    reactionPuzzleScene.addGameObject(reactionPuzzle);
    sceneManager.addScene(reactionPuzzleScene);
    
    Scene kitchen = new Scene("kitchen", "kitchen-TEMP.jpg");
    kitchen.addGameObject(new MoveToSceneObject("kitchen-to-livingRoom", 100, 700, 50, 50, "arrowDown.png","livingRoom"));
    kitchen.addGameObject(new MoveToSceneObject("kitchen-to-bedRoom", 650, 700, 50, 50, "arrowDown.png","sequencePuzzle"));
    sceneManager.addScene(kitchen);
    
    Scene sequencePuzzleScene = new Scene("sequencePuzzle", "white1x1.png");
    SequencePuzzle sequencePuzzle = new SequencePuzzle();
    sequencePuzzleScene.addGameObject(sequencePuzzle);
    sceneManager.addScene(sequencePuzzleScene);
    
    Scene bedRoom = new Scene("bedRoom", "bed-room-TEMP.jpg");
    bedRoom.addGameObject(new MoveToSceneObject("bedRoom-to-kitchen", 400, 50, 50, 50, "arrowUp.png","kitchen"));
    bedRoom.addGameObject(new MoveToSceneObject("bedRoom-to-bathRoom", 400, 700, 50, 50, "arrowDown.png","mirrorPuzzle"));
    sceneManager.addScene(bedRoom);
    
    Scene mirrorPuzzleScene = new Scene("mirrorPuzzle", "white1x1.png");
    MirrorPuzzle mirrorPuzzle = new MirrorPuzzle();
    mirrorPuzzleScene.addGameObject(mirrorPuzzle);
    sceneManager.addScene(mirrorPuzzleScene);
    
    Scene bathRoom = new Scene("bathRoom", "bath-room-TEMP.jpg");
    bathRoom.addGameObject(new MoveToSceneObject("bathRoom-to-bedRoom", 650, 50, 50, 50, "arrowUp.png","bedRoom"));
    bathRoom.addGameObject(new MoveToSceneObject("bathRoom-to-hall", 50, 350, 50, 50, "arrowLeft.png","hall"));
    sceneManager.addScene(bathRoom);
    
    Scene hall = new Scene("hall", "hall-TEMP.jpg");
    hall.addGameObject(new MoveToSceneObject("hall-to-bathRoom", 700, 700, 50, 50, "arrowRight.png","bathRoom"));
    hall.addGameObject(new MoveToSceneObject("hall-to-paintingRoom", 350, 50, 50, 50, "arrowUp.png","wirePuzzle"));
    sceneManager.addScene(hall);
    
    Scene wirePuzzleScene = new Scene("wirePuzzle", "white1x1.png");
    WirePuzzle wirePuzzle = new WirePuzzle();
    wirePuzzleScene.addGameObject(wirePuzzle);
    sceneManager.addScene(wirePuzzleScene);
    
    Scene paintingRoom = new Scene("paintingRoom", "8PR_Background.png");
    paintingRoom.addGameObject(new MoveToSceneObject("paintingRoom-to-hall", 350, 700, 50, 50, "arrowDown.png", "hall"));
    paintingRoom.addGameObject(new Draggable("Painting", 320, 280, 190, 236, "7PR_Painting.png"));
    paintingRoom.addGameObject(new Draggable("Plant", 100, 500, 212, 166, "6PR_Plant.png")); 
    paintingRoom.addGameObject(new Draggable("WallLight", 200, 180, 416, 434, "5PR_WallLight.png"));
    paintingRoom.addGameObject(new Draggable("BigCanvas", 600, 375, 243, 314, "4PR_BigCanvas.png"));
    paintingRoom.addGameObject(new Draggable("Canvas", 450, 500, 201, 161, "3PR_Canvas.png"));
    paintingRoom.addGameObject(new Draggable("Chair", 20, 540, 341, 230, "2PR_Chair.png"));
    paintingRoom.addGameObject(new Draggable("Lamp", 0, 700, 292, 426, "1PR_Lamp.png"));
    sceneManager.addScene(paintingRoom); 
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
