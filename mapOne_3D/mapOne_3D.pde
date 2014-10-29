/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/47921*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
import tomc.gpx.*; //to parse GPX file
import peasy.*; //for mouse pan and zoom controls

//GLOBAL VARIABLES
PeasyCam cam; // PeasyCam object
PFont instructions; //text

//screen limits in lat, lon and elevation
float west = -79.43;
float east = -79.35;
float north = 43.679;
float south = 43.635;
float lowest = 50;
float highest = 200;

//screen display point coordinates
float screen_X;
float screen_Y;
float screen_Z;

//to draw lines in chronological order
int totalCount  = 0;
int toDrawCount = 0;

GPX gpx; // declare a GPX object

void setup() {
  size(900, 600, P3D);
  background(0);
  colorMode(HSB, 360, 100, 100);
  fill(180); //colour of title & instructions

  //initialize font for text
  instructions = loadFont("CenturyGothic-24.vlw");

  //initial peasycam settings
  cam = new PeasyCam(this, width/2, height/2, 0, width*0.6);
  cam.lookAt(width/2, height/2, 0);

  gpx = new GPX(this); //initialise the GPX object
  gpx.parse("combinedGPXdata.gpx"); // parse gpx data from the sketch data folder

  //total track point count - used to make animation loop after last point is drawn
  for (int i = 0; i < gpx.getTrackCount(); i++) {
    GPXTrack trk = gpx.getTrack(i);
    for (int j = 0; j < trk.size(); j++) {
      GPXTrackSeg trkseg = trk.getTrackSeg(j);
      for (int k = 0; k < trkseg.size(); k++) {
        totalCount++;
      }
    }
  }
  //println(totalCount);
} // end of setup

void draw() {
  background(0);
  noStroke();

  int count = 0;
  boolean finished = false;

  //get the X, Y and Z coordinates of point
  for (int i = 0; i < gpx.getTrackCount(); i++) {
    GPXTrack trk = gpx.getTrack(i);
    for (int j = 0; j < trk.size(); j++) {
      GPXTrackSeg trkseg = trk.getTrackSeg(j);
      for (int k = 0; k < trkseg.size(); k++) {
        GPXPoint pt = trkseg.getPoint(k);
        double ptEle = pt.ele;

        // map lat and long to height & width of screen display
        float screen_X = map((float)pt.lon, west, east, 0, width);
        float screen_Y = map((float)pt.lat, north, south, 0, height);

        //map elevation to appropriate vertical scale for z-axis
        float screen_Z = map((float)ptEle, lowest, highest, 0, 50);

        // call function to display the points
        drawPoints(screen_X, screen_Y, screen_Z, count > toDrawCount - 10);

        count ++;
        if (count > toDrawCount) {  
          finished = true;
          break;
        }
      }
      if (finished) { 
        break;
      }
    }
    if (finished) { 
      break;
    }
  }

  //controls speed that the points are drawn
  toDrawCount += 4;

  //creates continuous loop
  if (count >= totalCount) {
    toDrawCount = 0;
  }

  // display title & instructions
  instructions();
}

