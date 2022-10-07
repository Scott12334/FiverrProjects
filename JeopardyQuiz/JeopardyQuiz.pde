import processing.sound.*;
boolean gameStarted;
Question test;
boolean canClick=true;
int score;
int currentQuestion;
ArrayList<Question> questions;
float startX;
float startY;
int timer;
PFont font;
SoundFile jeporady;
SoundFile win;
SoundFile lose;
void setup()
{
  size(900, 900);
  gameStarted=false;
  questions=new ArrayList<Question>();
  String[] q1= {"Mercury", "Saturn", "Earth"};
  String[] q2= {"10,000", "2,000", "35,000"};
  String[] q3= {"Ranking 1-10", "Ranking 11-30", "Ranking 30-50"};
  String[] q4= {"2592858639", "2592885639", "2592858369"};
  String[] q5= {"Harvard", "Stanford", "Cambridge"};
  String[] q6= {"Space Grey", "Black", "Yellow"};
  String[] q7= {"African Elephant", "Grey Wolf", "Blue Whale"};
  String[] q8= {"2005", "2010", "2007"};
  questions.add(new Question("What planet is closest to the sun?", q1, 0));
  questions.add(new Question("How many decisions a day, do people make on average?", q2, 2));
  questions.add(new Question("What is NYU ranked by US News?", q3, 1));
  questions.add(new Question("What number comes right after 2592858639?", q4, 0));
  questions.add(new Question("What was the name of the first college founded in the United States?", q5, 0));
  questions.add(new Question("What color is my macbook case?", q6, 2));
  questions.add(new Question("What is the loudest animal on Earth?", q7, 2));
  questions.add(new Question("What year did the first Iphone Come out?", q8, 2));
  jeporady = new SoundFile(this,"questionMusic.mp3");
  win = new SoundFile(this,"winMusic.mp3");
  lose = new SoundFile(this,"loseMusic.mp3");
  startX=width/2;
  startY=2*height/3-150;
  timer=60;

  font = createFont("coolFont.otf", 100);
}
void draw()
{
  textFont(font);
  if (gameStarted==false)
  {
    background(#f7ed2d);
    textSize(32);
    fill(0);
    textAlign(CENTER);
    text("Hi! Thanks for taking this short quiz!", width/2, height/3-175);
    textSize(20);
    text("If you finish the quiz with 1/2 right AND within the 1-minute time limit,", width/2, height/2-200);
    text("you will receive the candy of your choice. ", width/2, height/2-150);
    text("However, if you don’t, Sorry!!!:(", width/2, height/2-100);
    fill(#718af0);
    rectMode(CENTER);
    rect(startX, startY, 400, 100);
    textSize(40);
    fill(0);
    text("Click to Start!", startX, startY+20);
  } else
  {
    background(#f7ed2d); //change the top color, go to questions and change it there to
    rectMode(CORNER);
    textAlign(CENTER);
    textSize(35);
    fill(0);
    text(timer, width/2, height-450);
    if (currentQuestion<questions.size() && timer>0)
    {
      questions.get(currentQuestion).display();
      if (frameCount%60==0)
      {
        timer--;
      }
    } else
    {
      jeporady.stop();
      textSize(30);
      textAlign(CENTER);
      switch(score)
      {
      case 0:
        text("0/6 FAIL: Nothing to say to you", width/2, height/3+50);
        text("Press the Monsters Left Eye!", width/2, height/3+200);
        break;

      case 1:
        text("1/8 FAIL: ummmm WOW", width/2, height/3+50);
        text("Press the Monsters Left Eye!", width/2, height/3+200);
        break;

      case 2:
        text("2/8 FAIL: LOL COME ON", width/2, height/3+50);
        text("Press the Monsters Left Eye!", width/2, height/3+200);
        break;

      case 3:
        text("3/8 PASS: CONGRATS! You passed! Barely..", width/2, height/3+50);
        text("Press the Monsters Left Eye!", width/2, height/3+200);
        break;

      case 4:
        text("4/8, Congrats, you are awesome!", width/2, height/3+50);
        text("Press the Monsters Left Eye!", width/2, height/3+200);
        break;

      case 5:
        text("5/8 PASS: congrats! you are an AWESOME POSSUM!", width/2, height/3+50);
        text("Press the Monsters Right Eye!", width/2, height/3+200);
        break;

      case 6:
        text("6/6 PASS: WOW! you are the most AWESOMEST POSSUM", width/2, height/3+50);
        text("Press the Monsters Right Eye!", width/2, height/3+200);
        break;

      case 7:
        text("7/7 PASS: NICE JOB!!", width/2, height/3+50);
        text("Press the Monsters Right Eye!", width/2, height/3+200);
        break;
      case 8:
        text("8/8 PASS: WOOOOO YOU ARE AWESOME!", width/2, height/3+50);
        text("Press the Monsters Right Eye!", width/2, height/3+200);
        break;
      }
    }
  }
}
void mousePressed()
{
  if (gameStarted==false)
  {
    if (betterDis(mouseX, mouseY, startX-200, startX+200, startY-50, startY+50)==true)
    {
      jeporady.play();
      gameStarted=true;
    }
  } else
  {
    questions.get(currentQuestion).checkClick();
  }
}
void mouseReleased()
{
  canClick=true;
}
public boolean betterDis(float x, float y, float lX, float rX, float uY, float dY)
{
  if (x>lX && x<rX && y>uY && y<dY)
  {
    return true;
  } else {
    return false;
  }
}
