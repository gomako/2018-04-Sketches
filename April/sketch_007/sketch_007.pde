// Fish or protozoa or something....

PVector start, end, control;

float border = 100;

int num = 50;
Fish fishes[] = new Fish[num];

Boolean capturing = false;

void setup() {

  size(600, 600);
  pixelDensity(displayDensity());
  stroke(0);
  noFill();

  colorMode(HSB, 1);
  strokeCap(SQUARE);
  float space = width/num;
  for (int i=0; i<fishes.length; i++) {
    fishes[i] = new Fish();
  }
}

void draw() {

  background(1, 0, 0);
  for (int i=0; i<fishes.length; i++) {
    fishes[i].update();
    fishes[i].display();
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
