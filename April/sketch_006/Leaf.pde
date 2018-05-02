class Leaf {

  PVector start, end, control;
  int segments;
  PVector[] path;
  float leafWidth = 0.3; // The overall width of the leaf
  float leafShape, extrudeDistance; // Leaf shape params
  float h, offset,a, speed;
  float hue;

  Leaf(float _x, float _y) {
    segments = (int)random(15,30);
    path = new PVector[segments];
    hue = random(1);
    float x = _x;
    offset = random(-100, 100);
    start = new PVector(x, _y);
    h = random(0, height-border);
    end = new PVector(x, h);
    control = new PVector(x, (height-(height-h)/2));
    speed = random(0.01,0.09);
  }

  void update() {
    a+=speed;
    control.x = end.x+(sin(a)*offset);
    //control.y = control.y+(cos(a)*offset);
    // Get the segments of the path
    for (int i=0; i<segments; i++) {
      // Split the line up into segments
      float t = map(i, 0, segments, 0, 1);
      path[i] = quadraticCurve(start, control, end, t);
    }
  }

  void display() {
    drawStem();
    drawLeaves();
  }


  void drawLeaves() {

    for (int i = 1; i < path.length-1; i++) {

      // Get a unit val to work with
      float t = map(i, 0, path.length, 0, 1);

      // Set colour
      noStroke();
      fill(hue, 1, .8);
      //strokeWeight(map(t,0,1,10,1));
      
      // Get the vector between current and previous
      PVector current = path[i];
      PVector prev = path[i-1];
      // Get the normal
      PVector normal = new PVector();
      normal = PVector.sub(current, prev);
      normal.normalize();
      // Distance
      leafShape = abs(sin(t*PI)); 
      extrudeDistance = (leafShape * leafWidth / 2) * 300;
      
      pushMatrix();
      translate(current.x, current.y);
      rotate(normal.heading()+radians(-45));
      
      //line(0,0,0,extrudeDistance);
      ellipseMode(CORNER);
      ellipse(-2,0,4,extrudeDistance);
      rotate(radians(-90));
      ellipse(-2,0,4,extrudeDistance);
      //line(0,0,0,extrudeDistance);
      popMatrix();
      
      
    }
  }



  // Draw the segments of the stem
  void drawStem() {

    for (int i=1; i<path.length; i++) {
      // Get a unit val to work with
      float t = map(i, 0, path.length, 0, 1);
      stroke(hue, 1, .6);
      //strokeWeight(map(t,0,1,10,1));
      line(path[i].x, path[i].y, path[i-1].x, path[i-1].y);
    }
  }
}
