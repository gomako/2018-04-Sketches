// Effects
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
PostFX fx;

// Recording
import com.hamoid.*;
VideoExport videoExport;
Boolean recording = false;

String s = "HAPPY BIRTHDAY JONATHAN";

int num = s.length() * 200;

Boof boofs[] = new Boof[num];

Attractor a;

//char[] a = s.toCharArray();

//PVector[] pos = new PVector[a.length];

void setup() {

  size(600, 600,P2D);
  initVidAndFX();
  int cindex = 0;
  for(int i=0; i<boofs.length; i++) {
    boofs[i] = new Boof(s.charAt(cindex));
    cindex++;
    if(cindex > s.length() - 1) cindex = 0;
  }
  a = new Attractor();
  
}


void draw() {
  
  background(42);
  
  for(int i=0; i<boofs.length; i++) {
    PVector force = a.attract(boofs[i]);
    boofs[i].applyForce(force);
    boofs[i].update();
    boofs[i].display();
  }
  doVidAndFX();
  
}


/// Boilerplate

void doVidAndFX() {
  fx.render()
    //.blur(10, 20, true)
    .bloom(.5, 10, 20)
    .rgbSplit(20)
    .noise(0.1, 10)
    .vignette(0.8, 0.1)
    .compose();


  if (recording) {
    videoExport.saveFrame();
  }
}

void initVidAndFX() {
  // Init video export
  videoExport = new VideoExport(this, "out.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  frameRate(30);

  // Init effetcs
  fx = new PostFX(this);
}


void keyPressed() {

  if (key == ' ') {
    recording = !recording;
  }
}
