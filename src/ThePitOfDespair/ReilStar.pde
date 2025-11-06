 class ReilStar {
    float x, y, speed;

    ReilStar(float x, float y) {
      this.x = x;
      this.y = y;
      speed = random(2, 5);
    }

    void update() {
      y += speed;
      if (y > height) {
        y = random(-100, 0);
        x = random(width);
      }
    }

    void display() {
      stroke(255);
      strokeWeight(2);
      point(x, y);
    }
  }
