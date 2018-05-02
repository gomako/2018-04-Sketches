class Boof {

  PVector pos = new PVector();
  float rad, a, speed, start, end;
  color clr;
  int index;
  
  Boof(int i) {    
    
    index = i;
    rad = 20;
    speed = 0.1;
    clr = colors[(int)random(0,colors.length)];
    
    // Magic grid layout 
    pos.x = (i % ((width-border)/rad))*rad;
    pos.x+=border/2;
    pos.y = floor(i/((width-border)/rad))*rad;
    pos.y+=border/2;
    
    start = 0;
    a = map(index,0,num,0,TWO_PI);
  }
  
  // Update the thing
  void update() {
    
    end = map(sin(a),-1,1,0,TWO_PI);
    a+=0.05;
   
  }
  
  
  // Draw the thing
  void display() {
   
    noStroke();
    
    pushMatrix();
    translate(pos.x+rad/2,pos.y+rad/2);
    rotate(-PI/2);
    fill(map(index, 0,num,0,1),1,1,1);
    arc(0,0, rad, rad, start, end);
    popMatrix();
    
    
    
  }
  
}