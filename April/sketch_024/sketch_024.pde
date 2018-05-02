/*

 April 2018 month of code
 024
 Terrain moon trendy tumblr gif
 
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

// Palette
color[] colors = {#5c6565, #bc9e7f, #3b5e79, #d9df85, #906b74, #d6d495, #de5e4c, #d5497f, #d58b7d};

// Object setup
int rows;
int cols;
int w = 10;
int num;
Boof[] boofs;
float yrot;
float bounds = 80;
float yoff = 0.0;
float position = 0;
float speed = 0.02;

void setup() {

  size(600, 600, P3D);
  noStroke();
  rows = width/w;
  cols = height/w;
  // Init video export
  videoExport = new VideoExport(this, "out.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  frameRate(30);

  // Init effetcs
  fx = new PostFX(this);

  num = rows * cols;
  boofs = new Boof[num];

  // Init the boofs
  
  for (int y=0; y<cols; y++) {
    float xoff = 0.0;
    for (int x=0; x < cols; x++) {
      float h = map(noise(xoff, yoff), 0, 1, 0, bounds);  
      int offset = x + y*cols;
      boofs[offset] = new Boof(x, y, h);
      xoff += 0.1;
    }
    yoff += 0.1;  
  }
  
}

void draw() {

  background(42);
  
  moonMoon();

  position -= speed;
  moveTerrain(position);
  
  pushMatrix();
  translate(600, 300, -220);
  rotateZ(HALF_PI);
  rotateY(-1.3);
  
  for (int y=0; y<cols; y++) {
    for (int x=0; x < cols; x++) {
      int offset = y + x*cols;
      boofs[offset].display();
    }
  }
 
  popMatrix();

  fx.render()
    //.blur(10, 20, true)
    .bloom(.5, 10, 20)
    .rgbSplit(20)
    .noise(0.1, 10)
    .vignette(0.8,0.1)
    .compose();


  if (recording) {
    videoExport.saveFrame();
  }
}


void moveTerrain(float yoff) {
  for (int y = 0; y < rows; y++) {
    float xoff = 0.0;
    for (int x = 0; x < cols; x++) {
      float z = map(noise(xoff, yoff), 0, 1, 0, bounds);
      boofs[y+x*cols].update(z);
      xoff += 0.1;
    }
    yoff += 0.1;
  }
}

void moonMoon() {
  float base = 140;
  pushMatrix();
  translate(width/2, 120, -150);
  rotateZ(yrot);
  fill(map(noise(yrot), 0, 1, 100, 255));
  ellipse(0,0, base, base);
  fill(map(noise(yrot), 0, 1, 100, 230));
  ellipse(-114.5, 0, 38.1924, 38.1924);
  ellipse(114.5, 0, 38.1924, 38.1924);
  
  rotateZ(yrot*0.1);
  fill(map(noise(yrot), 0, 1, 100, 210));
  ellipse(-185.4, 0, 23.6029032, 23.6029032);
  ellipse(185.4, 0, 23.6029032, 23.6029032);
  
  noFill();
  stroke(42);
  line(-10,0,10,0);
  line(0,-10,0,10);
  ellipse(0,0, 61.8, 61.8);
  
  
  stroke(255, 50);
  ellipse(0,0,114.5*2,114.5*2);
  ellipse(0,0,185.4*2,185.4*2);
  noStroke();
  popMatrix();
  yrot += 0.01;
}

void keyPressed() {

  if (key == ' ') {
    recording = !recording;
  }
}
