// store the horizontal and vertical motion
class DifferencePair {
  float horizontal;
  float vertical;
  
  public String toString() {
    return "horizontal: " + horizontal + " vertical: " + vertical; 
  }
}

// get the horizontal motion over time
float getHorizontal(Frame frames[]) {
  float difference = 0;
  
  for (int i = 1; i < frames.length; i++) {
    float thisBias = frames[i].getRight() - frames[i].getLeft();
    float prevBias = frames[i - 1].getRight() - frames[i - 1].getLeft();
    
    difference += thisBias - prevBias;
  }
  return difference / frames.length;
}

// get the vertical motion over time
float getVertical(Frame frames[]) {
  float difference = 0;
  
  for (int i = 1; i < frames.length; i++) {
    float thisBias = frames[i].getTop() - frames[i].getBottom();
    float prevBias = frames[i - 1].getTop() - frames[i - 1].getBottom();
    
    difference += thisBias - prevBias;
  }
  return difference / frames.length;
}

// get the motion over time
DifferencePair getMotion(Frame frames[]) {
  DifferencePair difference = new DifferencePair();
  difference.horizontal = getHorizontal(frames);
  difference.vertical = getVertical(frames);
  
  return difference;
}
