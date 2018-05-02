class Boof  {

    float count = 0;
    float min = 100.0;
    float step = 1;
    float a = 61.8;
    float sw = 4; //random(1,10);
    color clr = colors[(int)random(colors.length)];
    int[] dirs = {0,45,135,180,225,315};
    PVector pos;
    PVector vel;

    Boof () {
      float bounds = (width-border*2)/min;
      
      
      float x = random(bounds)*min+border;
      float y = random(bounds)*min+border;
      pos = new PVector(x, y);
      vel = new PVector(0,-1); 
      vel.rotate(radians(dirs[(int)random(dirs.length-1)]));       
    }

    void display() {
      noFill();
      stroke(clr,a);
      strokeWeight(sw);
      point(pos.x,pos.y);
      pos.add(vel);

      count+=step;
      changeDir();
      edges();
    }

    void changeDir() {
      if(count>min) {
        float chance = random(1);
      if(chance > 0.3333 && chance <= 0.666) {
        vel.rotate(radians(45));
      } else if(chance > 0.666) {
        vel.rotate(radians(-45));
      } 
      if(vel.heading() == 0 || vel.heading() == PI || vel.heading() == 5.960465E-8) vel.rotate(radians(45));
        count = 0;
      }
      min = (int)random(5,10)*10;
    }

    void edges() {
      if(pos.y > height-border ) pos.y = border;
      if(pos.y < border ) pos.y = height-border;
      if(pos.x > width-border ) pos.x = border;
      if(pos.x < border ) pos.x = width-border;    
    }

}