PImage[] Slime= new PImage[5];
public class Obstacle
{
  float x;
  float y;
  int speed=5;
  int frame=0;
  public Obstacle(float x, float y)
  {
    Slime[0] = loadImage("Slime.png");
    Slime[1] = loadImage("Slime1.png");
    Slime[2] = loadImage("Slime2.png");
    Slime[3] = loadImage("Slime3.png");
    Slime[4] = loadImage("Slime4.png");
    this.x=x;
    this.y=y;
  }
  public void display()
  {
    imageMode(CENTER);
    animate();
  }
  public void pathFind()
  {
    if(x>width/2)
    {
      x-=speed;
    }
    if(x<width/2)
    {
      x+=speed;
    }
    if(y>height/2)
    {
      y-=speed;
    }
    if(y<height/2)
    {
      y+=speed;
    }
  }
  public float getX(){return x;}
  public float getY(){return y;}
  
  public void animate()
  {
    image(Slime[frame],x,y);
    if(frame<5 && frameCount%20==0)
    {
      println("test");
      frame++;
    }
    else if(frameCount==5 && frameCount%20==0)
    {
      frame=0;
    }
  }
}
