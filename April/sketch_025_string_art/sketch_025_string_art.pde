/*

 April 2018 month of code
 Nails in the board
 
 025
 
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
Boolean s = true;
int num = 66;
PVector[] pointsA = new PVector[num];
PVector[] pointsB = new PVector[num];

// Palette
color[] colors = {#5c6565, #bc9e7f, #3b5e79, #d9df85, #906b74, #d6d495, #de5e4c, #d5497f, #d58b7d};
// Select a colour
// color clr = colors[(int)random(colors.length)];


int sq = 400;
int i = 0;
int start = 0;
int end = 0;

void setup() {  
  size(600,600,P3D);
  colorMode(HSB,1);
  // Init the video and FX
  initVidAndFX();
  
  float xStep = (sq/2)/pointsA.length;
  float yStep = sq/num;
  
  for(int i=0; i<pointsA.length; i++) {
    float x = i * xStep;
    float y = sq - i * yStep;
    pointsA[i] = new PVector(x,y);
    
    x = (sq / 2) + (i+1) * xStep;
    y = (i+1) * yStep;
    pointsB[i] = new PVector(x,y);
  }
}

void draw() {
  
  background(.16);
  noFill();
 
  translate(-sq/2,-sq/2);
  translate(width/2, height/2, 100);
  
  
  for(int j=start; j<end; j++) {
    stroke(map(j,0,end,0,1),1,.9);
    line(pointsA[j].x,pointsA[j].y, pointsB[j].x,pointsB[j].y);
  }
  
  
  if(end < num) {
    end++;
  }
  if(end == num) {
    if(start<num) {
      start++;
    }
  }
  
  if(start == num && end == num) {
    start = 0;
    end = 0;
    if(recording == true && s == false) {
      recording = false;
    } else {
      recording = true;
      s = false;
    }
    
  }
  
  
  
  
  
  
  
  // Do all the video and FX stuff
  doVidAndFX();
  
}










/// Boilerplate

void doVidAndFX() {
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
