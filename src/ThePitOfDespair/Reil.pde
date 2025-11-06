class Reil {
  PImage img;
  ArrayList<Star> stars;
  ArrayList<Sword> swords;

  Reil(PImage img) {
    this.img = img;
    stars = new ArrayList<Star>();
    swords = new ArrayList<Sword>();
    for (int i = 0; i < 50; i++) {
      stars.add(new Star(random(width), random(-height, 0)));
    }
  }

  void update() {
    for (Star s : stars) {
      s.update();
    }
    for (Sword sw : swords) {
      sw.update();
    }
  }

  void display() {
    image(img, width/2 - img.width/2, height - img.height);
    for (Star s : stars) {
      s.display();
    }
    for (Sword sw : swords) {
      sw.display();
    }
  }

  void strike(float x, float y) {
    swords.add(new Sword(x, y));
  }
