class Player {
  float x, y;
  float size = 40;
  float speed = 4;
  int health = 100, maxHealth = 100;
  boolean alive = true;
  boolean up, down, left, right;
  
  Player(float x, float y) { this.x = x; this.y = y; }
  
  void update() {
    if (!alive) return;
    if (up) y -= speed;
    if (down) y += speed;
    if (left) x -= speed;
    if (right) x += speed;
    x = constrain(x, 0, width - size);
    y = constrain(y, 0, height - size);
  }
  
  void display() {
    fill(alive ? color(0, 200, 255) : color(100));
    noStroke();
    rect(x, y, size, size);
  }
  
  void keyPressed(char k) {
    if (!alive) return;
    if (k == 'w' || k == 'W') up = true;
    if (k == 's' || k == 'S') down = true;
    if (k == 'a' || k == 'A') left = true;
    if (k == 'd' || k == 'D') right = true;
    if (k == ' ') bullets.add(new Bullet(x + size/2, y));
  }
  
  void keyReleased(char k) {
    if (k == 'w' || k == 'W') up = false;
    if (k == 's' || k == 'S') down = false;
    if (k == 'a' || k == 'A') left = false;
    if (k == 'd' || k == 'D') right = false;
  }
  
  void takeDamage(int dmg) {
    health -= dmg;
    if (health <= 0) alive = false;
  }
}
