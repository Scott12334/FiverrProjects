public class Player
{
  PImage player;
  float x;
  float y;
  int speed=7;
  public Player(float x, float y)
  {
    this.x=x;
    this.y=y;
    player=loadImage("Player.png");
  }
  public void display()
  {
    imageMode(CENTER);
    image(player, x, y);
  }
  public void movement()
  {
    if (up==true && y-speed>0)
    {
      y-=speed;
    }
    if (down==true && y+speed<height)
    {
      y+=speed;
    }
    if (right==true && x+speed<width)
    {
      x+=speed;
    }
    if (left==true && x-speed>0)
    {
      x-=speed;
    }
  }
  public float getX(){return x;}
  public float getY(){return y;}
}
