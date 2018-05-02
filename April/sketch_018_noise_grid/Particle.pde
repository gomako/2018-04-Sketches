class Particle {

  PVector pos;
  PVector vel;
  PVector acc;
  PVector prev;
  float maxspeed = random(1, 4);
  float h, s, b, a;
  float aStep;
  ArrayList<PVector>tail = new ArrayList();
  int maxTail = (int)random(20, 200);
  boolean start = true;
  PShape sh, endSh;

  Particle() {
    
    //PShape src = things[(int)random(things.length-1)];
    //sh = createShape();
    //sh.beginShape();
    //for(int i=0; i<src.getVertexCount(); i++) {
    //  sh.vertex(src.getVertexX(i), src.getVertexY(i));
    //}
    //sh.endShape();
    
    sh = things[(int)random(things.length)];
    endSh = things[(int)random(things.length)];
    
    
    pos = new PVector(random(width-1), random(height));
    vel = new PVector(0, 0);
    acc = PVector.random2D();
    prev = pos.copy();
    h = 1;//random(1);
    s = 0;//random(1);
    b = 1;
    a =1;
    init();
    start = false;
    
    aStep = 1.0/maxTail; // INTEGER DIVISION!!!
  }

  void update() {
    // Check to see if the lead thing is at the edge
    // otherwise we get an out of bounds when trying to follow
    // the flowfield
    if (!atEdge()) {
      follow();
    } 
    vel.add(acc);
      vel.limit(maxspeed);
      pos.add(vel);
      acc.mult(0);

    // Now we want to remove the last  
    // one and add the current position
    // to the start of the list
    tail.remove(tail.size()-1);
    if (tail.size() < maxTail) {
      tail.add(0, pos.copy());
    }

    PVector last = tail.get(tail.size()-1);
    if (last.x < 0) init();
    if (last.x >= width) init();
    if (last.y < 0) init();
    if (last.y >= height) init();
  }

  void draw() {
    strokeWeight(2);
    stroke(h, s, b, 0.7);
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(vel.heading());
    shape(sh, 0, 0);
    popMatrix();

    //drawTrail();
    
    
    for (PVector p : tail) {
      point(p.x, p.y);  
    }
    
    
    pushMatrix();
    PVector endPos = tail.get(tail.size()-1);
    PVector endVel = endPos.copy();
    endVel.sub(tail.get(tail.size()-2));
    translate(endPos.x, endPos.y);
    rotate(endVel.heading());
    shape(endSh, 0, 0);
    popMatrix();
  }

  boolean atEdge() {
    return (pos.x >= width || pos.x < 0 || pos.y >= height || pos.y < 0);
  }

  void drawTrail() {
    beginShape();
    for (PVector p : tail) {
      stroke(h,s,b,a);
      vertex(p.x, p.y);
    }
    endShape();
  }

  void init() {

    if (!start) {
      pos.set(width-1, random(height));
    }

    tail.clear();
    for (int i = 0; i < maxTail; i++) {
      tail.add(pos.copy());
    }
  }

  void follow() {
    int x = floor(pos.x/scl);
    int y = floor(pos.y/scl);
    int index = x + y * cols;
    PVector force = flowField[index];
    applyForce(force);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }
}