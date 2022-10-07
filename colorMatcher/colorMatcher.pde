Cell[] colorWells;
Cell[][] grid;
Selector[] rows;
Selector[] cols;
PImage target;
int tX;
int tY;
int score;
color[] fillColors;
boolean selected=false;
boolean rowSelected=false;
boolean colSelected=false;
int selectedCell=-1;
int selectedRow=-1;
int selectedCol=-1;
void setup()
{
  size(1400, 900);
  //QUESTION 1
  //color setup
  fillColors = new color[7];
  colorSetup();
  //setup the colorWells
  colorWells= new Cell[7];
  int wellX= 100;
  int wellY=50;
  for (int i=0; i<7; i++)
  {
    colorWells[i]= new Cell(wellX, wellY, fillColors[i]);
    wellX+=110;
  }

  //setup the color grid
  grid= new Cell[12][8];
  int gridY=200;
  float num=0;
  for (int i=0; i<12; i++)
  {
    int gridX=300;
    for (int j=0; j<8; j++)
    {
      grid[i][j] = new Cell(gridX, gridY, num);
      gridX+=51.5;
      num++;
    }
    gridY+=51.5;
  }

  //target image setup
  int image= (int)random(0,5);
  String filename= "target"+image+".png";
  target = loadImage(filename);
  tX= 1100;
  tY= 475;

  //row selectors setup
  rows= new Selector[12];
  int rowX=240;
  int rowY=200;
  int rowNumber=0;
  for (int i=0; i<12; i++)
  {
    rows[i]= new Selector(rowX, rowY, rowNumber);
    rowY+=50;
    rowNumber++;
  }

  //col selectors setup
  cols = new Selector[8];
  int colX=300;
  int colY=150;
  int colNumber=0;
  for (int i=0; i<8; i++)
  {
    cols[i]= new Selector(colX, colY, colNumber);
    colX+=50;
    colNumber++;
  }

  score=0;
}
void draw()
{
  background(0);
  //QUESTION 1
  colorWells();
  gridDisplay();
  targetDisplay();
  selectors();
  //QUESTION 5
  score();
}
//QUESTION 1
void colorWells()
{
  for (int i=0; i<7; i++)
  {
    colorWells[i].displayWells();
  }
}
//QUESTION 1
void gridDisplay()
{
  for (int i=0; i<12; i++)
  {
    for (int j=0; j<8; j++)
    {
      grid[i][j].display();
    }
  }
}
//QUESTION 1
void targetDisplay()
{
  imageMode(CENTER);
  image(target, tX, tY, 400, 600);
}
//QUESTION 3
void selectors()
{
  for (int i=0; i<12; i++)
  {
    rows[i].display();
  }
  for (int i=0; i<8; i++)
  {
    cols[i].display();
  }
}
//QUESTION 5
void score()
{
  fill(255);
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(32);
  rect(800, 825, 300, 50);
  fill(0);
  text("Num moves: "+ score, 800, 835);
}
//QUESTION 2
public int cellClicked()
{
  for (int i=0; i<12; i++)
  {
    for (int j=0; j<8; j++)
    {
      if (dist(mouseX, mouseY, grid[i][j].getX(), grid[i][j].getY())<25)
      {
        if (grid[i][j].isClicked()==false && selected==false)
        {
          grid[i][j].clicked(true);
          selectedCell=grid[i][j].getNumber();
          selected=true;
        } else if (grid[i][j].isClicked()==true)
        {
          grid[i][j].clicked(false);
          selectedCell=-1;
          selected=false;
        }
        return grid[i][j].getNumber();
      }
    }
  }
  return -1;
}
//QUESTION 3
public int rowClicked()
{
  for (int i=0; i<12; i++)
  {
    if (dist(mouseX, mouseY, rows[i].getX(), rows[i].getY())<30)
    {
      if (rows[i].isClicked()==false && rowSelected==false)
      {
        rows[i].clicked(true);
        selectedRow=rows[i].getNumber();
        rowSelected=true;
      } else if (rows[i].isClicked()==true)
      {
        rows[i].clicked(false);
        selectedRow=-1;
        rowSelected=false;
      }
      return rows[i].getNumber();
    }
  }
  return -1;
}
//QUESTION 3
public int colClicked()
{
  for (int i=0; i<8; i++)
  {
    if (dist(mouseX, mouseY, cols[i].getX(), cols[i].getY())<30)
    {
      if (cols[i].isClicked()==false && colSelected==false)
      {
        cols[i].clicked(true);
        selectedCol=cols[i].getNumber();
        println(selectedCol);
        colSelected=true;
      } else if (cols[i].isClicked()==true)
      {
        cols[i].clicked(false);
        selectedCol=-1;
        colSelected=false;
      }
      return cols[i].getNumber();
    }
  }
  return -1;
}
//QUESTION 4
public void colorClicked()
{
  for (int i=0; i<7; i++)
  {
    if (dist(mouseX, mouseY, colorWells[i].getX(), colorWells[i].getY())<50)
    {
      if (rowSelected==true || colSelected==true || selected==true)
      {
        score++;
      }
      color selectedColor = colorWells[i].getColor();
      //change selected cell
      if (selected==true)
      {
        for (int r=0; r<12; r++)
        {
          for (int c=0; c<8; c++)
          {
            if (grid[r][c].getNumber()==selectedCell)
            {
              grid[r][c].fillTile(selectedColor);
              grid[r][c].clicked(false);
              selectedCell=-1;
              selected=false;
            }
          }
        }
      }
      //change selected column
      if (colSelected==true)
      {
        for (int r=0; r<12; r++)
        {
          grid[r][selectedCol].fillTile(selectedColor);
        }
        cols[selectedCol].clicked(false);
        selectedCol=-1;
        colSelected=false;
      }
      //change selected row
      if (rowSelected==true)
      {
        for (int c=0; c<8; c++)
        {
          grid[selectedRow][c].fillTile(selectedColor);
        }
        rows[selectedRow].clicked(false);
        selectedRow=-1;
        rowSelected=false;
      }
      println("true");
    }
  }
}
void colorSetup()
{
  fillColors[0]=color(#d12020);
  fillColors[1]=color(#545cdc);
  fillColors[2]=color(#21af20);
  fillColors[3]=color(#f4ec74);
  fillColors[4]=color(#f59219);
  fillColors[5]=color(#b41cf4);
  fillColors[6]=color(#ffffff);
}
public void mouseClicked()
{
  //QUESTION 2
  println(cellClicked());
  //QUESTION 3
  println(rowClicked());
  println(colClicked());
  //QUESTION 4
  colorClicked();
}


//CLASSES

//this class controlls the tiles
public class Cell
{
  int x;
  int y;
  int type;
  int number;
  boolean clicked=false;
  boolean fillTile=false;
  color fillC;
  //used for color Wells
  public Cell(int x, int y, color fillC)
  {
    this.x=x;
    this.y=y;
    this.fillC=fillC;
  }
  public Cell(int x, int y, float number)
  {
    this.x=x;
    this.y=y;
    this.number=(int)number;
  }
  //used for color Wells
  public void displayWells()
  {
    stroke(255);
    fill(fillC);
    rectMode(CENTER);
    square(x, y, 100);
  }
  //grid display
  public void display()
  {
    if (fillTile==false) {
      noFill();
    } else {
      fill(fillC);
    }
    if (clicked==false)
    {
      stroke(255);
    } else {
      stroke(255, 0, 0);
    }
    rectMode(CENTER);
    square(x, y, 50);
  }

  //getters
  public int getX() {
    return x;
  }
  public int getY() {
    return y;
  }
  public int getNumber() {
    return number;
  }
  public boolean isClicked() {
    return clicked;
  }
  public color getColor() {
    return fillC;
  }

  //setters
  public void clicked(boolean clicked) {
    this.clicked=clicked;
  }
  public void fillTile(color newColor) {
    this.fillC=newColor; 
    fillTile=true;
  }
}

//this class controls the selectors for rows and columns
public class Selector
{
  int x;
  int y;
  int number;
  boolean clicked=false;
  public Selector(int x, int y, int number)
  {
    this.x=x;
    this.y=y;
    this.number=number;
  }
  public void display()
  {
    ellipseMode(CENTER);
    noFill();
    if (clicked==false)
    {
      stroke(255);
    } else {
      stroke(255, 0, 0);
    }
    circle(x, y, 30);
  }
  //getters
  public int getX() {
    return x;
  }
  public int getY() {
    return y;
  }
  public int getNumber() {
    return number;
  }
  public boolean isClicked() {
    return clicked;
  }

  //setters
  public void clicked(boolean clicked) {
    this.clicked=clicked;
  }
}
