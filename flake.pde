class flake {
  float x, y, z; //position
  PVector viewerVec;
  PVector posVec;
  PVector normalVec;//normal vector of the surface;
  //PShape currS; //reflected surface, triangle, say.
  float radius=10; //radius of circular flake
  float decayAngle = PI/10;
  float starR = 0;
  PVector modelPos;
  float glitterSize =0;

  flake(PVector pos) {
    this.posVec = pos;
  }

  flake(PVector pos, PVector normal) {
    this.posVec = pos;
    this.normalVec = normal;
  }

  void drawMe() {
    glitterSize = 0;

    sphCoord normal = new sphCoord(normalVec);
    pushMatrix();
    translate(posVec.x, posVec.y, posVec.z);
    rotateZ(PI/2);
    rotateZ(normal.theta);
    rotateX(normal.phi);
    noStroke();
    float a = getIntensity();
    //println("alpha: " + a);
    fill(255, a);
    ellipse(0, 0, this.radius, this.radius);
    if (a > 150) {
      pushMatrix();
      float p = random(2*PI);
      translate(cos(p)*this.radius/2, sin(p)*this.radius/2, 0);
      modelPos = getModelVec(new PVector(0, 0, 0));
      glitterSize = 2*radius*a/255;
      popMatrix();
    }
    popMatrix();
  }


  float getViewAngle() {
    modelPos = getModelVec(posVec);
    PVector modelNormal = getModelVec(PVector.add(normalVec, posVec));
    modelNormal.sub(modelPos);

    PVector v1 = new PVector (viewerVec.x - modelPos.x, 
    viewerVec.y - modelPos.y, viewerVec.z - modelPos.z); 
    v1.normalize();
    //println("viewer: " + v1.x + " " + v1.y + " " + v1.z);
    float ang = PVector.angleBetween(v1, modelNormal);
    return min(abs(ang-PI), abs(ang+PI), abs(ang));
  }

  //return reflection intensity: i.e., color and opacity
  //OR: just change opacity from 0 (transparent to 255);
  float getIntensity() {
    float intensity = 255;
    float dist = PVector.dist(viewerVec, posVec);
    float angle = getViewAngle();
    //println("glitter angle: " + degrees(angle));
    //println("decay angle: " + degrees(decayAngle));
    intensity = 255*(exp(-abs(angle/decayAngle)));
    return intensity;
  }

  PVector getModelVec(PVector v) {
    float mx = modelX(v.x, v.y, v.z);
    float my = modelY(v.x, v.y, v.z);
    float mz = modelZ(v.x, v.y, v.z);
    return new PVector(mx, my, mz);
  }
}

