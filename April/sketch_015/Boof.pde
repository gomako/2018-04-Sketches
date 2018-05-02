// Parts that make up the planets

class Boof {

  color clr;
  int index;
  float rad;
  float angle, offset, r1, r2, h, a;
  int sides[];
  int repeat;

  Boof(int i, float radius, int numP) {
    clr = colors[(int)random(colors.length)];
    index = i; // Use this to extend out the x
    rad = radius;
    angle = random(-TWO_PI, TWO_PI);
    offset = random(30, rad);
    r1 = random(5, 70);
    r2 = r1;
    h = random(1, 3);
    repeat = 4;
    sides = new int[repeat];
    for(int j=0; j<repeat; j++) {
      sides[j] = (int) random(3, 8);
    }
  }

  void update() {
  }

  void display() {

    a += 0.01;
    noFill();
    stroke(clr);
    strokeWeight(4);

    pushMatrix();

    rotateY(index/TWO_PI);
    rotateX(angle);
    rotateZ(a);

    translate(0, 0, offset);
    for(int j=0; j<repeat; j++) {
      //sides[j] = (int) random(3, 8);
      float step = r1/repeat;
      drawPoly(step*j,sides[j]);
    }
    popMatrix();
  }

  void drawPoly(float rad, int sides) {

    float inc = TWO_PI/sides;

    pushMatrix();
    rotateZ(-PI);
    beginShape();
    for (int i=0; i<sides; i++) {
      float x = sin(i*inc)*rad;
      float y = cos(i*inc)*rad;
      vertex(x, y);
    }
    endShape(CLOSE);
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
