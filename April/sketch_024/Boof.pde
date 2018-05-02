class Boof {

  PVector pos = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  float a;
  float w;
  float h;
  color clr = colors[(int)random(colors.length)];
  
  Boof (float x, float y, float _h) {
    pos.set(x, y);
    w = 10;
    h = _h;
    a = 0;
  }

  void update(float _h) {
    h = _h;
  }

  void display() {
    pushMatrix();
    translate(pos.x*w, pos.y*w, h/2);
    fill(clr);
    box(w,w,h);
    popMatrix();
  }

}
