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
int scl = 10;
float inc = 0.1;
float zoff = 0;
int num = 120;

Particle[] particles = new Particle[num];
PVector[] flowField;  

void setup() {
  
  videoExport = new VideoExport(this, "out.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  frameRate(30);
  
  
  //pixelDensity(displayDensity());
  size(600, 600, P3D);
  colorMode(HSB, 1);
  noFill();
  
  
  // Sort out the things
  thing = loadShape("thing.svg");
  int numChildren = thing.getChildCount();
  things = new PShape[numChildren];
  for(int i=0; i<things.length; i++) {
    things[i] = thing.getChild(i);
    things[i].disableStyle();
    things[i].translate(-16,-16);
    things[i].scale(.5);
  }

  cols = floor(width/scl);
  rows = floor(height/scl);
  flowField = new PVector[cols * rows];
  flowField();
  for (int i=0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
  
  
  fx = new PostFX(this);
  fx.preload(BloomPass.class);
  fx.preload(RGBSplitPass.class);
}

void draw() {

  background(0);

  flowField();


  for (int i=0; i < particles.length; i++) {
    particles[i].update();
    particles[i].draw();
  }

  

  fx.render()
    .bloom(.5,20,30)
    .rgbSplit(20)
    //.chromaticAberration()
    .compose();

  if (recording) {
    videoExport.saveFrame();
  }
}


void keyPressed() {

  if(key == ' ') {
    recording = !recording;
  }
  
}

void flowField() {
  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {

      float angle = noise(xoff, yoff, zoff) * TWO_PI;
      PVector v = PVector.fromAngle(angle);
      v.setMag(0.5);

      int index = x + y * cols;
      flowField[index] = v;

      xoff += inc;

      //pushMatrix();
      //stroke(0,50);
      //translate(x * scl, y * scl);
      //rotate(v.heading());
      //line(0,0,-scl,0);
      //popMatrix();
    }
    yoff += inc;
  }
  zoff += inc*.1;
}