char[][] textCanvas; 
float[][] brightnessCanvas;
float maxBrightness = 1;

char[] brightnessMap = " `.-':_,^=;><+!rc*/z?sLTv)J7(|Fi{C}fI31tlu[neoZ5Yxjya]2ESwqkP6h9d4VpOGbUAKXHm8RD#$Bg0MNWQ%&@".toCharArray();

float RESOLUTION = 100;
int MAX_ITER = 100;
//double CENTER_X = -0.77568377;
//double CENTER_Y = 0.13646737;
//double CENTER_X = -0.10109636384562;

//double CENTER_X = 0;
//double CENTER_Y = 0.9562865108091

double CENTER_X = 0;
double CENTER_Y = 0;

float BRIGHTNESS_POWER = 1;

boolean BRIGHTNESS_MAP = false;

ComplexNumber julia_constant = new ComplexNumber(0, 0);
//BBox bbox = new BBox(-1.5, 1.5, 1.5, -1.5);
BBox bbox = new BBox(-2, 2, 2, -2);

int xChars, yChars;


void setup() {
  size(600, 600);
  colorMode(HSB, 255);
  background(255);
  xChars = round(RESOLUTION * (width/ (float) height));
  yChars = round(RESOLUTION);
  
  bbox.setCenter(CENTER_X, CENTER_Y);
 
  frameRate(60);
  //noLoop();
}

int generateBrightness(ComplexNumber cn) {
  int iter = diverge_mandelbrot(cn, MAX_ITER);
  return iter;
}

double doubleMap(double val, double min_val, double max_val, double new_min, double new_max){ 
  return val * (new_max - new_min) / (max_val - min_val) + new_min;
}

void generateBrightnessCanvas(double rotationAngle) {
  brightnessCanvas = new float[xChars][yChars];
  //int[][] iterCanvas = new int[xChars][yChars];
  //int localMaxIter = 0;
  
  for (int i = 0; i < xChars; i++) { 
    for (int j = 0; j < yChars; j++){ 
      double mappedX = doubleMap(i, 0, xChars-1,  bbox.x1, bbox.x2);
      double mappedY = doubleMap(j, 0, yChars-1, bbox.y1, bbox.y2);
      
      Coordinate coord = new Coordinate(mappedX, mappedY);
      coord.rotateAroundPoint(CENTER_X, CENTER_Y, rotationAngle);
      
      ComplexNumber c = new ComplexNumber(coord.x, coord.y);
      int iter = generateBrightness(c); 
      float brightness = constrain( pow(map(iter, 0, MAX_ITER, 0, 1), BRIGHTNESS_POWER) , 0, 1);
      
      brightnessCanvas[i][j] = brightness;
      //print(brightness + ",");
      
      
    }
    //println();
  }

}

void generateTextCanvas() {
  textCanvas = new char[xChars][yChars];
  maxBrightness = 0;
  
  if (BRIGHTNESS_MAP) {
    for (int i = 0; i < xChars; i++) { 
      for (int j = 0; j < yChars; j++){ 
        
        if (brightnessCanvas[i][j] > maxBrightness) {
          maxBrightness = brightnessCanvas[i][j];
        }
        
      }
    }
  } else {
    maxBrightness = 1;
  }
  
 
  for (int i = 0; i < xChars; i++) { 
    for (int j = 0; j < yChars; j++){ 
      textCanvas[i][j] = brightnessToChar(brightnessCanvas[i][j], maxBrightness);
      
    }
  }

}

char brightnessToChar(float brightness, float maxBrightness) {
  
  float index = map(brightness, 0, maxBrightness, 0, (float) brightnessMap.length-1);
  
  int indexMap;
  if ( 0.03 < index && index < 1) {
    indexMap = ceil(index);
  } else { 
    indexMap = round(index);
  }
    
  
  return brightnessMap[indexMap];
}

int diverge_mandelbrot(ComplexNumber c, int max_iter) {
  ComplexNumber z = new ComplexNumber(0, 0);
  z.add(c);
  for (int i = 0; i < max_iter; i++) {
    if (z.a * z.a + z.b * z.b >= 4){ 
      //println(c.toString() + " diverges at " + i);
      return i;
    }
    z.squared();
    z.add(c);
    
  }
  return 0;
}

int diverge_julia(ComplexNumber z, int max_iter) {
    for (int i = 0; i < max_iter; i++) {
      
      if (z.a * z.a + z.b * z.b >= 4){ 
        return i;
      }
      
      z.squared();
      z.add(julia_constant);
    
  }
  return 0;
  
}

void displayTextCanvas() {
  textAlign(CENTER, CENTER);
  textSize(1.1 * (width + height)/2.0 / RESOLUTION);
  
  for (int i = 0; i < xChars; i++) { 
    for (int j = 0; j < yChars; j++){ 
      float xOffset = width/ (float)xChars / 2.0; 
      float yOffset = height/ (float)yChars / 2.0;
      
      if (BRIGHTNESS_MAP) {
        fill( map(brightnessCanvas[i][j], 0, maxBrightness, 0, 255), 255, 255);
      } else {
        fill( map(brightnessCanvas[i][j], 0, 1, 0, 255), 255, 255);
      }
      text( textCanvas[i][j], 
        width * (i/ (float) xChars) + xOffset,
        height * (j/ (float) yChars) + yOffset/2.
      );
    }
  }
  
}



double angle = 0;
double theta = 0;

void draw() {
  background(0); 
  fill(255);
  
  julia_constant = new ComplexNumber( Math.cos(theta), Math.sin(theta)) ;
  julia_constant.multiply(0.7885);
  //println("julia:", julia_constant);
  
  generateBrightnessCanvas(angle);
  generateTextCanvas();
  displayTextCanvas();
 
  bbox.dilate(0.95 );
  angle += 0.05d;
   
  //bbox.dilate(0.994883803108);
  //angle += 0.005d;
  
  
  println("bbox:", bbox.x1, bbox.y1);
  
  //saveFrame("mandel_color/mandel_1_######.png");
  
  //noLoop();
  
  theta += 0.1;
  
  
}
