import com.hamoid.*;

VideoExport videoExport;

import peasy.PeasyCam;


PeasyCam cam;

Boolean recording = false;

ArrayList<Voot> voots = new ArrayList();
color[] palette = {#5C4B51, #8CBEB2, #F2EBBF, #F3B562, #F06060};



float angle = 0;
float aVel = 0.06;
float w = 10;
float ma =atan(1/sqrt(2)); 
 float maxD;
 int count = 100;

 color[] cols = new color[count*count];
 

void setup() {
  size(600, 600, P3D);
  videoExport = new VideoExport(this, "009.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  frameRate(30);
  //noFill();
  noStroke();
  maxD = dist(0,0,600,600);
  cam = new PeasyCam(this, 1000);
  
  for (int j=0; j<count; j++) {
    for (int i=0; i<count; i++) {
      cols[i*j] = color(palette[(int)random(palette.length)]);
    }
  }
}

void draw() {

  background(42);
  
lights();
 
  translate(-(count*w)/2,0,0);
  rotateX(-PI/4);
  rotateY(PI/4);
  
  

  float offset = 0;

  for (int j=0; j<count; j++) {
    for (int i=0; i<count; i++) {
      pushMatrix();
      float d = dist(i*w,j*w,count*w/2, count*w/2);
      offset = map(d, 0, maxD,-1,1); 
      float a = angle + offset;
      float h = map(sin(a), -1, 1, 0, 300);
      float n = noise(i,j,a)*30;
      translate(i*w, n, j*w);
      ambient(cols[i*j]);
      box(w-1, h, w-1);
      popMatrix();
    }
  }
  angle += aVel;
  
  if (recording) {
    videoExport.saveFrame();
  }
}

void keyPressed() {
  if (key == ' ') recording = !recording;
}