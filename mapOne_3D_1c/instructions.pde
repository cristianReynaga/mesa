// Print pan & zoom instructions at bottom of screen
void instructions() {

  int d = day();    // Get current day of month, values from 1 - 31
  int m = month();  // Get current month, values from 1 - 12
  int y = year();   //Get current year

    // to convert month numbers to names
  String [] months = {
    "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
  };
  //println(months[m-1]);

  // display title and instructions
  textAlign(LEFT);
  textFont(instructions, 22);
  text("Map One: Path and Elevation (3D)", 0, height - 60, 0);
  text("Colour mapped to elevation", 0, height - 30, 0);
  textFont(instructions, 16);  
  text("1 November, 2011 to " + d + " " + months[m-1] + ", " + y, 0, height, 0);

  textAlign(RIGHT);
  text("Left mouse: pan and rotate.", width, height-26, 0);
  text("Right mouse or scroll wheel: zoom.", width, height, 0);
}

// Remove instructions once the mouse is pressed for rotate & zoom
void mousePressed() {
  fill(0);
  stroke(0);
}

