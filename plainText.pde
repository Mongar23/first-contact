class PlainText extends GameObject {
    private String content;
    
    PlainText(String identifier, String content, int x, int y) {
        super(identifier, x, y, 0, 0);
        this.content = content;
    }
    
    @Override
    void draw() {
        text(content, x, y);
    }
}