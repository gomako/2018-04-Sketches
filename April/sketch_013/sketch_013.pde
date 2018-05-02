/*

 April 2018 month of code
 Thalassaphobia / Tentacles
 013

*/
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;
import com.hamoid.*;
VideoExport videoExport;


PVector start, end, control;

float border = 100;

int num = 30;
Tentacle tentacles[] = new Tentacle[num];
color[] clrs = {#582A72,#9775AA,#764B8E};
Boolean recording = false;

void setup() {

  size(600, 600, P2D);
  //pixelDensity(displayDensity());
  noStroke();

  videoExport = new VideoExport(this, "012.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  frameRate(30);

  float space = width/num;
  
  for (int i=0; i<tentacles.length; i++) {
    tentacles[i] = new Tentacle(space*i+space/2, height);
  }
  
  fx = new PostFX(this);
}

void draw() {
  
  background(#121115);
   
  translate(0,70);
  
  for (int i=0; i<tentacles.length; i++) {
    tentacles[i].update();
    tentacles[i].display();
  }
  
  fx.render()
    //.bloom(.5,20,30)
    .vignette(.5,.4)
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


// This is the SECRET SAUCE!!!
PVector quadraticCurve(PVector start, PVector control, PVector end, float t) {
  float x1 = start.x;
  float y1 = start.y;
  float x2 = control.x;
  float y2 = control.y;
  float x3 = end.x;
  float y3 = end.y;

  float dt = 1 - t;
  float dtSq = dt * dt;
  float tSq = t * t;
  float x = dtSq * x1 + 2 * dt * t * x2 + tSq * x3;
  float y = dtSq * y1 + 2 * dt * t * y2 + tSq * y3;
  return new PVector(x, y);
}
