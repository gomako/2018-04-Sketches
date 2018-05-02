class Planet {

  PVector pos;
  ArrayList<Boof> boofs = new ArrayList();
  int num = 300;
  float rad = 1000;
  float aVel = 0.01;
  float a;

  Planet() {
    pos = new PVector(width/2, height/2);
    for (int i=0; i<num; i++) {
      boofs.add(new Boof(i, rad, num));
    }
  }

  void update() {
    //for(Boof b: boofs) {
    //  b.update();
    //}
    a += aVel;
  }

  void display() {
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotateX(QUARTER_PI);
    rotateY(a);
    noFill();
    //sphere(rad);
    for(Boof b: boofs) {
      b.display();
    }
    popMatrix();
  }
}
