public class Pie
{
  float x;
  float y;
  PImage pie;
  public Pie(float x, float y)
  {
    this.x=x;
    this.y=y;
    pie=loadImage("pie.png");
  }
  public void display()
  {
    imageMode(CENTER);
    image(pie,x,y);
  }
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
  public void move(float amount){x+=amount;}
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
