// Some rotating arcs and stuff to go around

// Basic setup
Boof[] boofs = new Boof[100];

float border = 100;

void setup() {
  
  size(800,800);
  
  colorMode(HSB,1);
  
  pixelDensity(displayDensity());
  for (int i = 0; i < boofs.length; i++ ) {    
    boofs[i] = new Boof(random(border,width-border), random(border,height-border));
  }
}


void draw() {
  
  background(1,0,.16);
  
  for (int i = 0; i < boofs.length; i++ ) {    
    boofs[i].update();
    boofs[i].display();
  }
  
  
  saveFrame("output/001_####.png");
  
}