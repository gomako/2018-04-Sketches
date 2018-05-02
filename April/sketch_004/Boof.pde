class Boof {

  float x, y, rad, alpha, max, speed, easing;
  boolean showDrop = false;
  
  Boof() {
    init();
    rad = random(50);
  }
  void init() {
    x = random(width);
    y = random(height);
    alpha = random(.7);
    rad = 0;
    max = random(100,300);
    speed = random(.3,1);
    easing = 0.05;
    showDrop = true;
  }
  
  void update() {
    
    
    alpha -= speed/30;
    
    float dx = max - rad;
    rad += dx * easing;
    
    if(alpha < 0) {
      init();
    }
  }
  
  void display() {
    noFill();
    strokeWeight(4);
    stroke(1,0,1,alpha);
    ellipse(x,y,rad,rad);
    if(showDrop) line(x,y,500,x,y,0);
    showDrop = false;
  }
  
}
