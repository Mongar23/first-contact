class Timer {    
    int savedTime; // When Timer started
    int duration; // How long Timer should last
    
    Timer(float duration) {
        int toInt = (int)(duration * 1000);        
        this.duration = toInt;
    }
    
    //Starting the timer
    void start() {
        // When the timer starts it stores the current time in milliseconds.
        savedTime = millis();
    }
    
    boolean isFinished() { 
        int passedTime = millis() - savedTime;
        if (passedTime > duration) {
            return true;
        } else {
            return false;
        }
    }
}