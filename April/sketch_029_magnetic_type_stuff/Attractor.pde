class Attractor {
  float mass;
  PVector location;
  float G;
  boolean attracting = true;
 
  Attractor(float x, float y, boolean _attracting, float _mass) {
    attracting = _attracting;
    location = new PVector(x,y);
    mass = _mass;
    G = 0.5;
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

  void move() {
    location = new PVector(random(border, width-border), random(border, height-border));
    mass = random(10, 50);
  }
 
  void display() {
    noStroke();
    if(attracting) {
      fill(0,200);
    } else {
      fill(42,150);
    }
    ellipse(location.x,location.y,mass,mass);
  }
}
