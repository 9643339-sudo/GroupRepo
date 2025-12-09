class SquareMan {
  float x, y;
  float prevY;     // <— Track previous Y
  float w = 30, h = 30;

  float xVel = 0;
  float yVel = 0;

  float speed = 4;
  float gravity = 0.5;

  int col;

  SquareMan(float x, float y, int col) {
    this.x = x;
    this.y = y;
    this.prevY = y;
    this.col = col;
  }

  void update(ArrayList<Platform> platforms, float camY, boolean left, boolean right) {

    // Save previous Y before moving
    prevY = y;

    // Horizontal movement
    xVel = 0;
    if (left)  xVel = -speed;
    if (right) xVel = speed;

    x += xVel;
    x = constrain(x, 0, width - w);

    // Vertical movement
    yVel += gravity;
    y += yVel;

    // ------------ PROPER PLATFORM COLLISION -------------
    for (Platform p : platforms) {

      boolean overlapX =
        x + w > p.x &&
        x < p.x + p.w;

      boolean crossedFromAbove =
        prevY + h <= p.y &&    // last frame above platform
        y + h >= p.y &&        // now passed the platform top
        yVel > 0;              // must be falling

      if (overlapX && crossedFromAbove) {
        y = p.y - h;  // snap to platform
        yVel = 0;     // stop falling
      }
    }
  }

  void jump() {
    if (yVel == 0) yVel = -12;
  }

  void display() {
    fill(col);
    rect(x, y, w, h);
  }
}
