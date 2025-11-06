// ==== PLAYER ====
class Player {
  float x, y;
  int w = 40, h = 40;
  int health;
  float speed = 4; // instant speed, no acceleration

  boolean attacking = false;
  int attackTimer = 0;
  String facing = "down"; // up, down, left, right

  Player(float startX, float startY) {
    x = startX;
    y = startY;
    health = 100;
  }

  void update() {
    // Normal, instant WASD movement
    if (keyPressed) {
      if (key == 'a' || key == 'A') { x -= speed; facing = "left"; }
      if (key == 'd' || key == 'D') { x += speed; facing = "right"; }
      if (key == 'w' || key == 'W') { y -= speed; facing = "up"; }
      if (key == 's' || key == 'S') { y += speed; facing = "down"; }
    }

    x = constrain(x, 0, width - w);
    y = constrain(y, 0, height - h);

    // Attack timer
    if (attacking) {
      attackTimer--;
      if (attackTimer <= 0) attacking = false;
    }
  }

  void display() {
    fill(0, 0, 255);
    rect(x, y, w, h);

    // Show sword hitbox
    if (attacking) {
      fill(100, 200, 255, 150);
      float ax = x, ay = y, aw = 30, ah = 20;
      if (facing.equals("right")) {
        ax = x + w; ay = y + 10; aw = 30; ah = 20;
      } else if (facing.equals("left")) {
        ax = x - 30; ay = y + 10; aw = 30; ah = 20;
      } else if (facing.equals("up")) {
        ax = x + 10; ay = y - 30; aw = 20; ah = 30;
      } else if (facing.equals("down")) {
        ax = x + 10; ay = y + h; aw = 20; ah = 30;
      }
      rect(ax, ay, aw, ah);
    }
  }

  void attack() {
    if (!attacking) {
      attacking = true;
      attackTimer = 15;
    }
  }

  boolean attackHitboxOverlaps(Lavar b) {
    if (!attacking) return false;
    float ax = 0, ay = 0, aw = 0, ah = 0;
    if (facing.equals("right")) {
      ax = x + w; ay = y + 10; aw = 30; ah = 20;
    } else if (facing.equals("left")) {
      ax = x - 30; ay = y + 10; aw = 30; ah = 20;
    } else if (facing.equals("up")) {
      ax = x + 10; ay = y - 30; aw = 20; ah = 30;
    } else if (facing.equals("down")) {
      ax = x + 10; ay = y + h; aw = 20; ah = 30;
    }
    return (ax < b.x + b.w && ax + aw > b.x && ay < b.y + b.h && ay + ah > b.y);
  }

  void takeDamage(int dmg) {
    health -= dmg;
  }
}
