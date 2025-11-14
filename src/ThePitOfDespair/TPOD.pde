char screen = 's';   // s = start, m = menu, t = settings, p = play, u = pause, g = game over, a = app stats
Button btnStart, btnMenu, btnSettings, btnBack;


void setup() {
  size(600, 400);
  
  btnStart    = new Button("Start Game",   220, 150, 160, 50);
btnMenu    = new Button("Menu",   220, 300, 160, 50);
btnSettings    = new Button("Settings",   220, 450, 160, 50);
}


void draw() {
  background(230);
  switch(screen) {
    case 's':
    background(0);
    btnStart.display();
  btnStart.clicked();
  btnMenu.display();
  btnMenu.clicked();
  btnSettings.display();
  btnSettings.clicked();
  
    // startScreen();
    case 'p':
  }
}
  
  

  



void mousePressed() {
  switch(screen) {
    case 's':
    if(btnStart.clicked()){
      screen = 'p';
    }
  }
  }


void drawStart() {
  background(100, 160, 200);
  textAlign(CENTER);
  textSize(32);
  text("START SCREEN", width/2, 50);
  btnStart.display();
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
