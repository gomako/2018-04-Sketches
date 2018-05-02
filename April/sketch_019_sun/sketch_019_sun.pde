/*

 April 2018 month of code
 A grid (or flow field) where the noise drives the contents
 
 018
 
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

PShape things[];

PShape thing;

int rows, cols;
int scl = 4;
float inc = 0.01;
float zinc = .01;
float zoff = 0;
int num = 120;


PVector[] flowField;  

PImage bg;

void setup() {

  videoExport = new VideoExport(this, "out.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  frameRate(30);

  bg = loadImage("blue.jpg");

  //pixelDensity(displayDensity());
  size(600, 600, P3D);
  colorMode(HSB, 1);
  noFill();


  // Sort out the things
  thing = loadShape("thing.svg");
  int numChildren = thing.getChildCount();
  things = new PShape[numChildren];
  for (int i=0; i<things.length; i++) {
    things[i] = thing.getChild(i);
    things[i].disableStyle();
    things[i].translate(-16, -16);
    things[i].scale(.5);
  }

  cols = floor(width/scl);
  rows = floor(height/scl);
  flowField = new PVector[cols * rows];
  flowField();


  fx = new PostFX(this);
  fx.preload(BloomPass.class);
  fx.preload(RGBSplitPass.class);
}

void draw() {

  background(0);
  //image(bg, 600, 600);
  fill(0.1, 1, 1);
  noStroke();
  ellipse(width/2, height/2, 400, 400);

  flowField();

  fx.render()
    .blur(100, 30, true)
    .bloom(.5, 20, 30)
    .rgbSplit(20)
    .compose();

  flowField();

  if (recording) {
    videoExport.saveFrame();
  }
}


void keyPressed() {

  if (key == ' ') {
    recording = !recording;
  }
}





void flowField() {


  float yoff = 0;
  float xoff = 0;
  for (int y = 0; y < rows; y++) {
    xoff = 0;
    for (int x = 0; x < cols; x++) {

      float angle = noise(xoff, yoff, zoff) * TWO_PI;
      PVector v = PVector.fromAngle(angle);
      v.setMag(0.5);

      int index = x + y * cols;
      flowField[index] = v;

      xoff += inc;

      if (inCircle(x, y, width/2, height/2, 400)) {
        pushMatrix();
        translate(x * scl, y * scl);
        fill(map(abs(v.heading()), 0, PI, 0,0.12), 1, map(abs(v.heading()), 0, PI, .1, .7), 0.5);
        ellipse(0, 0, scl, scl);
        popMatrix();
      }
    }
    yoff += inc;
  }
  zoff += zinc;
}

Boolean inCircle(float px, float py, float cx, float cy, float rad) {

  boolean d = dist(cx, cy, px*scl, py*scl) > rad/2;

  return !d;
}