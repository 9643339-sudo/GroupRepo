Player player;
ReilBoss reil;
ArrayList<Star> stars;
ArrayList<LightSword> swords;
ArrayList<Bullet> bullets;

boolean gameOver = false;
boolean playerWon = false;

void setup() {
  size(800, 600);
  player = new Player(width/2, height - 60);
  reil = new ReilBoss(width/2, 100);
  stars = new ArrayList<Star>();
  swords = new ArrayList<LightSword>();
  bullets = new ArrayList<Bullet>();
}

void draw() {
  background(10, 10, 25);
  drawBackgroundStars();
  
  if (!gameOver) {
    reil.update();
    reil.display();
    reil.attack(stars, swords);

    // Update bullets
    for (int i = bullets.size()-1; i >= 0; i--) {
      Bullet b = bullets.get(i);
      b.update();
      b.display();
      if (b.offscreen()) {
        bullets.remove(i);
      } else if (b.hits(reil)) {
        reil.damage(10);
        bullets.remove(i);
      }
    }

    // Update stars
    for (int i = stars.size()-1; i >= 0; i--) {
      Star s = stars.get(i);
      s.update();
      s.display();
      if (s.hits(player)) {
        player.damage(10);
        stars.remove(i);
      } else if (s.offscreen()) {
        stars.remove(i);
      }
    }

    // Update swords
    for (int i = swords.size()-1; i >= 0; i--) {
      LightSword l = swords.get(i);
      l.update();
      l.display();
      if (l.hits(player)) {
        player.damage(25);
      }
      if (l.finished()) swords.remove(i);
    }

    // Player
    player.update();
    player.display();

    // UI
    fill(255);
    textSize(16);
    text("Player HP: " + player.hp, 20, 30);
    text("Reil HP: " + reil.hp, width - 150, 30);
    
    // Check end conditions
    if (player.hp <= 0) {
      gameOver = true;
      playerWon = false;
    }
    if (reil.hp <= 0) {
      gameOver = true;
      playerWon = true;
    }
  } else {
    displayGameOver();
  }
}


// INPUT
void keyPressed() {
  if (key == ' ') {
    bullets.add(new Bullet(player.x, player.y - 20));
  }
  if (gameOver && key == 'r') {
    setup(); // restart
    gameOver = false;
  }
}


// BACKGROUND STARS
void drawBackgroundStars() {
  noStroke();
  fill(255, 255, 180, 80);
  for (int i = 0; i < 100; i++) {
    float x = (frameCount * 0.1 + i * 80) % width;
    float y = (i * 50 + frameCount * 0.05) % height;
    ellipse(x, y, 2, 2);
  }
}


// GAME OVER SCREEN
void displayGameOver() {
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(36);
  if (playerWon) {
    text("✨ You defeated Reil! ✨", width/2, height/2);
  } else {
    text("💀 You were defeated...", width/2, height/2);
  }
  textSize(20);
  text("Press R to restart", width/2, height/2 + 40);
}
