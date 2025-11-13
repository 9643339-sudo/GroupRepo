class LightSword {
  float x;
  int timer = 0;
  boolean striking = false;
  
  LightSword(float x) {
    this.x = x;
  }
  
  void update() {
    timer++;
    if (timer < 60) striking = false;     // warning
    else if (timer < 100) striking = true; // strike
    else striking = false;
  }
  
  void display() {
    if (timer < 60) {
      stroke(255, 200, 0);
      line(x, 0, x, 100);
    } else if (striking) {
      stroke(255, 255, 255);
      strokeWeight(8);
      line(x, 0, x, height);
      strokeWeight(1);
    }
  }
  
  boolean hits(Player p) {
    return striking && abs(p.x - x) < p.size/2;
  }
  
  boolean finished() {
    return timer > 120;
  }
}
