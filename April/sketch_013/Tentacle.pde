class Tentacle {

  PVector start, end, control;
  int segments;
  PVector[] path;
  float thickness; // The overall width of the leaf
  float leafShape, extrudeDistance; // Leaf shape params
  float h, offset, a, speed;
  color c;
  Tentacle(float _x, float _y) {
    c = clrs[(int)random(clrs.length-1)];
    segments = (int)random(20, 50);
    path = new PVector[segments];
    float x = _x;
    offset = random(-30, 30);
    start = new PVector(x, _y);
    h = random(0, height/2);
    end = new PVector(x, h);
    control = new PVector(x, (height-(height-h)/2));
    speed = random(0.02, 0.04);
    thickness = random(10, 30);
  }

  void update() {
    a+=speed;
    control.x = end.x+(sin(a)*offset);
    end.x = start.x+(cos(a)*offset+10);
    // Get the segments of the path
    for (int i=0; i<segments; i++) {
      // Split the line up into segments
      float t = map(i, 0, segments, 0, 1);
      path[i] = quadraticCurve(start, control, end, t);
    }
  }

  void display() {
    //drawStem();
    drawLeaves();
  }


  void drawLeaves() {
    fill(c);
    beginShape();
    for (int i = 1; i < path.length; i++) {
      // Get a unit val to work with
      float a = map(i, 0, path.length, 0, 1);

      // Get the vector between current and previous
      PVector current = path[i];
      // Get the normal
      PVector normal = new PVector();
      normal = PVector.sub(current, path[i-1]);
      normal.normalize();


      float t = thickness * (1 - a);
      float x, y; 
      x = current.x + sin(normal.heading()) * t;
      y = current.y + -cos(normal.heading()) * t;
      vertex(x, y);
    }
    for (int i = path.length-1; i > 0; i--) {
      // Get a unit val to work with
      float a = map(i, 0, path.length, 0, 1);

      // Get the vector between current and previous
      PVector current = path[i];
      // Get the normal
      PVector normal = new PVector();
      normal = PVector.sub(current, path[i-1]);
      normal.normalize();

      float t = thickness * (1 - a);
      float x, y; 
      x = current.x - sin(normal.heading()) * t;
      y = current.y - -cos(normal.heading()) * t;
      vertex(x, y);
    }
    endShape(CLOSE);
    
    // Draw suckers
    for (int i = 1; i < path.length; i++) {
      float a = map(i, 0, path.length, 0, 1);
      if (i%4 == 0) {
        fill(#661141);
        float w = ((thickness*(1-a))*1.75);
        ellipse(path[i].x, path[i].y, w, w);
        fill(#AA5585,75);
        ellipse(path[i].x, path[i].y, w*.618, w*.618);
      }
    }
  }

  // Draw the segments of the stem
  void drawStem() {
    for (int i=1; i<path.length; i++) {
      // Get a unit val to work with
      //float t = map(i, 0, path.length, 0, 1);
      //strokeWeight(map(t,0,1,10,1));
      line(path[i].x, path[i].y, path[i-1].x, path[i-1].y);
    }
  }
}
