// -------------------------------------------
// GLOBALS
// -------------------------------------------
char screen = 's';   // s = start, m = menu, t = settings, p = play, u = pause, g = game over, a = app stats
Button btnStart, btnMenu, btnSettings, btnBack;

PImage tpodMenuScreen; // <-- Added image variable

// -------------------------------------------
void setup() {
  size(600, 400);

  // Load background image
  tpodMenuScreen = loadImage("TPOD_MenuScreen.png");  

  // Example buttons for practice starter
  btnStart = new Button("Play", 220, 150, 160, 50);
  btnSettings = new Button("Settings", 220, 300, 160, 50);
}

// -------------------------------------------
void draw() {
  switch(screen) {
    
  case 's': // Start screen
    tpodMenuScreen = loadImage("TPODMENUSCREEN.png");

    btnStart.display();
    btnSettings.display();
    break;

  case 'p': // Play screen example
    drawPlay();
    break;

  case 't': // Settings
    drawSettings();
    break;
  }
}

// -------------------------------------------
// MOUSE CLICK HANDLER
// -------------------------------------------
void mousePressed() {
  switch(screen) {
  case 's':
    if (btnStart.clicked()) {
      screen = 'p';
    }
    if (btnSettings.clicked()) {
      screen = 't';
    }
    break;
  }
}

// -------------------------------------------
// SCREEN DRAW METHODS
// -------------------------------------------
void drawStart() {
  image(tpodMenuScreen, 0, 0, width, height);
  btnStart.display();
  btnSettings.display();
}

void drawMenu() {
  background(120, 200, 140);
  textSize(32);
  text("MENU SCREEN", width/2, 50);
  btnMenu.display();
}

void drawSettings() {
  background(200, 150, 120);
  textSize(32);
  text("SETTINGS", width/2, 50);
  btnSettings.display();
}

void drawPlay() {
  background(255);
  text("PLAY SCREEN (fill this in)", 200, 200);
}

void drawPause() {
  background(255);
  text("PAUSE SCREEN (fill this in)", 200, 200);
}

void drawGameOver() {
  background(255);
  text("GAME OVER SCREEN (fill this in)", 200, 200);
}

void drawStats() {
  background(255);
  text("STATS SCREEN (fill this in)", 200, 200);
}

