import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//import processing.minim.*;

ArrayList<Ground> scaffolding;
ArrayList<Ladder> ladders;
int numberPerRow=13;
Player mario;
int lives;
int celebrate=0;
//movement variables
boolean right=false;
boolean left=false;
int lastJump;
PImage barrel;
PImage life;
boolean canJump;
//Kong
Gorrilla kong;
int lastRoll=0;
boolean canDrop=true;
boolean canMove=false;
//barrells
ArrayList<Barrell> barrells;
//GUI variables
PFont newFont;
boolean gameStarted;
boolean gameOver;
int score;

//enimies
PImage[] blueBarrell;
int currentBlueBarrell;
int barrelStartTime;
ArrayList<Ghost> ghosts;
int ghostSpawn;
PImage wires;

//explosion
PImage[] explosion;
int currentExplosion;
int startExplosion;

//mallet
ArrayList<Mallet> mallets;
boolean marioHammer=false;
int hammerStart;

//princess peach
PImage[] peachImages;
int startWalking;
int peachFrame;
boolean gameWon;
float princessX;
float princessY;

//name variables
boolean needName;

//level variables
int currentLevel;
int startLevel;
boolean newLevel;
int rollSpeed;
int flySpeed;
int ghostSpawnTime;
int barrellSpawnTime;
//Pie variables
ArrayList<Pie> pies;

