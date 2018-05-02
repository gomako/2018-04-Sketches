class Boof {

  PVector location, velocity, acceleration;
  float mass;
  ArrayList<PVector> tail = new ArrayList();
  color clr = colors[(int)random(colors.length)];
  int tNum = 10;
  int count = 0;
  float headSize;

  Boof() {
    mass = random(0.1, 1);
    headSize = 10 * mass;
    location = new PVector(random(width), random(height));
    velocity = new PVector(random(-1,1),random(-1,1));
    acceleration = new PVector(0, 0);
    for (int i = 0; i < tNum; ++i) {
      tail.add(location.copy());
    }
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

  void eat() {
    mass += 0.2;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    tail.remove(0);
    tail.add(location.copy());  
    velocity.add(acceleration);
    velocity.limit(5);
    location.add(velocity);
    acceleration.mult(0);
    edges();
  }

  void display() {

    noStroke();
    fill(clr, 200);
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading());
    triangle(-headSize, -headSize, -headSize, headSize, headSize, 0);
    popMatrix();

  }

  void resetTail() {
  }

  void edges() {
    if(location.x < 0) {
     location.x = width;
     resetTail();
    }
    if(location.x > width) {
     location.x = 0;
     resetTail();
    }
    if(location.y < 0) {
     location.y = height;
     resetTail();
    }
    if(location.y > height) {
     location.y = 0;
     resetTail();
    }
  }



}
