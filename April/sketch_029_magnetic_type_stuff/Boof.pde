class Boof {

  PVector location, velocity, acceleration;
  float mass;
  ArrayList<PVector> tail = new ArrayList();
  color clr = color(42);//colors[(int)random(colors.length)];
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

    noFill();
    stroke(clr);

    pushMatrix();
    translate(location.x, location.y);
    ellipse(0,0,headSize*2,headSize*2);
    popMatrix();

    beginShape();
    for (int i = tNum-1; i > 0; --i) {
      PVector p = tail.get(i);
      vertex(p.x, p.y);
    }
    endShape();

    pushMatrix();
    PVector end = tail.get(0);
    PVector endPrev = tail.get(1);
    PVector endRot = PVector.sub(end, endPrev);
    translate(end.x, end.y);
    rotate(endRot.heading() - HALF_PI);
    triangle(0,-headSize,-headSize,headSize, headSize,headSize);
    popMatrix();

  }

  void resetTail() {
    tail.clear();
    for (int i = 0; i < tNum; ++i) {
      tail.add(location.copy());
    }    
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
