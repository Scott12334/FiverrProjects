public class Player
{
  PImage[] mario;
  float x;
  float y;
  int speed=5;
  boolean onFloor=false;
  boolean jump=false;
  int startJump=0;
  int startWalk=0;
  int upSpeed=2;
  int currentFrame=0;
  boolean onLadder=false;
  int heading=0; //right is 0, left is 1
  public Player(float x, float y)
  {
    this.x=x;
    this.y=y-30;
    mario= new PImage[10];
    mario[0]=loadImage("marioR1.png");
    mario[1]=loadImage("marioR2.png");
    mario[2]=loadImage("marioL1.png");
    mario[3]=loadImage("marioL2.png");
    mario[4]=loadImage("marioR3.png");
    mario[5]=loadImage("marioL3.png");
    mario[6]=loadImage("marioR4.png");
    mario[7]=loadImage("marioR5.png");
    mario[8]=loadImage("marioL4.png");
    mario[9]=loadImage("marioL5.png");
  }
  public void display()
  {
    imageMode(CENTER);
    if (marioHammer==true && right==false && left==false)
    {
      if (currentFrame==0 || currentFrame==6 || currentFrame==7 )
      {
        if (millis()>startWalk+50)
        {
          if (currentFrame!=6)
          {
            currentFrame=6;
          } else if (currentFrame==6)
          {
            currentFrame=7;
          }
          startWalk=millis();
        }
      } else if (currentFrame==2 || currentFrame==8 || currentFrame==9)
      {
        if (millis()>startWalk+50)
        {
          if (currentFrame!=8)
          {
            currentFrame=8;
          } else if (currentFrame==8)
          {
            currentFrame=9;
          }
          startWalk=millis();
        }
      }
    }
    if(currentFrame!=7 && currentFrame!=9){image(mario[currentFrame], x, y);}
    else{image(mario[currentFrame], x, y-20);}
    movement();
    gravity();
  }
  public void movement()
  {
    if (right==true && x+speed<width-10)
    {
      x+=speed;
      //println(millis()+ "sec-"+startWalk);
      if (millis()>startWalk+50 && marioHammer==false)
      {
        if (currentFrame!=1)
        {
          currentFrame=1;
        } else if (currentFrame==1)
        {
          currentFrame=0;
        }
        startWalk=millis();
      } else if (millis()>startWalk+50 && marioHammer==true)
      {
        if (currentFrame!=6)
        {
          currentFrame=6;
        } else if (currentFrame==6)
        {
          currentFrame=7;
        }
        startWalk=millis();
      }
    }
    if (left==true && x-speed>0) 
    {
      x-=speed;
      if (millis()>startWalk+50 && marioHammer==false)
      {
        if (currentFrame!=3)
        {
          currentFrame=3;
        } else if (currentFrame==3)
        {
          currentFrame=2;
        }
        startWalk=millis();
      } else if (millis()>startWalk+50 && marioHammer==true)
      {
        if (currentFrame!=8)
        {
          currentFrame=8;
        } else if (currentFrame==8)
        {
          currentFrame=9;
        }
        startWalk=millis();
      }
    }
    jump();
  }
  public void gravity()
  {
    println(onLadder);
    if (onFloor==false && onLadder==false)
    {
      y+=2;
    }
  }
  public void startJump(int heading)
  {
    jump=true;
    upSpeed=9;
    startJump=millis();
    this.heading=heading;
  }
  public void jump()
  {
    if (jump==true)
    {
      y-=upSpeed;
      if (upSpeed>=0)
      {
        upSpeed-=1;
      } else
      {
        jump=false;
        if (heading==0) {
          currentFrame=0;
        } else if (heading==1) {
          currentFrame=2;
        }
      }
    }
  }
  public void setOnFloor(boolean update) {
    onFloor=update;
  }
  public void changeY(float change) {
    y+=change;
  }
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
  public boolean isJumping() {
    return jump;
  }
  public boolean isOnFloor() {
    return onFloor;
  }
  public void onLadder(boolean value) {
    onLadder=value;
  }
  public void setY(float newY) {
    this.y=newY;
  }
  public void setX(float newX) {
    this.x=newX;
  }
  public void startWalk() {
    startWalk=millis();
  }
  public void setFrame(int frame) {
    currentFrame=frame;
  }
  public int getFrame() {
    return currentFrame;
  }
  public void move(int amount){x+=amount;}
}