//rain variables
PImage tiltedBarrell;
ArrayList<Rain> drops;
int lastRain=0;
//Sound Files
Minim minim;
AudioPlayer jump;
AudioPlayer hammer;
AudioPlayer pickup;
AudioPlayer loseLife;
AudioPlayer gameLost;
AudioPlayer wonGame;
public void setup()
{
  size(826, 800);
  scaffolding= new ArrayList<Ground>();
  ladders= new ArrayList<Ladder>();
  barrells= new ArrayList<Barrell>();
  pies=new ArrayList<Pie>();
  kong= new Gorrilla(width/2-240, height-564);
  mario=new Player((width/14)*2, height-42);
  barrel= loadImage("barrel1.png");
  lives=3;
  life= loadImage("marioR1.png");
  newFont=createFont("ARCADECLASSIC.TTF", 60);
  blueBarrell= new PImage[2];
  blueBarrell[0]=loadImage("blueBarrell1.png");
  blueBarrell[1]=loadImage("blueBarrell2.png");
  currentBlueBarrell=0;
  gameStarted=false;
  gameOver=false;
  barrelStartTime=millis();
  ghosts= new ArrayList<Ghost>();
  ghostSpawn=millis();
  score=0;
  mallets=new ArrayList<Mallet>();
  marioHammer=false;
  hammerStart=millis();
  scores= new int[10];
  scoreBoardNames= new String[10];
  loadScore();
  peachImages= new PImage[2];
  peachImages[0]= loadImage("peach1.png");
  peachImages[1]= loadImage("peach2.png");
  startWalking=millis();
  peachFrame=0;
  gameWon=false;
  needName=false;
  lastJump=0;
  currentLevel=1;
  startLevel=0;
  newLevel=false;
  name1="";
  flySpeed=3;
  rollSpeed=4;
  barrellSpawnTime=3000;
  ghostSpawnTime=5000;
  minim = new Minim(this);
  jump=minim.loadFile("jump.mp3");
  hammer=minim.loadFile("hammer.mp3");
  pickup=minim.loadFile("itemget.mp3");
  loseLife=minim.loadFile("loseLife.mp3");
  gameLost=minim.loadFile("gameOver.mp3");
  wonGame=minim.loadFile("gameWon.mp3");
  canJump=true;
  explosion= new PImage[4];
  explosion[0]=loadImage("e1.png");
  explosion[1]=loadImage("e2.png");
  explosion[2]=loadImage("e3.png");
  explosion[3]=loadImage("e4.png");
  wires= loadImage("wire.png");
  tiltedBarrell=loadImage("tiltedBarrell.png");
  lastRain=millis();
  drops= new ArrayList<Rain>();
  level1Setup();
}
public void draw()
{
  background(0);
  if (gameStarted==false)
  {
    startScreen();
  } else if (needName==true)
  {
    getUsername();
  } else if (gameOver==true)
  {
    endScreen();
  } else if (gameWon==true)
  {
    gameWonScreen();
    println(lives);
  } else {
    scaffolding();
    ladders();
    blueEnemies();
    mario.display();
    barrelDisplay();
    kongControl();
    barrellControl();
    lifeDisplay();
    malletControl();
    princessPeach();
    levelControl();
    pieControl();
    rainControl();
  }
}
void rainControl()
{
  if (currentLevel==1)
  {
    image(tiltedBarrell, width/3+50, height/2-242);
    for (int i=0; i<drops.size(); i++)
    {
      drops.get(i).display();
      if (dist(mario.getX(), mario.getY(), drops.get(i).getX(), drops.get(i).getY())<10)
      {
        lives--;
        kong.setFrame(0);
        celebrate=millis();
        mario.setX((width/14)*2);
        mario.setY(height-42);
        loseLife.play(0);
        drops.clear();
        break;
      }
    }
    if (lastRain+1000<millis())
    {
      drops.add(new Rain(width/3+28+random(-10, 2), height/2-225));
      lastRain=millis();
    }
  }
}
void pieControl()
{
  for (int i=0; i<pies.size(); i++)
  {
    pies.get(i).display();
    if (pies.get(i).isTouched()==true && marioHammer==false)
    {
      lives--;
      kong.setFrame(0);
      celebrate=millis();
      mario.setX((width/14)*2);
      mario.setY(height-42);
      ghosts.clear();
      ghostSpawn=millis();
      loseLife.play(0);
      pies.remove(i);
      break;
    } else if (pies.get(i).isTouched()==true && marioHammer==true)
    {
      score+=200;
      pies.remove(i);
      break;
    }
  }
}
void levelControl()
{
  if (startLevel>millis()-1500)
  {
    textFont(newFont);
    textAlign(CENTER);
    fill(255);
    textSize(75);
    text("Level "+currentLevel, width/2, height/2);
  }
  if (newLevel==true)
  {
    kong.setFrame(0);
    celebrate=millis();
    mario.setX((width/14)*2);
    mario.setY(height-42);
    barrells.clear();
    ghosts.clear();
    mallets.clear();
    ghostSpawn=millis();
    startLevel=millis();
    scaffolding.clear();
    ladders.clear();
    currentLevel++;
    barrellSpawnTime-=500;
    ghostSpawnTime-=750;
    if (currentLevel==2)
    {
      level2Setup();
    }
    if (currentLevel==3)
    {
      level3Setup();
    }
    newLevel=false;
  }
}
void gameWonScreen()
{
  textFont(newFont);
  textAlign(CENTER);
  fill(255, 0, 0);
  textSize(50);
  text("You Won!", width/2, height/2-100);
  textSize(45);
  text("Press  the  spacebar to  restart", width/2, (height/2)-50);
  scoreBoard();
}
void scoreBoard()
{
  textFont(newFont);
  textAlign(CENTER);
  fill(255, 0, 0);
  textSize(32);
  int y=height/2;
  for (int i=0; i<10; i++)
  {
    textSize(25);
    int number=10-i;
    text(number+" "+scoreBoardNames[i].substring(scoreBoardNames[i].indexOf(":")+1)+" "+scores[i], width/2, y);
    y+=20;
  }
}
void getUsername()
{
  textFont(newFont);
  textAlign(CENTER);
  fill(255, 0, 0);
  textSize(32);
  text("Congrats you are one of the top ten scorers!", width/2, height/2-200);
  text("type your name then press enter", width/2, height/2-170);
  textSize(25);
  text(name1, width/2, (height/2));
}
void princessPeach()
{
  if (millis()>startWalking+200)
  {
    if (peachFrame!=1)
    {
      peachFrame=1;
    } else if (peachFrame==1)
    {
      peachFrame=0;
    }
    startWalking=millis();
  }
  imageMode(CENTER);
  image(peachImages[peachFrame], princessX, princessY);
  if (dist(princessX, princessY, mario.getX(), mario.getY())<20)
  {
    score+=400;
    if (currentLevel==3)
    {
      gameWon=true;
      if (score>scores[0])
      {
        needName=true;
      } else
      {
        saveScore1();
      }
      wonGame.play();
    } else
    {
      newLevel=true;
    }
  }
}
void blueEnemies()
{
  if (currentLevel==1)
  {
    for (int i=0; i<ghosts.size(); i++)
    { 
      ghosts.get(i).display();
      if (marioHammer==true)
      {
        if (ghosts.get(i).isScared()==false) {
        }
        ghosts.get(i).scared(true);
      } else
      {
        if (ghosts.get(i).isScared()==true) {
        }
        ghosts.get(i).scared(false);
      }
      if (dist(mario.getX(), mario.getY(), ghosts.get(i).getX(), ghosts.get(i).getY())<20 && marioHammer==false)
      {
        lives--;
        kong.setFrame(0);
        celebrate=millis();
        mario.setX((width/14)*2);
        mario.setY(height-42);
        barrells.clear();
        ghosts.clear();
        ghostSpawn=millis();
        loseLife.play(0);
        break;
      } else if (dist(mario.getX(), mario.getY(), ghosts.get(i).getX(), ghosts.get(i).getY())<20 && marioHammer==true)
      {
        score+=200;
        ghosts.get(i).setRemove();
      }
      if (ghosts.get(i).shouldRemove()==true)
      {
        ghosts.remove(i);
      }
    }
  }
  if (currentLevel==2)
  {
    imageMode(CENTER);
    image(blueBarrell[currentBlueBarrell], (width/14)*2-50, height-57);
    if (millis()>barrelStartTime+200)
    {
      if (currentBlueBarrell!=1)
      {
        currentBlueBarrell=1;
      } else if (currentBlueBarrell==1)
      {
        currentBlueBarrell=0;
      }
      barrelStartTime=millis();
    }
    for (int i=0; i<ghosts.size(); i++)
    { 
      ghosts.get(i).display();
      if (marioHammer==true)
      {
        if (ghosts.get(i).isScared()==false) {
          ghosts.get(i).switchDirection();
        }
        ghosts.get(i).scared(true);
      } else
      {
        if (ghosts.get(i).isScared()==true) {
          ghosts.get(i).switchDirection();
        }
        ghosts.get(i).scared(false);
      }
      if (dist(mario.getX(), mario.getY(), ghosts.get(i).getX(), ghosts.get(i).getY())<20 && marioHammer==false)
      {
        lives--;
        kong.setFrame(0);
        celebrate=millis();
        mario.setX((width/14)*2);
        mario.setY(height-42);
        barrells.clear();
        ghosts.clear();
        ghostSpawn=millis();
        loseLife.play(0);
        break;
      } else if (dist(mario.getX(), mario.getY(), ghosts.get(i).getX(), ghosts.get(i).getY())<20 && marioHammer==true)
      {
        score+=200;
        ghosts.get(i).setRemove();
      }
      if (ghosts.get(i).shouldRemove()==true)
      {
        ghosts.remove(i);
      }
    }
    if (millis()>ghostSpawn+ghostSpawnTime && marioHammer==false)
    {
      ghosts.add(new Ghost((width/14)*2-50, height-80));
      ghostSpawn=millis();
      currentExplosion=0;
    } else if (millis()==ghostSpawn+4000)
    {
      startExplosion=millis();
    } else if (millis()>ghostSpawn+4000 && marioHammer==false)
    {
      if (currentExplosion<4)
      {
        image(explosion[currentExplosion], (width/14)*2-50, height-90);
        if (millis()>startExplosion+500)
        {
          currentExplosion++;
        }
      }
    }
  }
  if (currentLevel==3)
  {
    imageMode(CENTER);
    image(wires, width/2, height/2+103);
    image(blueBarrell[currentBlueBarrell], width/2, height/2+37);
    if (millis()>barrelStartTime+200)
    {
      if (currentBlueBarrell!=1)
      {
        currentBlueBarrell=1;
      } else if (currentBlueBarrell==1)
      {
        currentBlueBarrell=0;
      }
      barrelStartTime=millis();
    }
    if (mario.getX()<width/2+blueBarrell[currentBlueBarrell].width/2 && mario.getX()>width/2-blueBarrell[currentBlueBarrell].width/2 && mario.getY()<(height/2+37)+wires.height/2 && mario.getY()>(height/2+37)-wires.height/2)
    {
      lives--;
      kong.setFrame(0);
      celebrate=millis();
      mario.setX((width/14)*2);
      mario.setY(height-42);
      barrells.clear();
      ghosts.clear();
      ghostSpawn=millis();
      loseLife.play(0);
    }
    if (millis()>ghostSpawn+3000 && marioHammer==false)
    {
      int spawnLoc= (int)random(0, 7);
      switch(spawnLoc)
      {
      case 0:
        ghosts.add(new Ghost(width/3, height-380));
        break;

      case 1:
        ghosts.add(new Ghost(2*width/3, height-380));
        break;

      case 2:
        ghosts.add(new Ghost(width/3, height-140));
        break;

      case 3:
        ghosts.add(new Ghost(2*width/3, height-140));
        break;

      case 4:
        ghosts.add(new Ghost(width/2, height-140));
        break;

      case 5:
        ghosts.add(new Ghost(width/3, height-500));
        break;

      case 6:
        ghosts.add(new Ghost(2*width/3, height-500));
        break;
      }
      ghostSpawn=millis();
    }
    for (int i=0; i<ghosts.size(); i++)
    {
      ghosts.get(i).display();
      if (dist(mario.getX(), mario.getY(), ghosts.get(i).getX(), ghosts.get(i).getY())<20 && marioHammer==false)
      {
        lives--;
        kong.setFrame(0);
        celebrate=millis();
        mario.setX((width/14)*2);
        mario.setY(height-42);
        barrells.clear();
        ghosts.clear();
        ghostSpawn=millis();
        loseLife.play(0);
        break;
      } else if (dist(mario.getX(), mario.getY(), ghosts.get(i).getX(), ghosts.get(i).getY())<20 && marioHammer==true)
      {
        score+=200;
        ghosts.get(i).setRemove();
      }
      if (marioHammer==true)
      {
        ghosts.get(i).scared(true);
      } else
      {
        ghosts.get(i).scared(false);
      }
      if (ghosts.get(i).shouldRemove()==true)
      {
        ghosts.remove(i);
      }
    }
  }
}
void malletControl()
{
  for (int i=0; i<mallets.size(); i++)
  {
    mallets.get(i).display();
    if (mallets.get(i).isTouched()==true)
    {
      mallets.remove(i);
      marioHammer=true;
      hammerStart=millis()+6000;
      pickup.play();
      hammer.play();
    }
  }
  if (hammerStart<millis() && marioHammer==true)
  {
    mario.setFrame(2);
    marioHammer=false;
    hammer.pause();
  }
}
void startScreen()
{
  textFont(newFont);
  textAlign(CENTER);
  fill(255, 0, 0);
  textSize(50);
  text("Donkey Kong!", width/2, height/2);
  textSize(45);
  text("Press  the  spacebar to  begin", width/2, (height/2)+50);
}
void endScreen()
{
  textFont(newFont);
  textAlign(CENTER);
  fill(255, 0, 0);
  textSize(50);
  text("Game Over!", width/2, height/2-100);
  textSize(45);
  text("Press  the  spacebar to  restart", width/2, (height/2)-50);
  scoreBoard();
}
void lifeDisplay()
{
  int lifeX= ((width/14)/2)-15;
  for (int i=0; i<lives; i++)
  {
    imageMode(CENTER);
    image(life, lifeX, 25);
    lifeX+=25;
  }
  if (lives<=0)
  {
    if (score>scores[0])
    {
      needName=true;
    } else
    {
      saveScore1();
    }
    gameOver=true;
    gameLost.play();
  }
  textFont(newFont);
  textAlign(CENTER);
  fill(255);
  textSize(50);
  text(score, width/2, 50);
}
void barrellControl()
{
  for (int i=0; i<barrells.size(); i++)
  {
    barrells.get(i).display();
    if (dist(mario.getX(), mario.getY(), barrells.get(i).getX(), barrells.get(i).getY())<20 && marioHammer==false)
    {
      lives--;
      kong.setFrame(0);
      celebrate=millis();
      barrells.get(i).setRemove();
      mario.setX((width/14)*2);
      mario.setY(height-42);
      barrells.clear();
      ghosts.clear();
      ghostSpawn=millis();
      loseLife.play(0);
      break;
    } else if (dist(mario.getX(), mario.getY(), barrells.get(i).getX(), barrells.get(i).getY())<20 && marioHammer==true)
    {
      score+=200;
      barrells.get(i).setRemove();
    }
    if (barrells.get(i).shouldRemove()==true)
    {
      barrells.remove(i);
    }
  }
}
void kongControl()
{
  kong.display();
  if (currentLevel==2)
  {
    if (celebrate+2000>millis())
    {
      kong.chestPump();
    } else if (millis()>lastRoll+barrellSpawnTime)
    {
      int dropOrRoll= (int)random(2);
      if (dropOrRoll==0)
      {
        kong.barrell(true);
      } else
      {
        kong.barrell(false);
      }
      lastRoll=millis();
    }
  } else if (currentLevel==1)
  {
    //drop barrell
    if (canDrop==true)
    {
      kong.barrell(true);
      canDrop=false;
    }
    //move left
    if (canMove==true)
    {
      kong.chestPump();
      kong.moveX(1);
    }
    //drop barrell
    if (kong.getX()-width/3<10 && kong.left()==false) {
      canDrop=true; 
      canMove=false; 
      kong.arrivedLeft();
    }
    if (abs(kong.getX()-width/2)<10 && kong.middle()==false) {
      canDrop=true; 
      canMove=false; 
      kong.arrivedMiddle();
    }
    if ((2*width/3)-kong.getX()<10 && kong.right()==false) {
      canDrop=true; 
      canMove=false; 
      kong.arrivedRight();
    }
  } else if (currentLevel==3)
  {
    //drop barrell
    if (canDrop==true)
    {
      kong.barrell(true);
      canDrop=false;
    }
    //move left
    if (canMove==true)
    {
      kong.chestPump();
      kong.moveX(1);
    }
    //drop barrell
    if (kong.getX()-width/7<10 && kong.left()==false) {
      canDrop=true; 
      canMove=false; 
      kong.arrivedLeft();
    }
    if (abs(kong.getX()-width/2)<10 && kong.middle()==false) {
      canDrop=true; 
      canMove=false; 
      kong.arrivedMiddle();
    }
    if ((width-width/7)-kong.getX()<10 && kong.right()==false) {
      canDrop=true; 
      canMove=false; 
      kong.arrivedRight();
    }
  }
}
void ladders()
{
  for (int i=0; i<ladders.size(); i++)
  {
    ladders.get(i).display();
    if (dist(mario.getX(), mario.getY(), ladders.get(i).getX(), ladders.get(i).getY())<100 && ladders.get(i).playerOnLadder(mario.getX(), mario.getY())==false)
    {
      mario.onLadder=false;
      canJump=true;
    }
    for (int j=0; j<ghosts.size(); j++)
    {
      if (ghosts.get(j).getX()+20>ladders.get(i).getX()-5 && ghosts.get(j).getX()-20<ladders.get(i).getX()+5 && ghosts.get(j).getY()+17<ladders.get(i).getY()+30 && ghosts.get(j).getY()-17>ladders.get(i).getY()-30 && ghosts.get(j).isScared()==false)
      {
        ghosts.get(j).addX(5);
        ghosts.get(j).onLadder=true;
        ghosts.get(j).switchDirection();
      } else if (dist(ghosts.get(j).getX(), ghosts.get(j).getY(), ladders.get(i).getX(), ladders.get(i).getY())>50 && dist(ghosts.get(j).getX(), ghosts.get(j).getY(), ladders.get(i).getX(), ladders.get(i).getY())<80)
      {
        ghosts.get(j).onLadder=false;
      }
    }
  }
}


