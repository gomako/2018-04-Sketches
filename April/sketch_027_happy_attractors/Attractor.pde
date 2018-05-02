class Attractor {
  float mass;
  PVector location;
  float G;
 
  Attractor() {
    location = new PVector(width/2,height/2);
    mass = 20;
    G = 0.4;
  }
 
  PVector attract(Boof m) {
    PVector force = PVector.sub(location,m.location);
    float distance = force.mag();
    distance = constrain(distance,5.0,25.0);
    force.normalize();
    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }
 
  void display() {
    stroke(0);
    fill(175,200);
    ellipse(location.x,location.y,mass*2,mass*2);
  }
}
