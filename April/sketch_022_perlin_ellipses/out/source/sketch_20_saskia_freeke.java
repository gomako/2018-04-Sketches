import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_20_saskia_freeke extends PApplet {


int[] colors = {0xff5c6565, 0xffbc9e7f, 0xff3b5e79, 0xffd9df85, 0xff906b74, 0xffd6d495, 0xffde5e4c, 0xffd5497f, 0xffd58b7d};
Boof[] boofs = new Boof[1];
int border = 100;

public void setup() {
  
  // background(#eeeeee);
  background(42);
  for (int i = 0; i < boofs.length; ++i) {
    boofs[i] = new Boof();
  }
}

public void draw() {
  for (int i = 0; i < boofs.length; ++i) {
    boofs[i].display();
  }
}
class Boof  {

    float count = 0;
    float min = 100.0f;
    float step = 1;
    float a = 100;//random(10,90);
    float sw = 2; //random(1,10);
    int clr = colors[(int)random(colors.length)];
    int[] dirs = {0,45,135,180,225,315};
    PVector pos;
    PVector vel;

    Boof () {
      float x = random(width/min)*min;
      float y = random(height/min)*min;
      pos = new PVector(x, y);
      vel = new PVector(0,-1); 
      vel.rotate(radians(dirs[(int)random(dirs.length-1)]));       
    }

    public void display() {
      noFill();
      stroke(clr,a);
      strokeWeight(sw);
      point(pos.x,pos.y);
      pos.add(vel);

      count+=step;
      changeDir();
      edges();
    }

    public void changeDir() {
      if(count>min) {
        float chance = random(1);
      if(chance > 0.3333f && chance <= 0.666f) {
        vel.rotate(radians(45));
      } else if(chance > 0.666f) {
        vel.rotate(radians(-45));
      } 
      if(vel.heading() == 0 || vel.heading() == PI) vel.rotate(radians(45));
        count = 0;
      }
      println("heading: "+vel.heading());
      min = (int)random(5,10)*10;
    }

    public void edges() {
      if(pos.y > height-border ) pos.y = border;
      if(pos.y < border ) pos.y = height-border;
      if(pos.x > width-border ) pos.x = border;
      if(pos.x < border ) pos.x = width-border;    
    }

}
  public void settings() {  size(600,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_20_saskia_freeke" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
