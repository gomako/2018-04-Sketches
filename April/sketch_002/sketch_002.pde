/*

April 2018 month of code
002

*/

// Basic setup
int num = 625;
Boof[] boofs = new Boof[num];
color[] colors = {#5c6565, #bc9e7f, #3b5e79, #d9df85, #906b74, #d6d495, #de5e4c, #d5497f, #d58b7d};
float border = 100;
float rad = 100;

void setup() {
  
  size(600,600);
  pixelDensity(displayDensity());
  colorMode(HSB,1);
  for (int i = 0; i < boofs.length; i++ ) {    
    boofs[i] = new Boof(i);
  }
  
}


void draw() {
  
  background(1,0,.16);
  
  for (int i = 0; i < boofs.length; i++ ) {    
    boofs[i].update();
    boofs[i].display();
  }
  //saveFrame("output/frame_###.png");
}
