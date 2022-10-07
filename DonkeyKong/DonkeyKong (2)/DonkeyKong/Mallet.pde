public class Mallet
{
  float x;
  float y;
  boolean scared=false;
  int currentFrame=0;
  PImage images;
  boolean onFloor=false;
  boolean onLadder=false;
  int speed=3;
  public Mallet(float x, float y)
  {
    this.x=x;
    this.y=y;
    images=loadImage("mallet.png");
  }
  public void display()
  {
    imageMode(CENTER);
    image(images,x,y);
  }
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
  public boolean isTouched()
  {
    if(dist(mario.getX(),mario.getY(),x,y)<40)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}
