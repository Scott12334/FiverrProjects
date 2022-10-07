public class Rain
{
  float x;
  float y;
  PImage drop;
  public Rain(float x, float y)
  {
    this.x=x;
    this.y=y;
    drop= loadImage("drop.png");
  }
  void display()
  {
    imageMode(CENTER);
    image(drop,x,y);
    fall();
  }
  void fall()
  {
    y+=3;
  }
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
}
