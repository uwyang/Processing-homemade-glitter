//mouse click to turn on and off the twinkling effect. 

float csize = 20;
PVector viewerPos;
float viewerZ = 311.5;
float zSeedx = random(10);
float zSeedy = random(10);
float seedInc = 0.015;
int wflakenum;
int hflakenum;
flake[][] flakes;
float[][] glitters;
boolean twinkle =false;

void setup() {
  PVector currPos;
  PVector currNormal;
  background(0);
  size(800, 600, P3D);
  frameRate(10);
  wflakenum = ceil(width/csize);
  hflakenum = ceil(height/csize);
  flakes = new flake[wflakenum][hflakenum];
  
  background(255);
  zSeedx += seedInc;
  zSeedy += seedInc;
  makeDots();
  drawDots();
}


void draw() {
  background(255);
  zSeedx -= seedInc;
  zSeedy -= seedInc;
  makeDots();
  drawDots();
}


void makeDots() {
  float woffset = width - csize*wflakenum;
  float hoffset = height - csize*hflakenum;
  float currxseed = zSeedx;

  background(0);
  for (int i=0; i< wflakenum;i++) {
    currxseed += seedInc;
    float curryseed =zSeedy; 
    for (int j=0; j< hflakenum; j++) {
      curryseed+= seedInc;
      //currflake()
      //flakes[i][j] = currflake;
      float currx = - woffset/2 + i*csize;
      float curry = - hoffset/2 + j*csize;
      float currz = 500*noise(currxseed, curryseed);
      //println(currx + " " + curry + " " + currz);
      PVector pos = new PVector(currx, curry, currz);
      flake currFlake = new flake(pos);
      flakes[i][j] = currFlake;
      /*
      fill(192, 0, 0, 50);
       noStroke();
       ellipse(0, 0, csize/2, csize/2);
       */
    }
  }

  for (int i=1; i< wflakenum-1;i++) {
    for (int j=1; j< hflakenum-1; j++) {
      PVector v = flakes[i][j].posVec;
      PVector v1 = flakes[i-1][j-1].posVec.get();
      v1.sub(flakes[i+1][j+1].posVec);
      PVector v2 = flakes[i+1][j-1].posVec.get();
      v2.sub(flakes[i-1][j+1].posVec);
      PVector v3 = v1.cross(v2);
      v3.normalize();
      flakes[i][j].normalVec = v3;
      flakes[i][j].radius = csize/2;
    }
  }
}

void drawDots() {
  float starSize;
  for (int i=1; i< wflakenum-1;i++) {
    for (int j=1; j< hflakenum-1; j++) {
      flake currFlake = flakes[i][j];
      currFlake.viewerVec = new PVector(0, 0, -311.5);
      currFlake.drawMe();
      starSize = currFlake.glitterSize;
      if (starSize >0) {
        pushMatrix();
        translate(currFlake.modelPos.x, currFlake.modelPos.y, currFlake.modelPos.z);
        if(twinkle){
        drawStar(starSize);
        }
        //println(i + " " + j + " " +currFlake.glitterSize);
        //printVecPos(currFlake.modelPos);
        //printVecPos(currFlake.posVec);
        popMatrix();
      }
    }
  }
}

void printVecPos(PVector v) {
  println("positioned at: " + v.x + " " + v.y + " " + v.z);
}

void drawStar(float size) {
  float initSize = size*100/100;
  float r = size*22/100;
  noStroke();
  fill(0, 50, 150, 200);
  drawAnyStar(initSize-r, r);
  fill(50, 100, 200, 200);
  drawAnyStar(initSize-2*r, r);
  fill(100, 150, 250, 200);
  drawAnyStar(initSize-3*r, r);
  fill(255, 200);
  drawAnyStar(initSize-4*r, r);
}


void drawAnyStar(float starSize, float r) {
  beginShape();
  vertex(0, starSize);
  bezierVertex(0, -r, r, 0, -starSize, 0);
  bezierVertex(r, 0, 0, r, 0, -starSize);
  bezierVertex(0, r, -r, 0, starSize, 0);
  bezierVertex(-r, 0, 0, -r, 0, starSize);
  endShape();
}

void mouseClicked(){
  println("mouse clicked");
  twinkle = ! twinkle;
  saveFrame("glitter###.jpg");
}

void keyPressed(){
  if(key == ENTER){
    saveFrame("glitter###.jpg");
  }
}
