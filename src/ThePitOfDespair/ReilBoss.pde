class ReilBoss {
  float x, y;
  int hp = 500;
  int phase = 1; // 1 = normal, 2 = enraged
  
  ReilBoss(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void update() {
    // Switch to phase 2
    if (hp < 250) phase = 2;
    
    // Floating movement
    y = 100 + sin(frameCount * 0.02) * 20;
    x = width/2 + sin(frameCount * (phase == 1 ? 0.01 : 0.02)) * 150;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    noStroke();
    if (phase == 1) {
      fill(255, 120, 180);
    } else {
      fill(255, 60, 80);
    }
    ellipse(0, 0, 80, 80);
    fill(255, 220, 250);
    triangle(-20, 10, 0, -40, 20, 10);
    popMatrix();
  }
  
  void attack(ArrayList<Star> stars, ArrayList<LightSword> swords) {
    if (phase == 1) {
      // Star rain (slower)
      if (frameCount % 30 == 0) {
        stars.add(new Star(random(width), 0, 4, 8));
      }
      // Sword every few seconds
      if (frameCount % 240 == 0) {
        swords.add(new LightSword(random(width)));
      }
    } else {
      // Phase 2: faster and denser attacks
      if (frameCount % 15 == 0) {
        stars.add(new Star(random(width), 0, 6, 12));
      }
      if (frameCount % 180 == 0) {
        swords.add(new LightSword(random(width)));
        swords.add(new LightSword(random(width)));
        swords.add(new LightSword(random(width)));
        swords.add(new LightSword(random(width)));
      }
    }
  }
  
  void damage(int amount) {
    hp -= amount;
    if (hp < 0) hp = 0;
  }
}
