
class Player {
  float x, y;
  int w = 40, h = 40;
  int health;
  float speed = 4; // instant speed, no acceleration

  Player(float startX, float startY) {
    x = startX;
    y = startY;
    health = 100;
  }

  void update() {
    //WASD movement
    if (keyPressed) {
      if (key == 'a' || key == 'A') { x -= speed; facing = "left"; }
      if (key == 'd' || key == 'D') { x += speed; facing = "right"; }
      if (key == 'w' || key == 'W') { y -= speed; facing = "up"; }
      if (key == 's' || key == 'S') { y += speed; facing = "down"; }
    }


  void display() {
    fill(0, 0, 255);
    rect(x, y, w, h);


  void takeDamage(int dmg) {
    health -= dmg;
  }
}
