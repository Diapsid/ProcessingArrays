float freq = 30; //size and density of circles coming off radiators
int temp = int(5); //number of radiators
Point[] ps = new Point[temp]; //initialize Point array
float[] br = new float[ps.length]; //this will later hold the amplitude of the field strength at each pixel due to each radiator
float dx = 360/(2*freq); //c = 360, dx = 0.5lambda = c/2f
float bright=0; //will later hold the total amplitude at each pixel
void setup(){
  size(800, 800, P2D); //P2D will show the image faster, but FX2D will run the animation much faster
  background(0);
    for (int i = 0; i<ps.length; i++) { 
      if (i>0) {
        ps[i] = new Point(i*dx+(width/2)-ps.length*dx/2, height/2, 0); //for inter-element phases, set third argument to the desired phase
      } else {
        ps[i] = new Point(i*dx+(width/2)-ps.length*dx/2, height/2, 0); //reference radiator, phase should be 0
      }
    }
  frameRate(1000);
}

void draw() {
  float t = float(frameCount)/6; //choppiness of animation.
  for (int i = 0; i<width; i++) {//iterate through each pixel
    for (int j = 0; j<height; j++) {
      for (int k = 0; k<ps.length; k++) { //iterate through array of radiators
        br[k] = 128*cos(freq*radians(dist(ps[k].x, ps[k].y, i, j)-t)+ps[k].phase)/(sq(dist(ps[k].x, ps[k].y, i, j))/2000); // basic cos/(r^2)
        bright += br[k]; //sum up the amplitude at each pixel due to each radiator
      }
      bright = 3*bright; //scale of displayed array factor
      if (bright<=30) { //set a cut off for brightness
        bright = 0;
      } else {
        bright = 80*log10(bright); //take the log of the pattern
      }
      stroke(bright); 
      point(i, j);
      bright = 0;
    }
  }
}

class Point { //each radiator has a coordinate location and a phase. Can easily add in an amplitude later as well for more design flexibility
  float x;
  float y;
  float phase;

  Point(float xt, float yt) { //constructor for default phase of 0 
    x = xt;
    y = yt;
  }
  Point(float xt, float yt, float pt) { //constructor if a different phase value is desired
    x = xt;
    y = yt;
    phase = pt;
  }
}

float log10(float num) { 
  return(log(num)/log(10));
}
