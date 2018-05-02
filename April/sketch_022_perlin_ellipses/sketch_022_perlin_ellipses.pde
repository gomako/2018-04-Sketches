/*

 April 2018 month of code
 -- Subject
 
 022
 
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
int num = 0;
Boof[] boofs;

int res = 60;

int rows, cols;

// Border if using
int border = 10;

float zOff;
float xOff = 0;
  float yOff = 0;
  float a;

void setup() {

  size(600, 600, P3D);
  colorMode(HSB,1);
  // Init video export
  videoExport = new VideoExport(this, "out.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  frameRate(30);

  // Init effetcs
  fx = new PostFX(this);

  background(42);

  rows = width/res;
  cols = height/res;


  boofs = new Boof[cols*rows];

  for (int y=0; y<cols; y++) {
    for (int x=0; x<cols; x++) {
      boofs[y*cols+x] = new Boof(x*res, y*res);
    }
  }
}

void draw() {
  background(0,0,0.1);

  translate(width/2, height/2, sin(a*2)*100);
  rotate(a);
  translate(-width/2, -height/2);
  
  
a += 0.01;  

  for (int y=0; y<cols; y++) {
    for (int x=0; x<cols; x++) {
      float n = noise(x, y, zOff);
      boofs[y*cols+x].display(n);
    }
  }

  zOff += 0.025;


fx.render()
    .blur((int)(10+sin(a)*10), sin(a)*20, true)
    .bloom(.5, 20, 30)
    .rgbSplit(20)
    .compose();


  if (recording) {
    videoExport.saveFrame();
  }
}




void keyPressed() {

  if (key == ' ') {
    recording = !recording;
  }
}
