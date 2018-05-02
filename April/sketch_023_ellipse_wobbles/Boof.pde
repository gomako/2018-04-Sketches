class Boof {

  PVector pos = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  color clr = colors[(int)random(colors.length)];
  float rad = random(300,400);
  float offset = random(1,10);
  float sw = 4;//random(2,4);
  float a = random(TWO_PI);
  float aVel = random(0.01,0.1);
  
  Boof (int index) {
    float step = 500/num;
    rad = step*index;
  }

  void display() {
    stroke(clr);
    strokeWeight(sw);
    pushMatrix();
    rotate(a);
    translate(offset,0);
    
    ellipse(0,0,rad,rad);
    popMatrix();
    
    a+=aVel;
  }

  void edges() {
    if (pos.y > height-border ) pos.y = border;
    if (pos.y < border ) pos.y = height-border;
    if (pos.x > width-border ) pos.x = border;
    if (pos.x < border ) pos.x = width-border;
  }
}
