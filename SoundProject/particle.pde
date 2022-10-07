public class Particle
{
  float x;
  float y;
  float speedX=.2;
  float speedY=.3;
  float yDirection=-1;
  float xDirection=1;
  public Particle(float x, float y)
  {
    this.x=x;
    this.y=y;
    speedX=random(0.01);
    speedY=random(0.01);
    yDirection=random(-2,2);
    xDirection=random(-2,2);
  }
  public void display(float forceX, float forceY)
  {
    //simple display the particle
    noStroke();
    ellipseMode(CENTER);
    fill(0, 255, cB);
    circle(x,y,10);
    move(forceX,forceY);
  }
  //move based on the base on current dirrection
  public void move(float forceX, float forceY)
  {
    x+=((speedX+forceX)/2)*xDirection;
    y+=((speedY+forceY)/2)*yDirection;
    calcDirection();
  }
  public void calcDirection()
  {
    //if the particle hits a wall, it will flip direction
    if(x<0)
    {
      xDirection=1;
    }
    if(x>width)
    {
      xDirection=-1;
    }
    if(y<0)
    {
      yDirection=1;
    }
    if(y>height-100)
    {
      yDirection=-1;
    }
  }
}
