// Effects
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
PostFX fx;

// Recording
import com.hamoid.*;
VideoExport videoExport;
Boolean recording = false;

int border = 20;
color[] colors = {#5c6565, #bc9e7f, #3b5e79, #d9df85, #906b74, #d6d495, #de5e4c, #d5497f, #d58b7d};

int num = 100;
Boof boofs[] = new Boof[num];
Attractor attractors[] = new Attractor[3];



void setup() {

  size(600, 600, P3D);
  initVidAndFX();

  for (int i=0; i<boofs.length; i++) {
    boofs[i] = new Boof();
  }

  for (int i=0; i<attractors.length; i++) {
    attractors[i] = new Attractor();
  }

  rectMode(CENTER);
  noStroke();
}


void draw() {

  background(42);

  for (int i=0; i<attractors.length; i++) {
    attractors[i].display();
  }

  for (int i=0; i<boofs.length; i++) {

    PVector force;

    for (int j=0; j<attractors.length; j++) {
      force = attractors[j].attract(boofs[i]); 
      boofs[i].applyForce(force);
      boofs[i].update();
    }

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
