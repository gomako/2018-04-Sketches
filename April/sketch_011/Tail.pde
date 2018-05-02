// Actually a tail section but whatevz!

class Tail {
  float alpha = 100;
  float w, h;
  PVector pos;
  PVector vel;
  color clr;
  Boolean finished = false;
  int shapeType;
  Boolean growing = true;

  Tail(PVector _pos, PVector _vel, color _clr) {
    pos = _pos.copy();
    vel = _vel.copy(); 
    w = 6;
    clr = _clr;
    shapeType = (int)random(2);
  }
  void update() {
    if(growing) {
      h++;
    } else {
      h--;
    }
    
    w-=.1;

    if (w < 0) {
      finished = true;
    }
  }
  boolean isFinished() {
    return finished;
  }
  void display() {
    fill(clr);
    noStroke();

    pushMatrix();

    translate(pos.x, pos.y);
    rotate(vel.heading());

    if (shapeType == 0) {
      rectMode(CENTER);
      rect(0, 0, w, h);
    } else {
      ellipse(0, 0, w, h);
    }


    popMatrix();
  }
}