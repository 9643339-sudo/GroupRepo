class ReilBoss {
  float x, y;
  int hp = 500;
  int phase = 1; // 1 = normal, 2 = enraged

  PImage reil1; // Normal phase sprite
  PImage reil2; // Enraged phase sprite

  ReilBoss(float x, float y, PImage reil1, PImage reil2) {
    this.x = x;
    this.y = y;
    this.reil1 = reil1;
    this.reil2 = reil2;
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
    imageMode(CENTER);

    // Draw different sprite per phase
    if (phase == 1) {
      reil1.resize(200,200);
      image(reil1, 0, 0);
    } else {
      reil2.resize(250,250);
      image(reil2, 0, 0);
    }

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
        for (int i = 0; i < 12; i++) {
          swords.add(new LightSword(random(width)));
          
        }
      }
    }
  }

  void damage(int amount) {
    hp -= amount;
    if (hp < 0) hp = 0;
  }
}
