// Trying to figure out a processing way of doing this -> https://mattdesl.svbtle.com/tendril-web-toy 
// I think I've done it wrong, but SO WAT!

PVector start, end, control;

float border = 100;

int num = 20;
Leaf leaves[] = new Leaf[num];

Boolean capturing = false;

void setup() {

  size(600, 600);
  pixelDensity(displayDensity());
  stroke(0);
  noFill();

  colorMode(HSB, 1);
  strokeCap(SQUARE);
  float space = width/num;
  for (int i=0; i<leaves.length; i++) {
    leaves[i] = new Leaf(space*i+space/2, height);
  }
}

void draw() {

  background(1, 0, 1);
  for (int i=0; i<leaves.length; i++) {
    leaves[i].update();
    leaves[i].display();
  }
  
  if(capturing) {
    saveFrame("output/frame_###.png");
  }
}

void keyPressed() {
  if(key == 'r') {
    capturing = !capturing;
  }
}

// This is the SECRET SAUCE!!!
PVector quadraticCurve(PVector start, PVector control, PVector end, float t) {
  float x1 = start.x;
  float y1 = start.y;
  float x2 = control.x;
  float y2 = control.y;
  float x3 = end.x;
  float y3 = end.y;

  float dt = 1 - t;
  float dtSq = dt * dt;
  float tSq = t * t;
  float x = dtSq * x1 + 2 * dt * t * x2 + tSq * x3;
  float y = dtSq * y1 + 2 * dt * t * y2 + tSq * y3;
  return new PVector(x, y);
}