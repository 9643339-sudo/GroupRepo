class Boss {
  float x, y;
  float size = 120;
  float angle = 0;
  float floatRadius = 100;
  float floatSpeed = 0.02;
  
  int health = 400, maxHealth = 400;
  boolean alive = true;
  
  int shootTimer = 0;
  int shootInterval = 60;
  int lavaTimer = 0;
  int lavaInterval = 300;
  int hLavaTimer = 0;
  int hLavaInterval = 500;
  
  Boss(float x_, float y_) {
    x = x_;
    y = y_;
  }
  
  void update(Player p) {
    if (!alive) return;
    angle += floatSpeed;
    y = 150 + sin(angle) * floatRadius * 0.3;
    x += sin(angle * 0.5) * 1.2;
    
    shootTimer++;
    if (shootTimer > shootInterval) {
      shootTimer = 0;
      meteors.add(new Meteor(x, y, p.x + p.size/2, p.y + p.size/2));
    }
    
    lavaTimer++;
    if (lavaTimer > lavaInterval) {
      lavaTimer = 0;
      spawnVerticalLavas();
    }
    
    hLavaTimer++;
    if (hLavaTimer > hLavaInterval) {
      hLavaTimer = 0;
      spawnHorizontalLavas();
    }
    
    if (dist(x, y, p.x + p.size/2, p.y + p.size/2) < (size/2 + p.size/2))
      p.takeDamage(20);
  }
  
  void spawnVerticalLavas() {
    int lavaCount = 5;
    for (int i = 0; i < lavaCount; i++) {
      float bx = random(50, width - 50);
      lavas.add(new LavaV(bx));
    }
  }
  
  void spawnHorizontalLavas() {
    int lavaCount = 3;
    for (int i = 0; i < lavaCount; i++) {
      float by = random(50, height - 50);
      hLava.add(new LavaH(by));
    }
  }
  
  void display() {
    if (!alive) return;
    fill(255, 0, 0);
    noStroke();
    ellipse(x, y, size, size);
  }
  
  void takeDamage(int dmg) {
    health -= dmg;
    if (health <= 0) alive = false;
  }
}
