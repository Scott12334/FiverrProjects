public class Question
{
  String q;
  String[] choices;
  int answer;
  float box1X;
  float box1Y;

  float box2X;
  float box2Y;

  float box3X;
  float box3Y;
  //String question, string c1, string c2, string c3
  public Question(String q, String[] choices, int answer)
  {
    this.choices=choices;
    this.q=q;
    this.answer=answer;
    box1X=width/3;
    box1Y=2*height/3-400;

    box2X=2*width/3;
    box2Y=2*height/3-400;

    box3X=width/2;
    box3Y=2*height/3-250;
  }
  public void display()
  {
    rectMode(CENTER);
    textSize(25);
    textAlign(CENTER);
    text(q, width/2, height/3-250);
    fill(255);//this is the top color
    rect(box1X, box1Y, 200, 100);
    rect(box2X, box2Y, 200, 100);
    rect(box3X, box3Y, 200, 100);
    fill(0);
    textSize(20);
    text(choices[0], box1X, box1Y+10);
    text(choices[1], box2X, box2Y+10);
    text(choices[2], box3X, box3Y+10);
  }
  public void checkClick()
  {
    if (canClick==true)
    {
      if (betterDis(mouseX, mouseY, box1X-100, box1X+100, box1Y-50, box1Y+50)==true)
      {
        if(answer==0){score++;}
        currentQuestion++;
        canClick=false;
        playMusic();
      }
      if (betterDis(mouseX, mouseY, box2X-100, box2X+100, box2Y-50, box2Y+50)==true)
      {
        if(answer==1){score++;}
        currentQuestion++;
        canClick=false;
        playMusic();
      }
      if (betterDis(mouseX, mouseY, box3X-100, box3X+100, box3Y-50, box3Y+50)==true)
      {
        if(answer==2){score++;}
        currentQuestion++;
        canClick=false;
        playMusic();
      }
    }
  }
  void playMusic()
  {
    if(currentQuestion==questions.size()-1)
    {
      if(score>4)
      {
        win.play();
      }
      else
      {
        lose.play();
      }
    }
  }
}
