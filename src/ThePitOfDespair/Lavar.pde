Player player;
Boss boss;

ArrayList<Bullet> bullets;
ArrayList<Meteor> meteors;
ArrayList<RainMeteor> rainMeteors;

void setup() {
  size(800, 600);
  player = new Player(width/2, height - 80);
  boss = new Boss(width/2, 150);

  bullets = new ArrayList<Bullet>();
  meteors = new ArrayList<Meteor>();
  rainMeteors = new ArrayList<RainMeteor>();
}

void draw() {
  background(20, 20, 30);

  player.update();
  boss.update(player);

  // ==== NORMAL METEORS ====
  for (int i = meteors.size()-1; i >= 0; i--) {
    Meteor m = meteors.get(i);
    m.update();
    m.display();

    if (m.hits(player)) {
      player.takeDamage(5);
      meteors.remove(i);
      continue;
    }

    if (m.offscreen()) {
      meteors.remove(i);
    }
  }

  // ==== RAIN METEORS ====
  for (int i = rainMeteors.size()-1; i >= 0; i--) {
    RainMeteor rm = rainMeteors.get(i);
    rm.update();
    rm.display();

    if (rm.hits(player)) {
      player.takeDamage(8);
    }

    if (rm.offscreen() || rm.damaged) {
      rainMeteors.remove(i);
    }
  }

  // ==== LAVA WAVES ====
  for (int i = boss.lavaWaves.size()-1; i >= 0; i--) {
    LavaWave lw = boss.lavaWaves.get(i);
    lw.update();
    lw.display();

    if (lw.hits(player)) {
      player.takeDamage(10);
    }

    if (lw.offscreen() || lw.destroyed) {
      boss.lavaWaves.remove(i);
    }
  }

  // ==== PLAYER BULLETS ====
  for (int i = bullets.size()-1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    b.display();

    if (b.offscreen()) {
      bullets.remove(i);
    } else if (boss.alive && b.hits(boss)) {
      boss.takeDamage(2);
      bullets.remove(i);
    }
  }

  player.display();
  boss.display();
  drawHealthBars();

  if (!player.alive) {
    fill(255, 50, 50);
    textAlign(CENTER, CENTER);
    textSize(48);
    text("YOU DIED", width/2, height/2);
    noLoop();
  }

  if (!boss.alive) {
    fill(255, 255, 100);
    textAlign(CENTER, CENTER);
    textSize(48);
    text("YOU WIN!", width/2, height/2);
    noLoop();
  }
}

void keyPressed() { player.keyPressed(key); }
void keyReleased() { player.keyReleased(key); }

void drawHealthBars() {
  fill(0, 200, 255);
  rect(20, height - 30, map(player.health, 0, player.maxHealth, 0, 200), 15);
  noFill(); stroke(255); rect(20, height - 30, 200, 15);
  noStroke(); fill(255); text("PLAYER", 20, height - 40);

  fill(255, 50, 50);
  rect(width - 220, 20, map(boss.health, 0, boss.maxHealth, 0, 200), 15);
  noFill(); stroke(255); rect(width - 220, 20, 200, 15);
  noStroke(); fill(255); text("Lavar", width - 80, 15);
}
