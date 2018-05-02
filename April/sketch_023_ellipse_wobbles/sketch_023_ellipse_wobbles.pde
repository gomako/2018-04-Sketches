/*

 April 2018 month of code
 ellipse offsets
 
 023
 
 */

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
int num = 30;
Boof[] boofs = new Boof[num];

// Border if using
int border = 10;

float a;

void setup() {

  size(600, 600, P2D);
  // Init video export
  videoExport = new VideoExport(this, "out.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  frameRate(30);

  // Init effetcs
  fx = new PostFX(this);
  noFill();

  for (int i=0; i<boofs.length; i++) {
    boofs[i] = new Boof(i);
  }

}

void draw() {
  background(42);


  translate(width/2, height/2);

  for (int i=0; i<boofs.length; i++) {
    boofs[i].display();
  }

  //fx.render()
  //  .bloom(.5, 20, 30)
  //  .compose();


  if (recording) {
    videoExport.saveFrame();
  }
}




void keyPressed() {

  if (key == ' ') {
    recording = !recording;
  }
}
