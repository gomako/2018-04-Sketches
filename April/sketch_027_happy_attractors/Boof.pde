class Boof {
  
  char c;
  PVector location, velocity, acceleration;
  float mass;
  
  
  Boof(char _c) {
    mass = random(0.1,1);
    c = _c;
    location = new PVector(random(width), random(height));
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display() {
    
    fill(200);
    
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading());
    scale(mass);
    text(c,0,0);
    popMatrix();
  }
  
}
