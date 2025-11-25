class ReilBoss {
  float x, y;
  int health = 500, maxHealth = 500;

  int phase = 1;   // 1 = normal, 2 = enraged, 3 = final wrath
  PImage reil1, reil2, reil3;  

  int spiralTimer = 0;

  ReilBoss(float x, float y, PImage reil1, PImage reil2, PImage reil3) {
    this.x = x;
    this.y = y;
    this.reil1 = reil1;
    this.reil2 = reil2;
    this.reil3 = reil3;   
  }

  void update() {
    if (health < maxHealth * 0.30)      phase = 3;
    else if (health < maxHealth * 0.70) phase = 2;
    else                                phase = 1;

    if (phase == 1) {
      y = 100 + sin(frameCount * 0.02) * 20;
      x = width/2 + sin(frameCount * 0.01) * 150;

    } else if (phase == 2) {
      y = 100 + sin(frameCount * 0.04) * 25;
      x = width/2 + sin(frameCount * 0.02) * 200;

    } else {
      y = 100 + sin(frameCount * 0.08) * 35;
      x = width/2 + sin(frameCount * 0.05 + random(-0.05, 0.05)) * 250;
    }
  }

  void display() {
    pushMatrix();
    translate(x, y);
    imageMode(CENTER);

    if (phase == 1) {
      reil1.resize(200, 200);
      image(reil1, 0, 0);
    } 
    else if (phase == 2) {
      reil2.resize(250, 250);
      image(reil2, 0, 0);
    } 
    else {
      // --- Phase 3: Use reil3 sprite ---
      pushStyle();
      tint(255, 50, 50); // optional red glow
      reil3.resize(300, 300);
      image(reil3, 0, 0);
      popStyle();
    }

    popMatrix();

    drawHealthBar();
  }

  void drawHealthBar() {
    float barWidth = 350;
    float barHeight = 20;

    float filled = map(health, 0, maxHealth, 0, barWidth);

    float bx = x - barWidth/2;
    float by = y - (phase == 1 ? 160 : phase == 2 ? 180 : 200);

    noStroke();
    fill(50, 50, 70, 160);
    rect(bx, by, barWidth, barHeight);

    if (phase == 1) fill(0, 180, 255);
    else if (phase == 2) fill(255, 150, 60);
    else fill(255, 40, 40);

    rect(bx, by, filled, barHeight);

    noFill();
    stroke(255);
    rect(bx, by, barWidth, barHeight);
  }

  void attack(ArrayList<Star> stars, ArrayList<LightSword> swords) {

    if (phase == 1) {
      if (frameCount % 30 == 0)
        stars.add(new Star(random(width), 0, 4, 8));

      if (frameCount % 240 == 0)
        swords.add(new LightSword(random(width)));
    }

    else if (phase == 2) {
      if (frameCount % 15 == 0)
        stars.add(new Star(random(width), 0, 6, 12));

      if (frameCount % 180 == 0)
        for (int i = 0; i < 12; i++)
          swords.add(new LightSword(random(width)));
    }

    else {
      if (frameCount % 8 == 0)
        stars.add(new Star(random(width), 0, 8, 14));

      if (frameCount % 120 == 0)
        for (int i = 0; i < 8; i++)
          swords.add(new LightSword(i * width/8));

      spiralTimer++;
      if (spiralTimer % 5 == 0) {
        float angle = spiralTimer * 0.25;
        float rx = x + cos(angle) * 50;
        float ry = y + sin(angle) * 50;
        stars.add(new Star(rx, ry, 7, 14));
      }
    }
  }

  void damage(int amount) {
    health -= amount;
    if (health < 0) health = 0;
  }
}
