class Star {
  float x, y;
  float speed;
  float size;
  
  Star(float x, float y, float minSpeed, float maxSpeed) {
    this.x = x;
    this.y = y;
    this.speed = random(minSpeed, maxSpeed);
    this.size = random(10, 20);
  }
  
  void update() {
    y += speed;
  }
  
  void display() {
    noStroke();
    fill(255, 240, 150);
    ellipse(x, y, size, size);
  }
  
  boolean hits(Player p) {
    return dist(x, y, p.x, p.y) < (p.size/2 + size/2);
  }
  
  boolean offscreen() {
    return y > height + size;
  }
}
