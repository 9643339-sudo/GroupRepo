class Boss {
  float x, y;
  float size = 120;
  float angle = 0;
  float floatRadius = 100;
  float floatSpeed = 0.02;

  int health = 250, maxHealth = 250;
  boolean alive = true;

  // NORMAL SHOOTING
  int shootTimer = 0;
  int shootInterval = 70;

  // METEOR RAIN ATTACK
  int rainTimer = 0;
  int rainInterval = 500;
  boolean raining = false;
  int rainTick = 0;
  int rainDuration = 450;
  int rainSpawnRate = 9;
  int maxRainMeteors = 15;
  int rainMeteorsSpawned = 0;

  // LAVA WAVE ATTACK
  int lavaTimer = 0;
  int lavaInterval = 350;
  ArrayList<LavaWave> lavaWaves;

  Boss(float x_, float y_) {
    x = x_;
    y = y_;
    lavaWaves = new ArrayList<LavaWave>();
  }

  void update(Player p) {
    if (!alive) return;

    // ==== BOSS MOVEMENT ====
    angle += floatSpeed;
    y = 150 + sin(angle) * floatRadius * 0.3;
    x += sin(angle * 0.5) * 1.2;

    // ==== NORMAL SHOOTING ====
    shootTimer++;
    if (shootTimer > shootInterval) {
      shootTimer = 0;
      meteors.add(new Meteor(x, y, p.x + p.size/2, p.y + p.size/2));
    }

    // ==== METEOR RAIN ====
    rainTimer++;
    if (!raining && rainTimer > rainInterval) {
      raining = true;
      rainTimer = 0;
      rainTick = 0;
      rainMeteorsSpawned = 0;
    }

    if (raining) {
      rainTick++;
      if (rainTick % rainSpawnRate == 0 &&
          rainMeteorsSpawned < maxRainMeteors) {

        float sx = random(width);
        float sy = -40;
        float tx = p.x + p.size/2;
        float ty = p.y + p.size/2;

        rainMeteors.add(new RainMeteor(sx, sy, tx, ty));
        rainMeteorsSpawned++;
      }
      if (rainTick > rainDuration) raining = false;
    }

    // ==== LAVA WAVE (HORIZONTAL ONLY) ====
    lavaTimer++;
    if (lavaTimer > lavaInterval) {
      lavaTimer = 0;

      // Random Y spawn lanes
      float sy;
      int lane = int(random(3));
      if (lane == 0) sy = 100;
      else if (lane == 1) sy = height/2;
      else sy = height - 150;

      float sx;
      if (p.x < width / 2) sx = -200;
      else sx = width + 200;

      lavaWaves.add(new LavaWave(sx, sy, true));
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
