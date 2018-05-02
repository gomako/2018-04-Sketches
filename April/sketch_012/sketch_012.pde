/*

 April 2018 month of code
 Orbiting things
 012

*/
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

import com.hamoid.*;
VideoExport videoExport;

ArrayList<Planet> planets = new ArrayList();
int num = 1;
color[] colors = {#5c6565, #bc9e7f, #3b5e79, #d9df85, #906b74, #d6d495, #de5e4c, #d5497f, #d58b7d};
int border = 30;
Boolean recording = true;

void setup() {
  
  size(600,600,P3D);
  
  pixelDensity(displayDensity());
  
  videoExport = new VideoExport(this, "012.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  frameRate(30);
  noStroke();
  for(int i=0; i<num; i++) {
    planets.add(new Planet());
  }
  fx = new PostFX(this);  
}

void draw() {  
  background(42);
  
  for(Planet p: planets) {
    p.update();
    p.display();
  }
  
  // add bloom filter
  fx.render()
    //.sobel()
    .bloom(0.5, 20, 30)
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