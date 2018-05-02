class Boof {

  PVector pos = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  float w = res;
  
  Boof (float x, float y) {
    pos.set(x,y);
  }

  void display(float noise) {
    fill(1,map(noise, 0,1,1,0),map(noise, 0,1,.7,1));
    noStroke();
    pushMatrix();
    translate(res/2, res/2);
    ellipse(pos.x, pos.y, res*noise, res*noise);
    popMatrix();
  }

  void edges() {
    if (pos.y > height-border ) pos.y = border;
    if (pos.y < border ) pos.y = height-border;
    if (pos.x > width-border ) pos.x = border;
    if (pos.x < border ) pos.x = width-border;
  }
}
