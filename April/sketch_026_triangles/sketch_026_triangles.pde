/*

 April 2018 month of code
 More string art based stuff
 
 026
 
 */
import wblut.nurbs.*;
import wblut.hemesh.*;
import wblut.core.*;
import wblut.geom.*;
import wblut.processing.*;
import wblut.math.*;

HE_Mesh mesh;
WB_Render3D render;


// Effects
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
PostFX fx;

// Recording
import com.hamoid.*;
VideoExport videoExport;
Boolean recording = false;

// Palette
color[] colors = {#5c6565, #bc9e7f, #3b5e79, #d9df85, #906b74, #d6d495, #de5e4c, #d5497f, #d58b7d};
// Select a colour
// color clr = colors[(int)random(colors.length)];

// Object setup
int num = 0;


float a;

void setup() {

  size(600, 600, P3D);
  // Init the video and FX
  initVidAndFX();
  noFill();
  render=new WB_Render3D(this);
  HEC_Geodesic creator=new HEC_Geodesic().setRadius(rad*.618);
  mesh=new HE_Mesh(creator);

  //general HEC_Creator settings in a separate chain 
  //creator.setCenter(100,-50,0).setZAngle(PI/3);
  creator.setZAngle(PI/2);

  // Create the mesh
  mesh=creator.create();
}

float rad = 200;
int res = 80;

void draw() {
  background(42);

  //stroke(200,50);
  //strokeWeight(3);

  noStroke();
  fill(200, map(res, 1, 100, 100, 10));


  translate(width/2, height/2);
  pushMatrix();
  for (float i=0; i<TWO_PI; i+=TWO_PI/res) {
    beginShape();
    vertex(0, -rad);
    vertex(rad, rad);
    vertex(-rad, rad);
    endShape(CLOSE);
    rotate(TWO_PI/res);
  }
  popMatrix(); 
  rad = map(sin(a), -1, 1, 100, 200);
  res = (int)map(sin(a), -1, 1, 1, 60);
  a+=0.1;



  rotateZ(a*0.05);

  noFill();
  strokeWeight(4);
  stroke(42, map(sin(a), -1, 1, 0, 100));
  arc(0, 0, rad+100, rad+100, 0, map(sin(a), -1, 1, 0, PI));
  arc(0, 0, rad+100, rad+100, PI, map(sin(a), -1, 1, PI, TWO_PI));

  rotateZ(QUARTER_PI);
  arc(0, 0, rad+160, rad+160, 0, map(sin(a), -1, 1, 0, PI));
  arc(0, 0, rad+160, rad+160, PI, map(sin(a), -1, 1, PI, TWO_PI));

  strokeWeight(1);



  HEM_Noise modifier = new HEM_Noise();
  modifier.setDistance(2);
  HE_Mesh copyMesh = mesh.scale(map(sin(a), -1, 1, .5, 1));
  copyMesh.modify(modifier);
  render.drawFaces(copyMesh);  




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
