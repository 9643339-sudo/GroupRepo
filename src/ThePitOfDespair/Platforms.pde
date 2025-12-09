SquareMan fred;
ArrayList<Platform> platforms;

// Camera offset
float camY = 0;

// Platform generation
float highestPlatformY;
float platformSpacing = 80;

// Input
boolean moveLeft = false;
boolean moveRight = false;

void setup() {
  size(500, 500);

  fred = new SquareMan(width/2, 100, color(0, 0, 255));

  platforms = new ArrayList<Platform>();

  // Create initial platforms
  for (int i = 0; i < 10; i++) {
    float px = random(50, width - 150);
    float py = height - i * platformSpacing;
    platforms.add(new Platform(px, py, 120, 20, random(-2, 2)));
  }

  highestPlatformY = height - (10 - 1) * platformSpacing;
}

void draw() {
  background(127);

  // Smooth camera following player upward
  float targetCamY = fred.y - height/2;
  camY = lerp(camY, targetCamY, 0.1);

  // Update platforms
  for (Platform p : platforms) {
    p.update();
  }

  // Update player with movement inputs
  fred.update(platforms, camY, moveLeft, moveRight);

  // Generate new platforms
  generatePlatforms();

  // Draw world with camera offset
  pushMatrix();
  translate(0, -camY);

  fred.display();
  for (Platform p : platforms) p.display();

  popMatrix();

  // Clean up platforms below the screen
  cleanupPlatforms();
}

void generatePlatforms() {
  while (highestPlatformY > camY - 300) {
    highestPlatformY -= platformSpacing;

    float px = random(50, width - 150);
    float pVel = random(-2, 2);

    platforms.add(new Platform(px, highestPlatformY, 120, 20, pVel));
  }
}

void cleanupPlatforms() {
  for (int i = platforms.size() - 1; i >= 0; i--) {
    if (platforms.get(i).y - camY > height + 200) {
      platforms.remove(i);
    }
  }
}

void keyPressed() {
  if (key == ' ') fred.jump();
  if (key == 'a' || key == 'A') moveLeft = true;
  if (key == 'd' || key == 'D') moveRight = true;
}

void keyReleased() {
  if (key == 'a' || key == 'A') moveLeft = false;
  if (key == 'd' || key == 'D') moveRight = false;
}

void mousePressed() {
  fred.jump();
}
