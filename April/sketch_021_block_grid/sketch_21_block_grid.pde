/*

 April 2018 month of code
 Blocky
 
 021
 
 */

// Easing
import org.gicentre.utils.move.Ease;

// Effects
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
PostFX fx;

// Recording
import com.hamoid.*;
VideoExport videoExport;
Boolean recording = false;

// Palette
color[] colors = {#5c6565, #bc9e7f, #3b5e79, #d9df85, #906b74, #d6d495, #de5e4c, #d5497f, #d58b7d};
// Select a colour
// color clr = colors[(int)random(colors.length)];

// Object setup
int num = 20;
Boof[] boofs = new Boof[num];
// Border if using
int border = 0;

void setup() {

  size(600, 600, P2D);
  noFill();
  
  // Init video export
  videoExport = new VideoExport(this, "out.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  frameRate(30);

  // Init effetcs
  fx = new PostFX(this);

  for (int i = 0; i < boofs.length; ++i) {
    boofs[i] = new Boof();
  }
}

void draw() {
  background(42);

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
