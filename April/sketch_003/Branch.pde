
// Can't get this to work!

class Branch {

  PVector start, end;
  float len, angle, thickness, a;
  color clr;
  int numFlowers = 20;
  Blossom[] blossom = new Blossom[numFlowers];
  
  Branch(float _x, float _y) {
    
    start = new PVector(_x,_y);
    end = new PVector(start.x, height+100);
    
    angle = random(-.1,.1);
    end.rotate(angle);
    
    clr = color(5,1,random(10));
    thickness = random(2,10);
    
    for (int i = 0; i < blossom.length; i++ ) {
      //blossom[i] = new Blossom();
    }
  }
  
  void update() {
    start.x += sin(a) / 10;
    end.x += sin(a) / 10;
    a += 0.01;
  }
  
  void display() {
    
    strokeWeight(thickness);
    stroke(clr);
    
    line(start.x, start.y, end.x, end.y);
    
    //for (int i = 0; i < blossom.length; i++ ) {
    //  blossom[i].update();
    //  blossom[i].display();
    //}
    
  }

}