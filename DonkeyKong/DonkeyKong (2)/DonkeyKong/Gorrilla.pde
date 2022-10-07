public class Gorrilla
{
  float x;
  float y;
  PImage[] images;
  int currentFrame=0;
  int startAnimation=0;
  int startDrop=0;
  boolean barrellSpawn=false;
  boolean drop;
  boolean middle;
  boolean right;
  boolean left;
  int direction=-1; //-1 left, 1 right
  public Gorrilla(float x, float y)
  {
    this.x=x;
    this.y=y;
    images= new PImage[6];
    images[0]=loadImage("gorrilla1.png");
    images[1]=loadImage("gorrilla2.png");
    images[2]=loadImage("gorrilla3.png");
    images[3]=loadImage("gorrilla4.png");
    images[4]=loadImage("gorrilla5.png");
    images[5]=loadImage("gorrilla6.png");
    middle=true;
    left=false;
    right=false;
  }
  public void display()
  {
    imageMode(CENTER);
    image(images[currentFrame], x, y);
    if (barrellSpawn==true)
    {
      if (drop==true)
      {
        drop();
      } else
      {
        roll();
      }
    }
  }
  void chestPump()
  {
    if (millis()>startAnimation+400)
    {
      if (currentFrame!=1)
      {
        currentFrame=1;
      } else if (currentFrame==1)
      {
        currentFrame=2;
      }
      startAnimation=millis();
    }
  }
  void barrell(boolean drop)
  {
    barrellSpawn=true;
    this.drop=drop;
    this.startDrop=millis();
  }
  void drop()
  {
    if (millis()<startDrop+1400)
    {
      currentFrame=3;
      if (millis()>startDrop+700)
      {
        currentFrame=4;
      }
    } else
    {
      currentFrame=0;
      barrellSpawn=false;
      drop=false;
      barrells.add(new Barrell(x, y+30, 0));
      canMove=true;
    }
  }
  void roll()
  {
    if (millis()<startDrop+1500)
    {
      currentFrame=3;
      if (millis()>startDrop+500 &&millis()<startDrop+1000)
      {
        currentFrame=4;
      } else if (millis()>startDrop+1000)
      {
        currentFrame=5;
      }
    } else
    {
      barrells.add(new Barrell(x+70, y+30, 1));
      currentFrame=0;
      barrellSpawn=false;
    }
  }
  public void setFrame(int frame) {
    currentFrame=frame;
  }
  public void setX(int newX) {
    this.x=newX;
  }
  public void setY(int newY) {
    this.y=newY;
  }
  public void moveX(int newX) {
    x+= (newX*direction);
  }
  public boolean middle() {
    return middle;
  }
  public boolean left() {
    return left;
  }
  public boolean right() {
    return right;
  }
  public void arrivedLeft() {
    left=true;
    right=false;
    middle=false; 
    direction=1;
  }
  public void arrivedMiddle() {
    left=false;
    right=false;
    middle=true;
  }
  public void arrivedRight() {
    left=false;
    right=true;
    middle=false; 
    direction=-1;
  }
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
}
