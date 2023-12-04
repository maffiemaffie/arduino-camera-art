// for the visual component
class Display { 
  Point points[][];
  
  Display() {
    stroke(255);
    strokeWeight(20);
    colorMode(HSB);
    ellipseMode(CENTER);
    
    this.points = new Point[20][20];
    
    for (int row = 0; row < this.points.length; row++) {
      for (int col = 0; col < this.points[0].length; col++) {
        float x = width / this.points[0].length * col;
        float y = height / this.points.length * row;
        this.points[row][col] = new Point(x, y);
      }
    }
  }
  
  // step the physics
  void update(float forceX, float forceY) {
    for (int row = 0; row < this.points.length; row++) {
      for (int col = 0; col < this.points[0].length; col++) {
        Point thisPoint = this.points[row][col];
        
        thisPoint.applyForceAt(forceX * 50, forceY * 50,
          //map(cos(frameCount * 0.1), -1, 1, 0, width),
          //map(sin(frameCount * 0.1), -1, 1, 0, height)
          width * 0.5, height * 0.5
        );
        thisPoint.update(0.5); 
        thisPoint.returnToInitialPosition(0.1);
      }
    }
  }
  
  // render the art
  void render() {
    background(0);
    
    for (int row = 0; row < this.points.length; row++) {
      for (int col = 0; col < this.points[0].length; col++) {
        Point thisPoint = this.points[row][col];
        float speed = sqrt(pow(thisPoint.vx, 2) + pow(thisPoint.vy, 2));
        stroke(80 + speed * 5, 255, 50 + speed * 15);
        
        float xNoise = noise(0.1 * frameCount, thisPoint.x * 0.025, thisPoint.y * 0.025);
        float yNoise = noise(0.1 * frameCount + 100, thisPoint.x * 0.025, thisPoint.y * 0.025);
        
        point(
          thisPoint.x + map(xNoise, 0, 1, -speed * 0.75, speed * 0.75), 
          thisPoint.y + map(yNoise, 0, 1, -speed * 0.75, speed * 0.75)
        );
      }
    }
  }
}

// an individual point
class Point {
  float x0;
  float y0;
  
  float x;
  float y;
  
  float vx;
  float vy;
  
  float ax;
  float ay;
  
  Point(float x, float y) {
    this.x = this.x0 = x;
    this.y = this.y0 = y;
  }
  
  // spring back to initial
  void returnToInitialPosition(float factor) {
    // this.ax += factor * (this.x0 - this.x);
    // this.ay += factor * (this.y0 - this.y);
    this.x = factor * this.x0 + (1 - factor) * this.x;
    this.y = factor * this.y0 + (1 - factor) * this.y;
  }
  
  // step the physics
  void update(float step) {
    this.x += this.vx * step;
    this.y += this.vy * step;
    
    this.vx += this.ax * step;
    this.vy += this.ay * step;
    
    this.vx *= 0.95;
    this.vy *= 0.95;
    
    this.ax = 0;
    this.ay = 0;
  }
  
  // apply a force to all the points
  void applyForce(float x, float y) {
    this.ax += x;
    this.ay += y;
  }
  
  // apply a force that falls off from a location
  void applyForceAt(float fx, float fy, float atx, float aty) {
    this.ax += fx / (abs(5 * dist(this.x, this.y, atx, aty)) + 1);
    this.ay += fy / (abs(5 * dist(this.x, this.y, atx, aty)) + 1);
  }
}
