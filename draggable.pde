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
        
        x = (int)constrain(x, 0 - (owidth * 0.9f), windowWidth - (owidth * 0.1f));
        y = (int)constrain(y, 0 - (oheight * 0.9f), isBeingDragged ? windowHeight - (oheight * 0.1f) : windowHeight - oheight);
        
        super.draw();
    }
    
    @Override 
    public void mousePressed() {
        if (mouseButton == RIGHT && isBeingDragged) {
            println("x: " + x + ", y: " + y);
            return;
        }
        
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