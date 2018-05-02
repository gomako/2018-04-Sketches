class Boof {

  // Some set vars
  PVector pos = new PVector();

  // Some dynamic vars
  float a, speed, start, end, rad, baseRad;

  // Constructor
  Boof(float _x, float _y) {
    init();
    start = random(0, PI);
    end = random(PI, TWO_PI);
  }

  // Update the thing
  void update() {
    a+=speed;

    if (a > TWO_PI) {
      speed*=-1;
    }
    if (a < 0) {
      speed*=-1;
      init();
    }
    rad = baseRad;
    start = a;
    end = start+a;
  } 


  // Draw the thing
  void display() {
    noStroke();
    fill(map(pos.y, 0, height, 0,1), 1, 1, .618);
    arc(pos.x, pos.y, rad, rad, start, end);
    noFill();
    stroke(1,0,1);
    arc(pos.x, pos.y, rad+10, rad+10, start, end);
  }

  void init() {

    pos.x = random(border, width-border);
    pos.y = random(border, height-border);
    baseRad = random(10, 100);
    speed = random(0.005, 0.1);
  }
}