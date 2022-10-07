public class Ground
{
  float x;
  float y;
  PImage[] ground;
  PImage[] belt;
  PImage[] controller;
  boolean end;
  boolean conveyor;
  int currentFrame=0;
  int startTime;
  int direction=1;
  boolean right;
  int currentGround=0;
  public Ground(float x, float y)
  {
    this.x=x;
    this.y=y;
    ground=new PImage[3];
    ground[0]=loadImage("Scaffolding.png");
    ground[1]=loadImage("Scaffolding2.png");
    ground[2]=loadImage("Scaffolding3.png");
    conveyor=false;
  }
  public Ground(float x, float y, boolean end, boolean right)
  {
    this.x=x;
    this.y=y;
    conveyor=true;
    this.end=end;
    if (end==true)
    {
      if (right==true)
      {
        controller=new PImage[4];
        controller[0]= loadImage("beltControl1.png");
        controller[1]= loadImage("beltControl2.png");
        controller[2]= loadImage("beltControl3.png");
        controller[3]= loadImage("beltControl4.png");
      }
      else
      {
        controller=new PImage[4];
        controller[0]= loadImage("beltControlL1.png");
        controller[1]= loadImage("beltControlL2.png");
        controller[2]= loadImage("beltControlL3.png");
        controller[3]= loadImage("beltControlL4.png");
      }
    } else
    {
      belt= new PImage[4];
      belt[0]= loadImage("belt1.png");
      belt[1]= loadImage("belt2.png");
      belt[2]= loadImage("belt3.png");
      belt[3]= loadImage("belt4.png");
    }
  }
  public void display()
  {
    imageMode(CENTER);
    switch(currentLevel)
    {
      case 1:
      currentGround=1;
      break;
      
      case 2:
      currentGround=0;
      break;
      
      case 3:
      currentGround=2;
      break;
    }
    if (conveyor==false) {
      image(ground[currentGround], x, y);
    }
    if (conveyor==true && end==false) {
      image(belt[currentFrame], x, y);
      animate();
    }
    if (conveyor==true && end==true) {
      image(controller[currentFrame], x, y);
      animate();
    }
  }
  public void animate()
  {

    if (startTime+750<millis() && currentFrame<3 && direction==1)
    {
      currentFrame++;
      startTime=millis();
    } else if (startTime+750<millis() && currentFrame>0 && direction==-1)
    {
      currentFrame--;
      startTime=millis();
    } else if (currentFrame==3 || currentFrame==0)
    {
      direction*=-1;
    }
  }
  public int getDirection() {
    return direction;
  }
  public boolean isBelt() {
    return conveyor;
  }
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
}
