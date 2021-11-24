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
    
    Scene livingRoom = new Scene("livingRoom", "living-room-TEMP.jpg");
    MoveToSceneObject livingRoomToHall = new MoveToSceneObject("livingRoom-to-hall", 50, 350, 50, 50, "arrowLeft.png","hall");
    livingRoom.addGameObject(new RequireObject("toHallLock", 50, 350, 50, 50, "lock.png", "You need to find the key first!", hallKey, livingRoomToHall));
    livingRoom.addGameObject(new MoveToSceneObject("lingRoom-to-kitchen", 400, 50, 50, 50, "arrowUp.png", "reactionPuzzle"));
    livingRoom.addGameObject(new CollectableObject("hallKey", 200, 200, 50, 50, hallKey));
    livingRoom.addGameObject(new Draggable("draggable0", 200, 200, 75, 75, "gameObject.png"));
    livingRoom.addGameObject(new Draggable("draggable1", 600, 600, 75, 75, "gameObject.png"));
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
    hall.addGameObject(new MoveToSceneObject("hall-to-paintingRoom", 350, 50, 50, 50, "arrowUp.png","paintingRoom"));
    sceneManager.addScene(hall);
    
    Scene paintingRoom = new Scene("paintingRoom", "painting-room-TEMP.jpg");
    paintingRoom.addGameObject(new MoveToSceneObject("paintingRoom-to-hall", 350, 700, 50, 50, "arrowDown.png", "hall"));
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
