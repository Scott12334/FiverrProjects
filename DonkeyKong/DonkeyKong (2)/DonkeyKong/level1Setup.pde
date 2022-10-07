void level1Setup()
{
  scaffolding= new ArrayList<Ground>();
  ladders= new ArrayList<Ladder>();
  int newRow=14;
  float y=height-10.5;
  for (int i=0; i<6; i++)
  {
    float x=((width/14)/2) +(width/14)*i;
    for (int j=0; j<newRow; j++)
    {
      scaffolding.add(new Ground(x, y));
      x+=width/14+0.6;
    }
    if(i==2)
    {
      mallets.add(new Mallet(width/2, y-50));
    }
    if(i>0 && i<4)
    {
      ghosts.add(new Ghost(width/2,y-20));
    }
    newRow-=2;
    y-=120;
  }
  y=height-70;
  float x=(width/14)/2+width/14;
  for (int i=0; i<5; i++)
  {
    ladders.add(new Ladder(x, y, 100));
    ladders.add(new Ladder(width-x, y, 100));
    x+=width/14;
    y-=120;
  }
  kong.setX(width/2);
  kong.setY(255);
  princessX=width/2;
  princessY=150;
}
