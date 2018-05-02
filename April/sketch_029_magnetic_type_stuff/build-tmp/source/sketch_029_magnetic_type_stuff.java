import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ch.bildspur.postfx.builder.*; 
import ch.bildspur.postfx.pass.*; 
import ch.bildspur.postfx.*; 
import com.hamoid.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_029_magnetic_type_stuff extends PApplet {

// Effects



PostFX fx;

// Recording

VideoExport videoExport;
Boolean recording = false;

int border = 100;
int[] colors = {0xff5c6565, 0xffbc9e7f, 0xff3b5e79, 0xffd9df85, 0xff906b74, 0xffd6d495, 0xffde5e4c, 0xffd5497f, 0xffd58b7d};

int num = 1;
Boof boofs[] = new Boof[num];
Attractor a, moon;
float orbitRad = 200;
PVector moonPos = new PVector(300,100);
float aVel = 0;

public void setup() {
  
  initVidAndFX();
  for (int i=0; i<boofs.length; i++) {
    boofs[i] = new Boof();
  }
  a = new Attractor(300,300, true, 100); // Attractor
  moon = new Attractor(moonPos.x, moonPos.y, false, 30);
  strokeWeight(2);
}


public void draw() {

  background(255);

  a.display();
  
  for (int i=0; i<boofs.length; i++) {

    PVector force;
    force = a.attract(boofs[i]); 
    boofs[i].applyForce(force);
    boofs[i].update();
    boofs[i].display();

    if(dist(boofs[i].location.x, boofs[i].location.y, a.location.x, a.location.y) < a.mass/2) {
      a.move();
      boofs[i].eat();
    }

  }

  // doVidAndFX();
}


/// Boilerplate

public void doVidAndFX() {
  fx.render()
    //.blur(10, 20, true)
    .bloom(.5f, 10, 20)
    .rgbSplit(20)
    .noise(0.1f, 10)
    .vignette(0.8f, 0.1f)
    .compose();


  if (recording) {
    videoExport.saveFrame();
  }
}

public void initVidAndFX() {
  // Init video export
  videoExport = new VideoExport(this, "out.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  frameRate(30);

  // Init effetcs
  fx = new PostFX(this);
}


public void keyPressed() {

  if (key == ' ') {
    recording = !recording;
  }
}
class Attractor {
  float mass;
  PVector location;
  float G;
  boolean attracting = true;
 
  Attractor(float x, float y, boolean _attracting, float _mass) {
    attracting = _attracting;
    location = new PVector(x,y);
    mass = _mass;
    G = 0.9f;
  }
 
  public PVector attract(Boof m) {
    PVector force = PVector.sub(location,m.location);
    float distance = force.mag();
    distance = constrain(distance,5.0f,25.0f);
    force.normalize();
    float strength = (G * mass * m.mass) / (distance * distance);
    if(attracting) {
      force.mult(strength);
    } else {
      force.mult(-strength);
    }
    
    return force;
  }

  public void move() {
    location = new PVector(random(border, width-border), random(border, height-border));
    mass = random(10, 50);
  }
 
  public void display() {
    noStroke();
    if(attracting) {
      fill(0,200);
    } else {
      fill(42,150);
    }
    ellipse(location.x,location.y,mass,mass);
  }
}
class Boof {

  PVector location, velocity, acceleration;
  float mass;
  ArrayList<PVector> tail = new ArrayList();
  int clr = color(42);//colors[(int)random(colors.length)];
  int tNum = 10;
  int count = 0;
  float headSize;

  Boof() {
    mass = random(0.1f, 1);
    headSize = 10 * mass;
    location = new PVector(random(width), random(height));
    velocity = new PVector(random(-1,1),random(-1,1));
    acceleration = new PVector(0, 0);
    for (int i = 0; i < tNum; ++i) {
      tail.add(location.copy());
    }
  }

  public void eat() {
    mass += 0.2f;
  }

  public void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  public void update() {
    tail.remove(0);
    tail.add(location.copy());  
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    edges();
  }

  public void display() {

    noFill();
    stroke(clr);

    pushMatrix();
    translate(location.x, location.y);
    ellipse(0,0,headSize*2,headSize*2);
    popMatrix();

    // beginShape();
    for (int i = tNum-1; i > 0; --i) {
      PVector p = tail.get(i);
      // THis isn't working.....
      PVector pp = tail.get(i-1);
      PVector hd = PVector.sub(p,pp);
      println(hd);
      float mult = 10;
      float sx = sin(hd.heading()) * mult + p.x;
      float sy = cos(hd.heading()) * mult + p.y;
      float ex = sin(hd.heading()) * -mult + p.x;
      float ey = cos(hd.heading()) * -mult + p.y;
      // println(heading.heading());
      // vertex(x,y);
      // vertex(p.x, p.y);
      
      line(sx,sy, ex, ey);

      point(p.x,p.y);



    }
    // endShape();

    pushMatrix();
    PVector end = tail.get(0);
    PVector endPrev = tail.get(1);
    PVector endRot = PVector.sub(end, endPrev);
    translate(end.x, end.y);
    rotate(endRot.heading() - HALF_PI);
    triangle(0,-headSize,-headSize,headSize, headSize,headSize);
    popMatrix();

  }

  public void resetTail() {
    tail.clear();
    for (int i = 0; i < tNum; ++i) {
      tail.add(location.copy());
    }    
  }

  public void edges() {
    if(location.x < 0) {
     location.x = width;
     resetTail();
    }
    if(location.x > width) {
     location.x = 0;
     resetTail();
    }
    if(location.y < 0) {
     location.y = height;
     resetTail();
    }
    if(location.y > height) {
     location.y = 0;
     resetTail();
    }
  }



}
  public void settings() {  size(600, 600, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_029_magnetic_type_stuff" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
