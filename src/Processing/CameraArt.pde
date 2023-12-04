import processing.serial.*;

Serial myPort;
static String val;
int sensorVals[] = {0, 0, 0, 0};
FrameQueue queue = new FrameQueue();
Display display;

void setup() {
 size(800, 800);
 background(0);

 display = new Display();
 
 myPort = new Serial(this, Serial.list()[2], 9600);
 stroke(255);
}

void draw() {
  float forceX = 0;
  float forceY = 0;
  
  if ( myPort.available() > 0) {
    val = myPort.readStringUntil('\n');
    if (val == null) return;
    try {
      String[] rawVals = val.split(",");
      for (int i = 0; i < sensorVals.length; i++) {
        sensorVals[i] = Integer.valueOf(rawVals[i].trim());
      }
      queue.add(new Frame(sensorVals));
    } catch (Exception e) {
      
    }
  
    DifferencePair diff = getMotion(queue.frames);
    
    forceX += diff.horizontal;
    forceY += diff.vertical;
  }
  
  //float[] force = fakeForce();
  
  //forceX = force[0];
  //forceY = force[1];
  
  display.update(forceX * 4, forceY * 4);
  display.render();
}

// for simulating arduino data
float[] fakeForce() {
  int interval = 40;
  
  int step = (frameCount / interval) % 8;
  
  int strength = 20;
  
  switch(step) {
    case 0:
      return new float[]{-strength, 0};
    case 2:
      return new float[]{0, -strength};
    case 4:
      return new float[]{strength, 0};
    case 6:
      return new float[]{0, strength};
    default:
      return new float[]{0, 0};
  }
}
