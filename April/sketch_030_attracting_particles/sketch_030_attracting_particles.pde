// Effects
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
PostFX fx;

// Recording
import com.hamoid.*;
VideoExport videoExport;
Boolean recording = false;

int border = 100;
color[] colors = {
    #5c6565, 
    #bc9e7f, 
    #3b5e79, 
    #d9df85, 
    #906b74, 
    #d6d495, 
    #de5e4c, 
    #d5497f, 
    #d58b7d
  };

int num = 200;
Boof boofs[] = new Boof[num];
float G = 0.5;

void setup() {
  size(600, 600, P3D);
  initVidAndFX();
  for (int i=0; i<boofs.length; i++) {
    boofs[i] = new Boof();
  }
  strokeWeight(3);
}


void draw() {

  background(42);
  
  for (int i=0; i<boofs.length; i++) {
    for (int j=0; j<boofs.length; j++) {
      if(i != j) {
        PVector force = boofs[j].attract(boofs[i]);
        boofs[i].applyForce(force);
        float d = dist(boofs[i].location.x, boofs[i].location.y, boofs[j].location.x, boofs[j].location.y);
        if(d < 60) {
          if(d < 30) {
            force.mult(-1);
            boofs[i].applyForce(force);
          }
          stroke(boofs[i].clr,map(d,0,60,200,0));
          line(boofs[i].location.x, boofs[i].location.y, boofs[j].location.x, boofs[j].location.y);
        }
      }
    }

    boofs[i].update();
    boofs[i].display();
  }

  doVidAndFX();
}


/// Boilerplate

void doVidAndFX() {
  fx.render()
    .bloom(.5, 10, 20)
    .rgbSplit(20)
    .noise(0.1, 10)
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
