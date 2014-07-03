class sphCoord {
  float r;
  float theta; //0 to pi
  float phi; //o to 2*PI
  float x, y, z;
  PVector cartV;

  sphCoord(float t, float p, float r){
    this.r = r;
    this.theta = t;
    this.phi = p;
  }
  
  sphCoord(PVector v) {
    this.x = v.x;
    this.y = v.y;
    this.z = v.z;
    this.cartV = v;

    this.r = sqrt(v.x*v.x + v.y*v.y + v.z*v.z);

    this.phi = acos(v.z/this.r); 
    
    if (v.x==0) {
      if (v.y >= 0) {
        theta = PI/2;
      } 
      else {
        theta = -PI/2;
      }
    }
    else {
      this.theta = atan2(v.y, v.x);
    }
    //println("x, y, z: " + v.x + " " + v.y + " " + v.z);
    //println("r, theta and phi: " + r + " " + theta + " " + phi);
  }

  PVector getPVector() {
    float x = this.r*sin(theta)*cos(phi);
    float y = this.r*sin(theta)*sin(phi);
    float z = r*cos(theta);
    cartV = new PVector(x, y, z);
    return cartV;
    //println("x, y, z: " + x + " " + y + " " + z);
  }
}

