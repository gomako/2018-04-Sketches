// Parts that make up the planets

class Boof {

  color clr;
  int index;
  float rad;
  float angle, offset, r1, r2, h, a;
  int sides;

  Boof(int i, float radius, int numP) {
    clr = colors[(int)random(colors.length)];
    index = i; // Use this to extend out the x
    rad = radius;
    angle = random(-TWO_PI, TWO_PI);
    offset = random(30,rad);
    sides = (int) random(3,12);
    r1 = random(4,16);
    r2 = r1;
    h = random(2,5);
  }

  void update() {
    
  }

  void display() {
    
    a += 0.01;
    
    fill(clr);
    
    pushMatrix();
    
    rotateY(index/TWO_PI);
    rotateX(angle);
    rotateZ(a);
    
    translate(0,0,offset + sin(a*10)*30);
    drawCylinder(sides,r1,r2,h);
    popMatrix();
  }

  void drawCylinder( int sides, float r1, float r2, float h)
  {
    float angle = 360 / sides;
    float halfHeight = h / 2;
    // top
    beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos( radians( i * angle ) ) * r1;
      float y = sin( radians( i * angle ) ) * r1;
      vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);
    // bottom
    beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos( radians( i * angle ) ) * r2;
      float y = sin( radians( i * angle ) ) * r2;
      vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
    // draw body
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
      float x1 = cos( radians( i * angle ) ) * r1;
      float y1 = sin( radians( i * angle ) ) * r1;
      float x2 = cos( radians( i * angle ) ) * r2;
      float y2 = sin( radians( i * angle ) ) * r2;
      vertex( x1, y1, -halfHeight);
      vertex( x2, y2, halfHeight);
    }
    endShape(CLOSE);
  }
}