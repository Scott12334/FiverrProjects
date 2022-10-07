public class Ladder
{
  float x;
  float y;
  float ladderHeight;
  PImage[] ladder;
  boolean changeLadder;
  int currentLadder=0;
  public Ladder(float x, float y)
  {
    this.x=x;
    this.y=y;
    ladder=new PImage[3];
    ladder[0]=loadImage("Ladder.png");
    ladder[1]=loadImage("Ladder2.png");
    ladder[2]=loadImage("Ladder3.png");
    this.ladderHeight=ladder[0].height;
  }
  public Ladder(float x, float y,float ladderHeight)
  {
    this.x=x;
    this.y=y;
    ladder=new PImage[3];
    ladder[0]=loadImage("Ladder.png");
    ladder[1]=loadImage("Ladder2.png");
    ladder[2]=loadImage("Ladder3.png");
    this.ladderHeight=ladderHeight;
    changeLadder=true;
  }
  public void display()
  {
    imageMode(CENTER);
    switch(currentLevel)
    {
      case 1:
      currentLadder=1;
      break;
      
      case 2:
      currentLadder=0;
      break;
      
      case 3:
      currentLadder=2;
      break;
    }
    if(changeLadder==false){image(ladder[currentLadder],x,y);}
    else{image(ladder[currentLadder],x,y,ladder[currentLadder].width,ladderHeight);}
  }
  public boolean playerOnLadder(float playerX, float playerY)
  {
    if(playerX-15<x+ladder[currentLadder].width/2 && playerX+15>x-ladder[currentLadder].width/2 && playerY-17<y+ladderHeight/2 && playerY+17>y-ladderHeight/2)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  public float getX(){return x;}
  public float getY(){return y;}
}
