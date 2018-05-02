/*

 April 2018 month of code
 003 - Cherry Blossom
 
 */

// FX
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
PostFX fx;


// Basic setup
int num = 500;
Branch[] branches = new Branch[10];
Blossom[] blossom = new Blossom[num];

// Create forces
PVector gravity = new PVector(0, 0.05);
float zOff;

color[] colors = {#e1b9e3, #c62f5e, #e29bbd, #f8d8f3};

float border = 100;
float rad = 100;

boolean recording = false;

void setup() {  
  size(600, 600, P2D);
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 100, 100);
  for (int i = 0; i < blossom.length; i++ ) {    
    blossom[i] = new Blossom(random(width), random(height));
  }
  for (int i = 0; i < branches.length; i++ ) {    
    branches[i] = new Branch(random(width), 0);
  }
  fx = new PostFX(this);  
}


void draw() {

  background(199, 100, 83);

  zOff += 0.01;

  for (int i = 0; i < branches.length; i++ ) {    
    branches[i].update();
    branches[i].display();
  }


  for (int i = 0; i < blossom.length; i++ ) {

    float xOff = blossom[i].pos.x / width;
    float yOff = blossom[i].pos.y / height;
    float wAngle = noise(xOff, yOff, zOff);
    PVector wind = PVector.fromAngle(wAngle);
    wind.mult(0.1);

    blossom[i].applyForce(gravity);
    blossom[i].applyForce(wind);
    blossom[i].update();
    blossom[i].display();
  }

  fx.render()
    .bloom(0.5, 20, 40)
    .compose();

  if(recording) {
  saveFrame("output/frame_###.png");
  }
}


void keyPressed() {
  
  recording = !recording;

}