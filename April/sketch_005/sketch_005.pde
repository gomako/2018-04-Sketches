/*

 April 2018 month of code
 005 - Wriggling RainBOW WERMZ
 
 */

// Basic setup
int num = 10;
int border = 100;
Boof[] boofs = new Boof[num];
color[] colors = {#5c6565, #bc9e7f, #3b5e79, #d9df85, #906b74, #d6d495, #de5e4c, #d5497f, #d58b7d};
boolean recording = false;

void setup() {
  size(600, 600);
  pixelDensity(displayDensity());
  colorMode(HSB, 1);
  for (int i = 0; i < boofs.length; i++ ) {    
    boofs[i] = new Boof();
  }
  background(color(#2a7fff));
}


void draw() {

  //background(color(#2a7fff));

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