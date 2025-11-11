
class Player {
  float x, y;
  int w = 40, h = 40;
  int health;
  float speed = 4; //

  Player(float startX, float startY) {
    x = startX;
    y = startY;
    health = 100;
  }

  void keyPressed() {
  if (key == 'w' || key == 'W') {
    y-= ms;
  } else if (key == 'd' || key == 'D') {
    x+= ms;
  } else if (key == 'a' || key == 'A') {
    x-= ms;
  } else if (key == 's' || key == 'S') {
    y+= ms;
  }

  void display() {
    fill(0, 0, 255);
    rect(x, y, w, h);


  void takeDamage(int dmg) {
    health -= dmg;
  }
}
