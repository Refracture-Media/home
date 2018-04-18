
int Y_AXIS = 1;
int X_AXIS = 2;
ArrayList<fracture> fractures = new ArrayList<fracture>();

int maxFractures=int(random(20,30));
int currentFracture;

color b1, b2;



void setup() {
  size( $(window).width(),$(window).height(),P3D );

  b1=color(#4ec9c5);
  b2=color(#215654);

}

void draw() {
  //setGradient(0, 0, width, height, b1, b2, Y_AXIS);
  //setGradient(width, 0, width, height, b2, b1, Y_AXIS);
  fill(#0e131a);
  stroke(#0e131a);
  strokeWeight(10);
  rect(0,0,width/30,height);
  rect(0,0,width,width/30);
  rect(width-width/30,0,width,height);
  rect(0,height-width/30,width,height);

  if(maxFractures>fractures.size()) {
    fractures.add(new fracture());
  }
  for(int i=0;i < fractures.size(); i++) {
    fracture x = fractures.get(i);
    currentFracture=i;
    x.update();
  }
}

class fracture {
  int start, end;
  int x1,x2,y1,y2;
  int timer;
  fracture() {
    start=int(random(0,width+height));
    for(int i=0; i<fractures.size(); i++) {
      fracture k = fractures.get(i);
      if(abs(start-k.fStart())<60) {
        start=int(random(2,width+height));
      }
    }

    end=int(random(0,width+height));
    for(int i=0; i<fractures.size(); i++) {
      fracture k = fractures.get(i);
      if(abs(end-k.fEnd())<60) {
        end=int(random(2,width+height));
      }
    }

    if(start<=width) {
      x1=start;
      y1=0;
    } else {
      x1=0;
      y1=start-width;
    }

    if(end<=width) {
      x2=end;
      y2=height;
    } else {
      x2=width;
      y2=end-width;
    }
    println(x1 + ", " + y1 + "; " + x2 + ", " + y2);
  }

  void update() {
    if(timer<10) {
      timer++;
    } else {
      fractures.remove(currentFracture);
    }
    if(x1==x2) {
      fractures.remove(currentFracture);
    }
    if(y1==y2) {
      fractures.remove(currentFracture);
    }
    /*pushMatrix();
    beginShape(LINES);
    fill(#0e131a);
    stroke(#0e131a);
    strokeWeight(10);
    vertex(x1,y1);
    vertex(x2,y2);
    popMatrix();
    endShape();*/
    line(x1,y1,x2,y2);
  }
  int fStart() {
    return start;
  }

  int fEnd() {
    return end;
  }
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}
