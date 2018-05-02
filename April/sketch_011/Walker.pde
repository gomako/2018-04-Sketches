class Walker {

  PVector pos, vel, acc;
  ArrayList<Tail> tail = new ArrayList();
  int num = 10;
  color clr;

  Walker() {
    pos = new PVector(width/2, height/2);
    vel = new PVector();
    acc = new PVector(random(-1, 1), random(-1, 1));
    clr = colors[(int)random(colors.length)];
    noStroke();
  }

  void update() {
    acc.set(random(-.5, .5), random(-.5, .5));
    vel.add(acc);
    vel.limit(10);
    pos.add(vel);
    edges();

    tail.add(new Tail(pos.copy(), vel.copy(), clr));
  }

  void display() {
    //debug();
    
    if (tail.size() > 0) {
      for (int i = tail.size() - 1; i >= 0; i--) {
        
        Tail t = tail.get(i);
        t.update();
        t.display();
        if (t.isFinished()) {
          tail.remove(i);
        }
      }
    }
  }
  void edges() {
    if (pos.y < border) vel.y *= -1;
    if (pos.y > height-border) vel.y *= -1;
    if (pos.x < border) vel.x *= -1;
    if (pos.x > width-border) vel.x *= -1;
  }
  void debug() {
    PVector lastVel = vel.copy();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(vel.lerp(lastVel, .9).heading());
    ellipse(0, 0, 30, 30);
    stroke(255);
    line(0, 0, 60, 0);
    line(60, 0, 50, 10);
    line(60, 0, 50, -10);
    line(-30, 0, 0, 0);
    ellipse(-30, 0, 5, 5);
    popMatrix();
  }
}