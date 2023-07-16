import java.lang.Math;

class Coordinate {

  double x, y;
  
  Coordinate(double x, double y) { 
    this.x = x;
    this.y = y;
  }
  
  void rotateAroundPoint(double px, double py, double rotateAngle) {
    double theta = Math.atan((this.y - py) / (this.x - px));
    
    if (this.x < px) {
      theta += Math.PI;
    }
    
    double dx = this.x - px;
    double dy = this.y - py;
    
    double r = Math.sqrt(dx*dx + dy*dy);
    
    double theta2 = theta + rotateAngle;
    
    this.x = r * Math.cos(theta2) + px;
    this.y = r * Math.sin(theta2) + py;
    
  }
  
}
