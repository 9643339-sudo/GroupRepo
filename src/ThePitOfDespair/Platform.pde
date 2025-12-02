class Platform {
  int x, y, w, h;
  float xVel; // Horizontal velocity for movement
  color c;

  // Constructor
  Platform(int x, int y, int w, int h, float xVel) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.xVel = xVel;
    c = color(100, 100, 100);
  }

  // Update platform position
  void update() {
    x += xVel;
    
    // Loop across screen
    if (xVel > 0) { // Moving right
      if (x - w/2 > width) {
        x = -w/2; // Reappear on left
      }
    } else { // Moving left
      if (x + w/2 < 0) {
        x = width + w/2; // Reappear on right
      }
    }
  }

  // Display the platform
  void display() {
    fill(c);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}
