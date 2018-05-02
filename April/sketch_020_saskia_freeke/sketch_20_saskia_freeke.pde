/*

 April 2018 month of code
 Inspired by Saskia Freeke https://www.instagram.com/sasjnl/
 
 020
 
 */
 
// Effects
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
PostFX fx;

// Recording
import com.hamoid.*;
VideoExport videoExport;
Boolean recording = true;



color[] colors = {#5c6565, #bc9e7f, #3b5e79, #d9df85, #906b74, #d6d495, #de5e4c, #d5497f, #d58b7d};
Boof[] boofs = new Boof[60];
int border = 60;

void setup() {
  size(600,600,P2D);
  
  videoExport = new VideoExport(this, "out.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  
  fx = new PostFX(this);
  
  frameRate(30);
  
  
  background(42);
  for (int i = 0; i < boofs.length; ++i) {
    boofs[i] = new Boof();
  }
  
}

void draw() {
  
  for (int i = 0; i < boofs.length; ++i) {
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