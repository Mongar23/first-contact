class VideoObject extends GameObject {    
    public Movie movie;
    
    VideoObject(String identifier, Movie movie, int x, int y) {
        super(identifier, x, y, 0, 0);
        this.movie = movie;
    }
    
    @Override
    void draw() {
        image(movie, x, y);
    }
}