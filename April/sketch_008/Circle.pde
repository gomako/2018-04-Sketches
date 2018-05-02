class Circle {

  float x;
  float y;
  float rad;
  float h, s, b;
  color c = color(palette[(int)random(palette.length-1)]);
  float speed;
  boolean growing = true;

  Circle(float _x, float _y) {
    x = _x;
    y = _y;
    h = 1;
    s = 1;
    b = 0;
    rad = 1;
    speed = random(0.1,0.9);
  }

  void draw() {
    noStroke();
    fill(c);
    ellipse(x, y, rad*2, rad*2);
  }

  void grow() {
    if (growing) {
      rad += speed;
    }
  }

  boolean edges() {
    return (x+rad > width || x-rad <0 || y + rad > height || y-rad < 0);
  }
}
