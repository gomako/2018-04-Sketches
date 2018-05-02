class Boof {

  int i;
  float rad;
  float a, yrot;
  float aVel = 0.01;
  float base = 10;
  float start, end;
  float h,s,b,alpha;
  float step;

  Boof(int index) {
    i = index;
    step = width/num;
    println(step);
    rad = base + (i*step);
    a = i*(PI/100);
    start = random(PI);
    end = random(start, TWO_PI);
    yrot = random(1) > 0.5 ? random(TWO_PI) : -random(TWO_PI);
    h = .5;
    s = random(.1,.3);
    b = .9;
    alpha = map(i,0,num,0,1);
    
  }
  
  void display() {
    pushMatrix();
    rotateX(a);
    rotateZ(yrot);
    stroke(h,s,b,alpha);
    arc(0,0,rad,rad,end+.05, end+.1);
    arc(0,0,rad,rad,end+.15, end+.17);
    arc(0,0,rad,rad,end+.19, end+.2);
    arc(0,0,rad,rad,start, end);
    popMatrix();
    a+=0.01;
    yrot+=0.01;
  }

}
