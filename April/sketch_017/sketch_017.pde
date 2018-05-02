/*

 April 2018 month of code
 Some cirles
 
 017

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

int num = 100;

Boof[] boofs = new Boof[num];

void setup() {
  size(600,600,P3D);
  colorMode(HSB,1);
  for(int i=0; i<boofs.length; i++) {
    boofs[i] = new Boof(i);
  }
  noFill();
  fx = new PostFX(this);
}

void draw() {
  background(0,0,.3);
  translate(width/2, height/2,-100);
  for(int i=0; i<boofs.length; i++) {
    boofs[i].display();
  }
  
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