void scaffolding()
{
  for (int i=0; i<scaffolding.size(); i++)
  {
    scaffolding.get(i).display();
    //pie movement
    for (int j=0; j<pies.size(); j++)
    {
      if (pies.get(j).getX()>scaffolding.get(i).getX()-29.5 && pies.get(j).getX()<scaffolding.get(i).getX()+29.5 && scaffolding.get(i).isBelt()==true)
      {
        if (pies.get(j).getY()+20>scaffolding.get(i).getY()-20 && pies.get(j).getY()<scaffolding.get(i).getY())
        {
          if (scaffolding.get(i).isBelt()==true)
          {
            pies.get(j).move(1.2*scaffolding.get(i).getDirection());
          }
        }
      }
    }
    if (mario.getX()>scaffolding.get(i).getX()-29.5 && mario.getX()<scaffolding.get(i).getX()+29.5)
    {
      if (mario.getY()+18>scaffolding.get(i).getY()-10 && mario.getY()<scaffolding.get(i).getY() && mario.isJumping()==false)
      {
        mario.setOnFloor(true);
        if (scaffolding.get(i).isBelt()==true)
        {
          mario.move(2*scaffolding.get(i).getDirection());
        }
        mario.setY((scaffolding.get(i).getY()-10)-18);
      } else if (mario.getY()+18<scaffolding.get(i).getY()+15)
      {
        mario.setOnFloor(false);
      }
    }
    for (int j=0; j<barrells.size(); j++)
    {
      if (barrells.get(j).getX()<scaffolding.get(i).getX()+29.5 && barrells.get(j).getX()>scaffolding.get(i).getX()-29.5)
      {
        if (barrells.get(j).getY()+18>scaffolding.get(i).getY()-10 && barrells.get(j).getY()<scaffolding.get(i).getY())
        {
          barrells.get(j).setOnFloor(true);
        } else if (barrells.get(j).getY()+16<scaffolding.get(i).getY()+15)
        {
          barrells.get(j).setOnFloor(false);
        }
      }
    }
    for (int j=0; j<ghosts.size(); j++)
    {
      if (ghosts.get(j).getX()<scaffolding.get(i).getX()+29.5 && ghosts.get(j).getX()>scaffolding.get(i).getX()-29.5)
      {
        if (ghosts.get(j).getY()+18>scaffolding.get(i).getY()-10 && ghosts.get(j).getY()<scaffolding.get(i).getY())
        {
          ghosts.get(j).setOnFloor(true);
          ghosts.get(j).setY((scaffolding.get(i).getY()-10)-18);
          if (scaffolding.get(i).isBelt()==true)
          {
            ghosts.get(j).move(1.5*scaffolding.get(i).getDirection());
          }
        } else if (ghosts.get(j).getY()+16<scaffolding.get(i).getY()+15)
        {
          ghosts.get(j).setOnFloor(false);
        }
      }
    }
  }
}
void barrelDisplay()
{
  if (currentLevel==2)
  {
    imageMode(CENTER);
    image(barrel, width/14-30, height-538.5);
    image(barrel, width/14-5, height-538.5);
    image(barrel, width/14+20, height-538.5);
    image(barrel, width/14-30, height-576.5);
    image(barrel, width/14-5, height-576.5);
    image(barrel, width/14+20, height-576.5);
    image(barrel, width/14-30, height-613);
    image(barrel, width/14-5, height-613);
    image(barrel, width/14+20, height-613);
  }
}
void keyPressed()
{
  if (needName==false)
  {
    if (key== 'a' || keyCode==LEFT)
    {
      left=true;
    }
    if (key== 'd' || keyCode==RIGHT)
    {
      right=true;
    }
    if (key==' ' && mario.isJumping()==false && gameStarted==true && lastJump+300<millis() && canJump==true)
    {
      if (mario.getFrame()==0 || mario.getFrame()==1) {
        mario.setFrame(4);
        mario.startJump(0);
        jump.play(0);
        lastJump=millis();
        canJump=false;
      } else if (mario.getFrame()==2 || mario.getFrame()==3) {
        mario.setFrame(5);
        mario.startJump(1);
        jump.play(0);
        lastJump=millis();
        canJump=false;
      }
    } else if (key==' '&& gameStarted==false)
    {
      gameStarted=true;
      startLevel=millis();
    } else if (key==' '&& (gameOver==true || gameWon==true))
    {
      setup();
    }
    if (keyCode==UP || key=='w')
    {
      for (int i=0; i<ladders.size(); i++)
      {
        if (ladders.get(i).playerOnLadder(mario.getX(), mario.getY()))
        {
          mario.changeY(-6);
          mario.onLadder(true);
          canJump=false;
        }
      }
    }
  } else
  {
    if (key!=ENTER)
    {
      name1+=key;
    } else
    {
      needName=false;
      saveScore1();
    }
  }
}
void keyReleased()
{
  if (key== 'a' || keyCode==LEFT)
  {
    left=false;
    mario.setFrame(2);
  }
  if (key== 'd' || keyCode==RIGHT)
  {
    right=false;  
    mario.setFrame(0);
  }
  if (key== ' ' && canJump==false && mario.onLadder==false)
  {
    canJump=true;
  }
}
