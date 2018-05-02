class Boof {

  PVector location, velocity, acceleration;
  float mass;
  ArrayList<PVector> tail = new ArrayList();
  color clr = colors[(int)random(colors.length)];


  Boof() {
    mass = random(0.1, 1);
    location = new PVector(random(width), random(height));
    velocity = new PVector(random(-.5, .5), random(-.5, .5));
    acceleration = new PVector(0, 0);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {

    fill(clr);

    pushMatrix();
    
    translate(location.x, location.y);
    rotate(velocity.heading());
    rect(0, 0, 30, 10);
    
    
    popMatrix();
  }
}
