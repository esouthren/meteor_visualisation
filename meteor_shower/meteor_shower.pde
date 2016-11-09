// Author: Eilidh Southren
// RGU Hackathon 2016
//
// Visualisation of meteor landing data from NASA


Table table;
int scope = 13000;
PImage bg;
PImage meteorImage;
int circleX;
int circleY;
int circleSize;
boolean circleOver = false;
boolean doubleChecker = false;
int checkX;
int checkY;


int[] sizes = new int[scope];
String[] names = new String[scope];
String[] years = new String[scope];



Meteor[] meteors = new Meteor[scope];

void setup() {
  
    meteorImage = loadImage("meteor.gif");
    size(1200,700);
    bg = loadImage("space.jpg");
    frameRate(40);
    table = loadTable("meteor.csv", "header");
     
    ellipseMode(CENTER);
    
    for (int i = 0; i < scope; i++) {
      TableRow row = table.getRow(i);
      sizes[i] = (int)(row.getInt("mass (g)"))/40;
      names[i] = row.getString("mName");
      years[i] = row.getString("year");
      if (years[i].length() > 9) {
        years[i] = years[i].substring(6,10);
      }
    }
    
    for (int i = 0; i < scope; i++) {
      int xRan = (int)random(20,width-20);
      // cRan = random colour
      int cRan = 150;
      // fall = random fall speed
      double fall = random(0.3,3.0);
      meteors[i] = new Meteor(sizes[i], names[i], years[i], xRan, (0-(i*11)), cRan, fall, true);
    }
}


void draw() {
  
  background(bg);
  for (int i = 0; i < scope; i ++) {
    meteors[i].update();
  }
}
 


class Meteor {
  
  int size;
  String name;
  String year;
  int xPos;
  float yPos;
  int col;
  double fall;
  boolean drawCheck;
  
  public Meteor( int Asize, String Aname, String Ayear, int xxPos, float yyPos, int cRan, double fFall, boolean check) {
    
    size = Asize;
    name = Aname;
    year = Ayear; 
    xPos = xxPos;
    yPos = yyPos;
    col = cRan;
    fall = fFall;
    drawCheck = check;
  }
  
  void update() {
    
    boolean moving = true;
    doubleChecker = false;
    if (drawCheck == true) {
    if ((size < 150 ) && (size > 10)) {
      
      checkX = size*meteorImage.height/60;
      checkY = size*meteorImage.width/60; 
      imageMode(CENTER); 
      image(meteorImage, xPos, yPos, checkX, checkY);
      if ((mouseX > xPos-(checkX/2)) && (mouseX < xPos+(checkX/2))) {
        if ((mouseY > yPos-(checkY/2)) && (mouseY < yPos+(checkY/2))) {
          if (doubleChecker == false) {
          fill(230);
          rectMode(CENTER);
          rect(xPos+85, yPos+10, 180,55, 4);
        fill(0,0,0);
        textSize(14);
        text("Name: " + name, xPos+5, yPos);
        fill(0,0,0);
        text("Year: " + year, xPos+5, yPos+15);
        fill(0,0,0);
        float kg = size*40/1000;
        fill(0,0,0);
        text("Kilograms: " +kg, xPos+5, yPos+30);
        moving = false;
        
          }
       }
     }
     doubleChecker = false;
       if (moving == true) {
          yPos+=fall;
       }
    }
      if (yPos > (height+(size))) {
        drawCheck = false;
       // doubleChecker = false;
      }
    
    }
  }
}
  
