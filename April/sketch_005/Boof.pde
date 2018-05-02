class Boof {

  PVector pos, lastPos, vel, acc;
  color bg = color(#2a7fff);
  float thickness = 10;
  float chunk = 10;
  int len = 7;


  Boof() {
    pos = new PVector(width/2, height/2);
    vel = new PVector();
    acc = new PVector(random(-1, 1), random(-1, 1));
    chunk = random(2, 20);
  }

  void update() {
    lastPos = pos.copy();
    acc.x = random(-1, 1);
    acc.y = random(-1, 1);
    vel.add(acc);
    vel.limit(5);
    pos.add(vel);

    if (pos.x > width + chunk*len) { 
      pos.x = -chunk*len;
    }
    if (pos.x < -chunk*len) { 
      pos.x = width + chunk*len;
    }
    if (pos.y > height + chunk*len) { 
      pos.y = -chunk*len;
    }
    if (pos.y < -chunk*len) { 
      pos.y = height + chunk*len;
    }
  }

  void display() {
    noStroke();
    colorMode(HSB, 1);

    pushMatrix();
    translate(pos.x, pos.y);
    //translate(0,200);
    rotate(vel.heading());
    // move so point is in center
    translate(-chunk/2, -chunk*len/2);


    for (int i=0; i<len; i++) {
      fill(map(i, 0, len, 0, 1), 1, 1);
      beginShape();
      vertex(0, chunk*i);
      vertex(chunk, chunk*i);
      vertex(chunk, (chunk*i)+chunk);
      vertex(0, (chunk*i)+chunk);
      vertex(0, chunk*i);
      endShape();
    }

    popMatrix();
  }
}