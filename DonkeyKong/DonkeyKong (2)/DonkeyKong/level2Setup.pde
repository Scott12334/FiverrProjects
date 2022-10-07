void level2Setup()
{
  mallets.add(new Mallet(width/2, 635));
  mallets.add(new Mallet(width/2, 435));
  kong= new Gorrilla(width/2-240, height-564);
  princessX=(width/2)-100;
  princessY=130;
  float x=(width/14)/2;
  float y=height-10.5;
  //row 1
  for (int i=0; i<numberPerRow+1; i++)
  {
    scaffolding.add(new Ground(x, y));
    x+=width/14-.6;
    if (i>=6)
    {
      y-=3;
    }
  }
  //row 2
  x=(width/14)/2;
  y=height-130.5;
  for (int i=0; i<numberPerRow; i++)
  {
    scaffolding.add(new Ground(x, y));
    x+=width/14-.6;
    y+=3;
  }
  //row 3
  x=(width/14)*1.5;
  y=height-195.5;
  for (int i=0; i<numberPerRow; i++)
  {
    scaffolding.add(new Ground(x, y));
    x+=width/14-.6;
    y-=3;
  }
  //row 4
  x=(width/14)/2;
  y=height-335.5;
  for (int i=0; i<numberPerRow; i++)
  {
    scaffolding.add(new Ground(x, y));
    x+=width/14-.6;
    y+=3;
  }
  //row 5
  x=(width/14)*1.5;
  y=height-395.5;
  for (int i=0; i<numberPerRow; i++)
  {
    scaffolding.add(new Ground(x, y));
    x+=width/14-.6;
    y-=3;
  }
  //row 6
  x=(width/14)/2;
  y=height-510.5;
  for (int i=0; i<numberPerRow; i++)
  {
    scaffolding.add(new Ground(x, y));
    x+=width/14-.6;
    if (i>=8)
    {
      y+=3;
    }
  }
  //ladder setup
  ladders.add(new Ladder(width-(width/14)-40, height-60));
  ladders.add(new Ladder(width-(width/14)-40, height-263));
  ladders.add(new Ladder(width-(width/14)-40, height-463));
  ladders.add(new Ladder((width/14)+30, height-160));
  ladders.add(new Ladder((width/14)+30, height-365));
  ladders.add(new Ladder((width/2)+95, 230, 100));
  ladders.add(new Ladder((width/2)-100, 230, 100));
  scaffolding.add(new Ground((width/2)-90, 169));
  scaffolding.add(new Ground((width/2)-90+width/14-.6, 169));
  scaffolding.add(new Ground((width/2)-90+width/14-.6+width/14-.6, 169));
  scaffolding.add(new Ground((width/2)-90+width/14-.6+width/14-.6+width/14-.6, 169));
}
