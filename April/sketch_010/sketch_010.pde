/*

 April 2018 month of code
 EYEBALLZ
 010
 
 */

// Basic setup
import com.hamoid.*;
VideoExport videoExport;

int rad = 50;
float border = 50;
int cols;
int rows;

Boof[] boofs;
color[] colors = {#5c6565, #bc9e7f, #3b5e79, #d9df85, #906b74, #d6d495, #de5e4c, #d5497f, #d58b7d};

Boolean recording = false;

void setup() {  
  size(600, 600);
  pixelDensity(displayDensity());

  rows = (int)(width-border)/rad;
  cols = (int)(height-border)/rad;
  boofs = new Boof[rows*cols];
  
  for (int i=0; i < rows; i++) {
    for (int j=0; j < cols; j++) {
      boofs[i*cols+j] = new Boof(i*rad, j*rad);
    }
  }
  
  videoExport = new VideoExport(this, "010.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  frameRate(30);
}


void draw() {

  background(42);

  translate(border, border);

  for (int i = 0; i < boofs.length; i++ ) {    
    boofs[i].update();
    boofs[i].display();
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
