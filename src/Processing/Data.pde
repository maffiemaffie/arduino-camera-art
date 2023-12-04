import java.util.*;

// captures all 4 resistors at a moment in time
class Frame {
  int topLeft;
  int topRight;
  int bottomLeft;
  int bottomRight;
  
  Frame(int[] vals) {
    this.topLeft = vals[0];
    this.topRight = vals[1];
    this.bottomRight = vals[2];
    this.bottomLeft = vals[3];
  }
  
  public int getRight() {
    return this.topRight + this.bottomRight;
  }
  
  public int getLeft() {
    return this.topLeft + this.bottomLeft;
  }
  
  public int getTop() {
    return this.topRight + this.topLeft;
  }
  
  public int getBottom() {
    return this.bottomRight + this.bottomLeft;
  }
}

// holds a certain number of frames at a time
class FrameQueue {
  Frame frames[] = new Frame[4];
  
  FrameQueue() {
    for (int i = 0; i < this.frames.length; i++) {
      frames[i] = new Frame(new int[]{0, 0, 0, 0});
    }
  }
  
  // adds a frame
  public void add(Frame frame) {
    for (int i = 0; i < this.frames.length - 1; i++) {
      frames[i] = frames[i + 1];
    }
    
    frames[this.frames.length - 1] = frame;
  }
}
