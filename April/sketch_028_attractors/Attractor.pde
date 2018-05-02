class Attractor {
  float mass;
  PVector location;
  float G;
  boolean attracting = true;
 
  Attractor() {
    location = new PVector(random(border, width-border), random(border, height-border));
    mass = random(10, 30);
    G = 0.4;
    attracting = (random(1) > .3) ? true : false;
  }
 
  PVector attract(Boof m) {
    PVector force = PVector.sub(location,m.location);
    float distance = force.mag();
    distance = constrain(distance,5.0,25.0);
    force.normalize();
    float strength = (G * mass * m.mass) / (distance * distance);
    if(attracting) {
      force.mult(strength);
    } else {
      force.mult(-strength);
    }
    
    return force;
  }
 
  void display() {
    if(attracting) {
      fill(0,200);
    } else {
      fill(255,150);
    }
    ellipse(location.x,location.y,mass*2,mass*2);
  }
}
