 class ReilSword {
    float x, y, alpha;
    boolean hit = false;

    ReilSword(float x, float y) {
      this.x = x;
      this.y = y;
      alpha = 255;
    }

    void update() {
      alpha -= 5;
    }

    void display() {
      if (alpha > 0) {
        stroke(255, 255, 0, alpha);
        strokeWeight(4);
        line(x, y, x, y - 50);
      }
    }
  }
}
