/*

 April 2018 month of code
 Something quick and easy
 Hexagons
 
 016

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

PVector start, end, control;

float a;
void setup() {

  size(600, 600, P3D);
  //pixelDensity(displayDensity());

  videoExport = new VideoExport(this, "out.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  frameRate(30);
   noFill();
   fx = new PostFX(this);
}

void draw() {
  
  background(0);  
  translate(width/2, height/2,-500);
  
  pushMatrix();
  rotateZ(a*100);
  strokeWeight(1);
  line(0,-100,0,-200);
  line(0,100,0,200);
  line(10,0,-10,0);
  line(0,-10,0,10);
  popMatrix();
  
  drawPoly(100,4);
  
  stroke(255);
  strokeWeight(2);
  for(int i=0; i < 100; i++) {
    rotateY(a+noise(a,i)/100);
    rotateZ(a+noise(a,i)/100);
    drawPoly(400,6);
  }
  a += 0.0001;
    
  if (recording) {
    videoExport.saveFrame();
  }
  
  fx.render()
    .bloom(.5,20,30)
    .compose();
}

void drawPoly(float rad, int sides) {
  
  float inc = TWO_PI/sides;
  
  pushMatrix();
  rotateZ(-PI);
  beginShape();
  for(int i=0; i<sides; i++){
    float x = sin(i*inc)*rad;
    float y = cos(i*inc)*rad;
    vertex(x,y);
  }
  endShape(CLOSE);
  popMatrix();
}

void drawSquare(int i) {
  float start = 250;
  float rad = i+start;
  beginShape();
  vertex(-rad,-rad);
  vertex(rad,-rad);
  vertex(rad,rad);
  vertex(-rad,rad);
  endShape(CLOSE);
}

void keyPressed() {
  if (key == ' ') {
    recording = !recording;
  }
}