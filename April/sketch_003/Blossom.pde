class Blossom {

  PVector pos, vel, acc;
  
  float rad, angle, xOff, dir;
  
  color clr;
  
  Blossom(float _x, float _y) {    
    pos = new PVector(_x, _y);
    vel = new PVector();
    acc = new PVector();
    rad = random(5,30);
    dir = (random(1) > .5) ? 1 : -1;
    clr = color(colors[(int)random(colors.length)]);
  }
  
  // Update the thing
  void update() {
    
    xOff = sin(angle)  * rad;
    vel.add(this.acc);
    vel.limit(rad * 0.07);
    
    if(vel.mag() < 1) {
      vel.normalize();
    }
    
    pos.add(vel);
    acc.mult(0);
    

    if(pos.y > height+rad) {
      rad = random(10,50);
      pos.y = random(-100,-10) - rad;
    }
    
    if(pos.x < -rad*2) {
      pos.x = width + rad;
    }
    if(pos.x > width + rad*2) {
      pos.x = -rad*2;
    }
    
    angle += dir * vel.mag() / 200;
  }
  
  // Draw the thing
  void display() {
    
    pushMatrix();
    translate(pos.x + xOff, pos.y);
    rotate(angle);
    drawPetal();
    
    popMatrix();
    
    
  }
  
  void drawPetal() {
    noStroke();
    fill(clr,200);
    beginShape();
    
    for(int i = 0; i < 6; i++) {
      vertex(sin(i)*rad, cos(i)*rad);
    }
    endShape();
    
  }
  
   void applyForce(PVector force) {
     PVector f = force.copy();
     f.mult(rad);
     acc.add(f);
   }
  
}