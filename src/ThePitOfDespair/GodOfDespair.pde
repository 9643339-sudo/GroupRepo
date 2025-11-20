//Noah Norton
Player player;
Boss boss;
ArrayList<Star> stars;
ArrayList<Bullet> bullets;
ArrayList<Beam> beams;        
ArrayList<HBeam> hBeams;      
ArrayList<BurstStar> burstStars;

PImage GOD;
PImage GOD3;
PImage BGROUND;

// ========= DAMAGE FLASH =========
int playerHitFlash = 0; // frames left to flash
int flashDuration = 8;  // flash duration in frames

void setup() {
  size(500, 500);
  GOD = loadImage("GOD.png");
  GOD3 = loadImage("GOD3.png");
  BGROUND = loadImage("BGROUND.png");

  player = new Player(width/2, height - 80);
  boss = new Boss(width/2, 250, GOD, GOD3);
  stars = new ArrayList<Star>();
  bullets = new ArrayList<Bullet>();
  beams = new ArrayList<Beam>();
  hBeams = new ArrayList<HBeam>();
  burstStars = new ArrayList<BurstStar>();
}

void draw() {
  background(0);
  image(BGROUND, 250, 250, width, height);

  // ====== DAMAGE FLASH OVERLAY ======
  if (playerHitFlash > 0) {
    fill(255, 0, 0, 80);
    rect(0, 0, width, height);
    playerHitFlash--;
  }

  player.update();
  boss.update(player);

  // Player bullets
  for (int i = bullets.size()-1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    b.display();
    if (b.offscreen()) bullets.remove(i);
    else if (boss.alive && b.hits(boss)) {
      boss.takeDamage(5);
      bullets.remove(i);
    }
  }

  // Boss stars
  for (int i = stars.size()-1; i >= 0; i--) {
    Star s = stars.get(i);
    s.update();
    s.display();
    if (s.offscreen()) stars.remove(i);
    else if (s.hits(player)) {
      player.takeDamage(8);
      playerHitFlash = flashDuration; // trigger flash on hit
      stars.remove(i);
    }
  }

  // Vertical beams
  for (int i = beams.size()-1; i >= 0; i--) {
    Beam beam = beams.get(i);
    beam.update();
    beam.display();
    if (beam.active && beam.hits(player)) {
      player.takeDamage(1);
      playerHitFlash = flashDuration;
    }
    if (beam.finished()) beams.remove(i);
  }

  // Horizontal beams
  for (int i = hBeams.size()-1; i >= 0; i--) {
    HBeam hb = hBeams.get(i);
    hb.update();
    hb.display();
    if (hb.active && hb.hits(player)) {
      player.takeDamage(1);
      playerHitFlash = flashDuration;
    }
    if (hb.finished()) hBeams.remove(i);
  }

  // Burst stars
  for (int i = burstStars.size()-1; i >= 0; i--) {
    BurstStar bs = burstStars.get(i);
    bs.update();
    bs.display();
    if (bs.offscreen()) burstStars.remove(i);
    else if (bs.hits(player)) {
      player.takeDamage(10);
      playerHitFlash = flashDuration;
      burstStars.remove(i);
    }
  }

  // ====== DISPLAY ======
  // Optionally tint player red if hit
  if (playerHitFlash > 0) {
    tint(255, 150, 150);
  } else {
    noTint();
  }
  player.display();
  boss.display();
  drawHealthBars();

  // ====== SIDE WALL DAMAGE + RED GLOW ======
  applySidePunishmentAndGlow();

  // ====== END STATES ======
  if (!player.alive) {
    fill(255, 50, 50);
    textAlign(CENTER, CENTER);
    textSize(48);
    text("YOU HAVE PERISHED", width/2, height/2);
    noLoop();
  }
  if (!boss.alive) {
    fill(255, 255, 100);
    textAlign(CENTER, CENTER);
    textSize(48);
    text("YOU WON!", width/2, height/2);
    noLoop();
  }
}

void keyPressed() { player.keyPressed(key); }
void keyReleased() { player.keyReleased(key); }


// ========================================================
//  SIDE DAMAGE + RED WALL GLOW EFFECT
// ========================================================
void applySidePunishmentAndGlow() {
  float dangerZone = 60;      // distance from walls where they start glowing
  int damageRate = 20;        // frames between damage ticks
  int damageAmount = 2;       // damage per tick

  boolean nearLeft  = player.x < dangerZone;
  boolean nearRight = player.x + player.size > width - dangerZone;

  float glowStrengthLeft  = 0;
  float glowStrengthRight = 0;

  // Calculate glow alpha based on closeness
  if (nearLeft) {
    glowStrengthLeft = map(player.x, dangerZone, 0, 0, 200);
  }
  if (nearRight) {
    float px = player.x + player.size;
    glowStrengthRight = map(px, width - dangerZone, width, 0, 200);
  }

  // LEFT WALL GLOW
  if (glowStrengthLeft > 0) {
    noStroke();
    for (int i = 0; i < 50; i++) {
      fill(255, 0, 0, glowStrengthLeft * (1 - i / 50.0));
      rect(0, 0, 10 + i*4, height);
    }
  }

  // RIGHT WALL GLOW
  if (glowStrengthRight > 0) {
    noStroke();
    for (int i = 0; i < 50; i++) {
      fill(255, 0, 0, glowStrengthRight * (1 - i / 50.0));
      rect(width - (10 + i*4), 0, 10 + i*4, height);
    }
  }

  // DAMAGE PLAYER IF TOO CLOSE
  if (nearLeft || nearRight) {
    if (frameCount % damageRate == 0) {
      player.takeDamage(damageAmount);
      playerHitFlash = flashDuration;
    }
  }
}


// ========================================================
//        HEALTH BARS
// ========================================================
void drawHealthBars() {
  fill(0, 200, 255);
  rect(20, height - 30, map(player.health, 0, player.maxHealth, 0, 200), 15);
  noFill();
  stroke(255);
  rect(20, height - 30, 200, 15);
  noStroke();
  fill(255);
  text("PLAYER", 20, height - 40);

  fill(220, 150, 0);
  rect(width - 450, 15, map(boss.health, 0, boss.maxHealth, 0, 400), 15);
  noFill();
  stroke(255);
  rect(width - 450, 15, 400, 15);
  noStroke();
  fill(255);
  text("God of Despair", width - 280, 15);
}

