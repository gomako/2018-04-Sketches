class Fish {

  PVector start, end, control, pos, vel, acc;
  int segments;
  PVector[] path;
  float leafWidth; // The overall width of the leaf
  float leafShape, extrudeDistance; // Leaf shape params
  float offset,a, speed;
  float hue;
  float len;
  float alpha;
  float limit;

  Fish() {
    len = random(10,200);
    pos = new PVector(random(width), random(0, height));
    vel = new PVector();
    acc = new PVector(0, -1/len);
    segments = (int)random(10,20);
    path = new PVector[segments];
    hue = random(1);
    offset = random(-100, 100);
    start = new PVector(0,0);
    end = new PVector(0, len);
    control = new PVector(0, len/2);
    speed = random(0.03,0.09);
    leafWidth = random(0.1,0.3);
    alpha = random(0.3,.9);
    limit = random(1,3);
  }

  void update() {
    
    vel.add(acc);
    vel.limit(limit);
    pos.add(vel);
    
    a+=speed;
    
    control.x = end.x+(sin(a)*offset);
    start.x = end.x+(cos(a)*offset);
    
    
    // Get the segments of the path
    for (int i=0; i<segments; i++) {
      // Split the line up into segments
      float t = map(i, 0, segments, 0, 1);
      path[i] = quadraticCurve(start, control, end, t);
    }
    
    if(pos.y < -len) {
      pos.y = height + len;
    }
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    drawStem();
    drawLeaves();
    popMatrix();
  }


  void drawLeaves() {

    
    for (int i = 1; i < path.length-1; i++) {

      // Get a unit val to work with
      float t = map(i, 0, path.length, 0, 1);

      // Set colour
      noStroke();
      fill(hue, 0, .8, alpha);
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
      ellipse(-2,0,1,extrudeDistance);
      rotate(radians(-90));
      ellipse(-2,0,1,extrudeDistance);
      //line(0,0,0,extrudeDistance);
      popMatrix();
      
      
    }
  }



  // Draw the segments of the stem
  void drawStem() {

    for (int i=1; i<path.length; i++) {
      // Get a unit val to work with
      float t = map(i, 0, path.length, 0, 1);
      stroke(hue, 0, .6, alpha);
      //strokeWeight(map(t,0,1,10,1));
      line(path[i].x, path[i].y, path[i-1].x, path[i-1].y);
    }
  }
}
