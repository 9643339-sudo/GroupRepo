class Boss {
  float x, y;
  float size = 120;               // hitbox size
  float displaySizePhase1 = 180;  // image size phase 1
  float displaySizePhase2 = 220;  // image size phase 2
  float angle = 0;
  float floatRadius = 100;
  float floatSpeed = 0.02;

  int health = 250, maxHealth = 250;
  boolean alive = true;
  boolean phaseTwo = false;

  int shootTimer = 0;
  int shootInterval = 70;

  int rainTimer = 0;
  int rainInterval = 500;
  boolean raining = false;
  int rainTick = 0;
  int rainDuration = 450;
  int rainSpawnRate = 10;
  int maxRainMeteors = 15;
  int rainMeteorsSpawned = 0;

  int lavaTimer = 0;
  int lavaInterval = 350;
  ArrayList<LavaWave> lavaWaves;

  PImage sprite;    // phase 1
  PImage sprite2;   // phase 2

  Boss(float x, float y, PImage sprite, PImage sprite2) {
    this.x = x;
    this.y = y;
    this.sprite = sprite;
    this.sprite2 = sprite2;
    lavaWaves = new ArrayList<LavaWave>();
  }

  void update(Player p) {
    if (!alive) return;

    if (health <= 0 && !phaseTwo) {
      phaseTwo = true;
      health = maxHealth / 2;
      alive = true;

      floatSpeed *= 2;
      shootInterval = 30;
      maxRainMeteors = 999999999;
      rainInterval = 0;
      lavaInterval = 100;
      rainSpawnRate = 14;
      rainDuration = 999999999;
    }

    if (phaseTwo && health <= 0) {
      alive = false;
      return;
    }

    angle += floatSpeed;
    y = 150 + sin(angle) * floatRadius * 0.3;
    x += sin(angle * 0.5) * 1.2;

    shootTimer++;
    if (shootTimer > shootInterval) {
      shootTimer = 0;
      meteors.add(new Meteor(x, y, p.x + p.size/2, p.y + p.size/2));
    }

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

    lavaTimer++;
    if (lavaTimer > lavaInterval) {
      lavaTimer = 0;

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

    imageMode(CENTER);
    if (!phaseTwo && sprite != null) {
      image(sprite, x, y, displaySizePhase1, displaySizePhase1);
    } else if (phaseTwo && sprite2 != null) {
      image(sprite2, x, y, displaySizePhase2, displaySizePhase2);
    }
  }

  void takeDamage(int dmg) {
    if (!alive) return;

    health -= dmg;

    if (!phaseTwo && health <= 0) {
      health = 0;
    }
  }
}
