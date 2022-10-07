public class Ghost
{
  float x;
  float y;
  boolean scared=false;
  int currentFrame=0;
  PImage[] images;
  boolean onFloor=false;
  boolean onLadder=false;
  int speed=3;
  boolean shouldRemove=false;
  public Ghost(float x, float y)
  {
    this.x=x;
    this.y=y;
    images= new PImage[4];
    images[0]=loadImage("ghost1.png");
    images[1]=loadImage("ghost2.png");
    images[2]=loadImage("ghost3.png");
    images[3]=loadImage("ghost4.png");
    speed=flySpeed;
  }
  public void display()
  {
    facing();
    imageMode(CENTER);
    image(images[currentFrame], x, y);
    if (currentLevel==2) {
      move();
    } else if (currentLevel==1) {
      move1();
    }
    gravity();
    if (dist((width/2)+95, 255, x, y)<50)
    {
      shouldRemove=true;
    }
  }
  public void move1()
  {
    for(int i=0; i<ladders.size();i++)
    {
      if(dist(x,y,ladders.get(i).getX(),ladders.get(i).getY())<40)
      {
        println(1);
        switchDirection();
      }
    }
    x+=speed;
  }
  public void facing()
  {
    if (speed>0 && scared==false) {
      currentFrame=0;
    } else if (speed<0 && scared==false) {
      currentFrame=1;
    }
    if (speed>0 && scared==true) {
      currentFrame=2;
    } else if (speed<0 && scared==true) {
      currentFrame=3;
    }
  }
  public void move()
  {
    if (scared==false)
    {
      if (onLadder==false) {
        x+=speed;
      } else {
        y-=4;
      }
    } else
    {
      x+=speed;
      if (x>width-((width/14)/1.6) || x<(width/14))
      {
        speed*=-1;
      }
    }
  }
  public void gravity()
  {
    if (onFloor==false && onLadder==false)
    {
      y+=2;
    }
  }
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
  public boolean isOnFloor() {
    return onFloor;
  }
  public int getSpeed() {
    return speed;
  }
  public void setOnFloor(boolean update) {
    onFloor=update;
  }
  public void setY(float newY) {
    this.y=newY;
  }
  public void switchDirection() {
    speed*=-1;
  }
  public void addX(int x) {
    if (speed>0)
    {
      this.x+=x;
    } else
    {
      this.x-=x;
    }
  }
  public void scared(boolean isScared) {
    this.scared=isScared;
  }
  public boolean shouldRemove() {
    return shouldRemove;
  }
  public void setRemove() {
    shouldRemove=true;
  }
  public boolean isScared() {
    return scared;
  }
  public void move(float amount) {
    x+=amount;
  }
}
