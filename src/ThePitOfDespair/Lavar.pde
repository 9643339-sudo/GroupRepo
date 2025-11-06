class Lavar {
  int x, y, w, h;
  int health;
  int attackCooldown;
  
  Lavar(int startX, int startY) {
    x = startX;
    y = startY;
    w = 80;
    h = 80;
    health = 500;
    attackCooldown = 0;
  }
  
  void display() {
    fill(255, 0, 0);
    rect(x, y, w, h);
    
    // health bar
    fill(0);
    rect(x, y - 10, w, 5);
    fill(0, 255, 0);
    rect(x, y - 10, map(health, 0, 500, 0, w), 5);
  }
  
  void update() {
    // You can make the boss move or animate here
    // Example: simple horizontal movement
    x += sin(frameCount * 0.05) * 2;
    
    // Count down attack timer
    if (attackCooldown > 0) {
      attackCooldown--;
    }
  }
  
  void attack(Player player) {
    if (attackCooldown == 0) {
      // Example: boss shoots a projectile or damages the player
      println("Lavar attacks!");
      player.health -= 10;
      attackCooldown = 60; // 1 second cooldown at 60 FPS
    }
  }
  
  boolean isDead() {
    return health <= 0;
  }
}
