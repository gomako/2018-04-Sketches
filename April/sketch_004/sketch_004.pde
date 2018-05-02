/*

 April 2018 month of code
 004 - Rain
 
 */

// Basic setup
int num = 50;
Boof[] boofs = new Boof[num];
color[] colors = {#5c6565, #bc9e7f, #3b5e79, #d9df85, #906b74, #d6d495, #de5e4c, #d5497f, #d58b7d};
int Y_AXIS = 1;
int X_AXIS = 2;
color b1, b2, c1, c2;
boolean recording = false;

void setup() {
  size(600, 600, P3D);
  pixelDensity(displayDensity());
  colorMode(HSB, 1);
  for (int i = 0; i < boofs.length; i++ ) {    
    boofs[i] = new Boof();
  }
  b1 = color(255);
  b2 = color(0);
  c1 = color(204, 102, 0);
  c2 = color(0, 102, 153);
}


void draw() {

  background(0, 0, 0);
  setGradient(0, 0, width, height, b1, b2, Y_AXIS);

  rotateX(.5);

  for (int i = 0; i < boofs.length; i++ ) {    
    boofs[i].update();
    boofs[i].display();
  }


  if (recording) {
    saveFrame("output/frame_###.png");
  }
}

void keyPressed() {
  recording = !recording;
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  } else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}
