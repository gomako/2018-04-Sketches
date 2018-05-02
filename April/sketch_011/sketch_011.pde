/*

 April 2018 month of code
 Those furry worm things
 011

*/


import com.hamoid.*;
VideoExport videoExport;

ArrayList<Walker> walkers = new ArrayList();
int num = 60;
color[] colors = {#5c6565, #bc9e7f, #3b5e79, #d9df85, #906b74, #d6d495, #de5e4c, #d5497f, #d58b7d};
int border = 30;
Boolean recording = true;

void setup() {
  
  size(600,600);
  
  pixelDensity(displayDensity());
  
  videoExport = new VideoExport(this, "010.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  frameRate(30);
  
  for(int i=0; i<num; i++) {
    walkers.add(new Walker());
  }
  
}

void draw() {  
  background(255);
  
  for(Walker w: walkers) {
    w.update();
    w.display();
  }
  if (recording) {
    videoExport.saveFrame();
  }
}

void keyPressed() {
  if (key == ' ') {
    recording = !recording;
  }
}
