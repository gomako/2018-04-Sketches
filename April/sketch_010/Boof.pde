class Boof {

  PVector pos;
  color clr;
  int index;
  float pupilScale;
  float a, angle, speed, blinkAmount;
  boolean opening = true;
  Boof(float _x, float _y) {
    pos = new PVector(_x, _y);
    pupilScale = random(0.1, 0.4);
    clr = colors[(int)random(colors.length)];
    a = random(TWO_PI);
    angle = random(TWO_PI);
    speed = random(0.01,.1);
    blinkAmount = PI;
  }

  // Update the thing
  void update() {
    a = lerp(a, angle, speed);
    if(angle - a < 0.1) {
      angle += random(TWO_PI);
    }
    
    
  }


  // Draw the thing
  void display() {
    noStroke();
    fill(255);
    pushMatrix();
    translate(pos.x, pos.y);
    ellipse(0,0, rad,rad);
    
    rotate(a);
    translate(rad/6,0);
    
    fill(clr);
    ellipse(0,0, rad*.618,rad*.618);
    fill(0);
    ellipse(0,0, rad*pupilScale,rad*pupilScale);
    popMatrix();
    
    pushMatrix();
    fill(42);
    translate(pos.x, pos.y);
    arc(0, 0, rad, rad, PI+blinkAmount, TWO_PI-blinkAmount, CHORD);
    arc(0, 0, rad, rad, 0+blinkAmount, PI-blinkAmount, CHORD);
    popMatrix();
  }
}
