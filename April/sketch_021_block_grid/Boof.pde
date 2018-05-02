class Boof {

  PVector pos = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  color clr = colors[(int)random(colors.length)];
  int rows = 10;
  int cols = 10;
  float max = 10;
  float spacer = 5;
  float w = 0;
  float t = 0;
  float spd = 0.1;
  float a;
  boolean grow = true;

  Boof () {
    
    pos.set(random(-border,width-border),random(-border, height-border));

    cols = (int)random(4,10);
    rows = (int)random(4,10);
    max = random(8, 20);
    spacer = random(1,16);
    spd = random(0.01, 0.1);
    
    a = (random(1) > .5) ? 0 : 45;
    
  }

  void init() {
    w = 0;
    pos.set(random(-border,width-border),random(-border, height-border));
    cols = (int)random(4,10);
    rows = (int)random(4,10);
    max = random(8, 20);
    spacer = random(1,16);
    spd = random(0.01, 0.1);
    a = (random(1) > .5) ? 0 : 45;
  }

  void display() {

    noStroke();
    fill(clr);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    for (int y = 0; y < rows; ++y) {
      for (int x = 0; x < cols; ++x) {
        rect(x*(max + spacer), y*(max + spacer), w*max, w*max);
      }
    }
    popMatrix();
    
    
    w = easeInOutExpo(t);
    
    if(grow == true) {
      t+=spd;
    } else {
      t-=spd;
    }
    
     if(t > 1 - 0.1) {
       grow = !grow;
     }
     
     if(t < 0) {
       grow = !grow;
       init();
     }
    

  }

  void edges() {
    if (pos.y > height-border ) pos.y = border;
    if (pos.y < border ) pos.y = height-border;
    if (pos.x > width-border ) pos.x = border;
    if (pos.x < border ) pos.x = width-border;
  }
}
