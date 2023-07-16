class ComplexNumber{
  
  double a, b;
  
  public ComplexNumber(double a, double b){
    this.a = a;
    this.b = b;
    
  }
  
  void multiply(ComplexNumber z) { // (a1+b1i)(a2+b2i) = a1a2 - b1b2 + i(a1b2 + b1a2) 
    double a_copy = this.a;
  
    this.a = this.a*z.a - this.b*z.b;
    this.b = a_copy*z.b + this.b*z.a;
  }
  
  void multiply (double d) {
    this.a *= d;
    this.b *= d;
  }
  
  void squared() { // (a+bi)(a+bi) = a^2 - b^2 i(2ab)
    double a_copy = this.a;
    
    this.a = this.a*this.a - this.b*this.b;
    this.b = 2*a_copy*this.b;
  }
  
  void add(double a2, double b2) {
    this.a += a2;
    this.b += b2;
  }
  
  void add(ComplexNumber z){
    this.a += z.a;
    this.b += z.b;
  }
  
  @Override
  public String toString() {
    if (this.b >= 0) {
      return this.a + "+" + this.b + "i";
    }
    return this.a + "" + this.b + "i";
  }
 
  
}
