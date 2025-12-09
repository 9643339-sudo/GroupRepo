class Platform {
  float x, y, w, h, xVel;

  Platform(float x, float y, float w, float h, float xVel) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.xVel = xVel;
  }

  void update() {
    x += xVel;

    // Bounce off screen edges
    if (x < 0 || x + w > width) {
      xVel *= -1;
    }
  }

  void display() {
    fill(0);
    rect(x, y, w, h);
  }
}
