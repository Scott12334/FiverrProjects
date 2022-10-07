public class Barrell
{
  float x;
  float y;
  int type;
  PImage[] images;
  int currentFrame=0;
  int startAnimation;
  int speed=4;
  boolean onFloor=false;
  boolean shouldRemove=false;
  public Barrell(float x, float y, int type)
  {
    this.x=x;
    this.y=y;
    this.type=type;
    images= new PImage[2];
    if (type==0) //drop
    {
      images[0]= loadImage("drop1.png");
      images[1]= loadImage("drop2.png");
    } else //roll
    {
      images[0]= loadImage("roll1.png");
      images[1]= loadImage("roll2.png");
    }
    speed=rollSpeed;
  }
  public void display()
  {
    imageMode(CENTER);
    image(images[currentFrame], x, y);
    if (millis()>startAnimation+400)
    {
      if (currentFrame!=1)
      {
        currentFrame=1;
      } else if (currentFrame==1)
      {
        currentFrame=0;
      }
      startAnimation=millis();
    }
    movement();
  }
  public void movement()
  {
    if (type==0)
    {
      y+=speed;
    }
    else
    {
      if(onFloor==true){x+=speed;}
      gravity();
      if(x>width-((width/14)) || x<(width/14))
      {
        speed*=-1;
      }
    }
    if(y>height)
    {
      shouldRemove=true;
    }
    if(y>height-100 && x<(width/14)/2)
    {
      shouldRemove=true;
    }
  }
  public void gravity()
  {
    if (onFloor==false)
    {
      y+=4;
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
  public void setOnFloor(boolean update) {
    onFloor=update;
  }
  public void addSpeed(){speed+=2;}
  public boolean shouldRemove(){return shouldRemove;}
  public int getType(){return type;}
  public void setRemove(){shouldRemove=true;}
}
