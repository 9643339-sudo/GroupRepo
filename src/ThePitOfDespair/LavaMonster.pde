PImage lavam;   // image for the lava monster
int speed = 3;
boolean iftouch = false;
int w = 500;
int h = 500;
boolean up;
boolean down;
boolean left;
boolean right;

// simple player variables (optional but helps test)
float px, py;
float pSize = 20;

void setup() {
  size(500, 500);

  // load lava monster image
  // Make sure the file "lavaMonster.png" is in your sketch's "data" folder
  lavam = loadImage("lavam.png");

  // player starting position
  px = width/2;
  py = height - 80;
}

void draw() {
  background(0);

  // draw lava monster in the center
  if (lavam != null) {
    imageMode(CENTER);
    image(lavam, width/2, height/2);

    // fallback if image is missing
    //  fill(255, 0, 0);
    // ellipse(width/2, height/2, 80, 80);
    // textAlign(CENTER);
    // fill(255);
    //text("Missing lavaMonster.png", width/2, height/2 - 50);
    if (up)    py -= speed;
    if (down)  py += speed;
    if (left)  px -= speed;
    if (right) px += speed;
  }

  // draw player
  fill(0, 150, 255);
  rect(px, py, pSize, pSize);

  // simple collision check
  if (dist(px, py, width/2, height/2) < 60) {
    iftouch = true;
  } else {
    iftouch = false;
  }

  // show touch state
  fill(255);
  text("Touching lava monster: " + iftouch, 120, 20);
}

void keyPressed() {
  if (key == 'w') up = true;
  if (key == 's') down = true;
  if (key == 'a') left = true;
  if (key == 'd') right = true;
}
void keyReleased() {
  if (key == 'w') up = false;
  if (key == 's') down = false;
  if (key == 'a') left = false;
  if (key == 'd') right = false;
}
