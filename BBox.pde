import java.lang.Math;

class BBox {
  
  double x1, y1, x2, y2;
  double center_x, center_y;

  public BBox(double x1, double y1, double x2, double y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    
    this.calcCenter();
  }
  
  void calcCenter() {
    this.center_x = (this.x2 - this.x1)/2.;
    this.center_y = (this.y1 - this.y2)/2.;
  }
  
  void setCenter(double x, double y) {
    double half_w = this.getWidth()/2.;
    double half_h = this.getHeight()/2.;
    
    this.x1 = x - half_w;
    this.y1 = y - half_h;
    
    this.x2 = x + half_w;
    this.y2 = y + half_h;
    
    this.center_x = x;
    this.center_y = y;
    
  }

  double getWidth() {
    return Math.abs(this.x2 - this.x1);    
  }
  double getHeight() {
    return Math.abs(this.y1 - this.y2);
  }
  
  void dilate(double factor) {
    double half_w = this.getWidth()/2. * factor;
    double half_h = this.getHeight()/2. * factor;
    
    this.x1 = this.center_x - half_w;
    this.y1 = this.center_y - half_h;
    
    this.x2 = this.center_x + half_w;
    this.y2 = this.center_y + half_h;
  }
}
