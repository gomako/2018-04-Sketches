import com.hamoid.*;

VideoExport videoExport;

Boolean recording = true;

Circle c;

ArrayList<Circle> circles = new ArrayList();
color[] palette = {#5C4B51, #8CBEB2, #F2EBBF, #F3B562, #F06060};


void setup() {
  size(600, 600);
  videoExport = new VideoExport(this, "008.mp4");
  videoExport.setFrameRate(30);
  videoExport.startMovie();
  frameRate(30);
}

void draw() {

  background(255);

  int count = 0;
  int total = 10;
  int attempts = 0;

  while (count < total) {

    Circle newC = newCircle();
    if (newC != null) {
      circles.add(newC);
      count++;
    }
    attempts++;
    if (attempts > 1000) {
      println("Fin");
      noLoop();
      break;
    }
  }

  for (Circle c : circles) {

    if (c.growing) {
      if (c.edges()) {
        c.growing = false;
      } else {
        c.grow();

        for (Circle other : circles) {
          if (c != other) {
            float d = dist(c.x, c.y, other.x, other.y);
            if (d < c.rad + other.rad) {
              c.growing = false;
              break;
            }
          }
        }
      }
    }  

    c.draw();
  }
  if(recording) {
    videoExport.saveFrame();
  }
}

void keyPressed() {
  if(key == ' ') recording = false;
}

Circle newCircle() {

  float x = random(width);
  float y = random(height);
  boolean valid = true;
  for (Circle c : circles) {
    float d = dist(x, y, c.x, c.y);
    if (d < c.rad) {
      valid = false;
      break;
    }
  }


  if (valid) {
    return new Circle(x, y);
  } else {
    return null;
  }
}
