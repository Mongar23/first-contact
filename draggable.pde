class Draggable extends GameObject {
    final int fallSpeed = 75;
    
    PVector offset;    
    
    boolean isBeingDragged = false;
    boolean hasBeenPickedup = false;
    
    public Draggable(String identifier, int x, int y, int objectWidth, int objectHeight) {
        this(identifier, x, y, objectWidth, objectHeight, "");
    }
    
    public Draggable(String identifier, int x, int y, int objectWidth, int objectHeight, String gameObjectImageFile) {
        super(identifier, x, y, objectWidth, objectHeight, gameObjectImageFile);
    }
    
    public void draw() {
        if (!isBeingDragged && hasBeenPickedup) {            
            y += fallSpeed;            
        }
        
        y = (int)constrain(y, 0, windowHeight - oheight);
        x = (int)constrain(x, 0, windowWidth - owidth);
        
        super.draw();
    }
    
    @Override 
    public void mousePressed() {
        if (!mouseIsHovering || mouseButton != LEFT) { return; }
        
        offset = new PVector(mouseX - x, mouseY - y);        
        
        isBeingDragged = true;
        hasBeenPickedup = true;
    }
    
    @Override 
    public void mouseReleased() {
        if (mouseButton != LEFT) { return; }
        
        isBeingDragged = false;
    }
    
    @Override 
    public void mouseDragged() {
        if (!isBeingDragged) { return; }
        
        x = (int)(mouseX - offset.x);
        y = (int)(mouseY - offset.y);
    }
}