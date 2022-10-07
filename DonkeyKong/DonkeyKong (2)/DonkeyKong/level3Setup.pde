void level3Setup()
{
  pies.add(new Pie(width/4,height-160));
  pies.add(new Pie(width/2,height-160));
  pies.add(new Pie(3*width/4,height-160));
  mallets.clear();
  mallets.add(new Mallet(width/2,height-175));
  
  //row 1
  float x=(width/14)/2;
  float y=height-10.5;
  scaffolding= new ArrayList<Ground>();
  ladders=new ArrayList<Ladder>();
  for (int i=0; i<numberPerRow+1; i++)
  {
    scaffolding.add(new Ground(x, y));
    x+=width/14-.6;
  }
  ladders.add(new Ladder(width/5, height-70, 100));
  ladders.add(new Ladder(2*width/5, height-70, 100));
  ladders.add(new Ladder(3*width/5, height-70, 100));
  ladders.add(new Ladder(4*width/5, height-70, 100));
  
  //row 2
  y=height-130;
  x=(width/14)/2+width/14;
  scaffolding.add(new Ground(x-48, y,true,true));
  for (int i=0; i<numberPerRow-1; i++)
  {
    scaffolding.add(new Ground(x, y,false,true));
    x+=width/14-.6;
  }
  scaffolding.add(new Ground(x-10, y,true,false));
  ladders.add(new Ladder(width/3, height-190, 100));
  ladders.add(new Ladder(2*width/3, height-190, 100));
  
  //row 3
  y=height-250;
  x=(width/14)/2+width/14;
  for (int i=0; i<numberPerRow-1; i++)
  {
    if (i!=2 && i!=9) {
      scaffolding.add(new Ground(x, y));
    }
    x+=width/14-.6;
  }
  ladders.add(new Ladder(width/7, height-310, 100));
  mallets.add(new Mallet(width/7-20,height-310));
  ladders.add(new Ladder(2*width/5, height-310, 100));
  ladders.add(new Ladder(3*width/5, height-310, 100));
  ladders.add(new Ladder(width-width/7, height-310, 100));
  
  //row 4
  y=height-370;
  x=(width/14)/2+5;
  for (int i=0; i<numberPerRow+1; i++)
  {
    if (i!=6 && i!=7) {
      scaffolding.add(new Ground(x, y,false,true));
    }
    if(i==6)
    {
      scaffolding.add(new Ground(x-10, y,true,false));
    }
    x+=width/14-.6;
    if(i==7)
    {
      scaffolding.add(new Ground(x-48, y,true,true));
    }
  }
  ladders.add(new Ladder(width/7-40, height-430, 100));
  ladders.add(new Ladder(width-width/7+40, height-430, 100));
  
  //row 5
  y=height-490;
  x=(width/14)/2+width/14+5;
  scaffolding.add(new Ground(x-48, y,true,true));
  for (int i=0; i<numberPerRow-1; i++)
  {
    scaffolding.add(new Ground(x, y,false,true));
    x+=width/14-.6;
  }
  scaffolding.add(new Ground(x-10, y,true,false));
  ladders.add(new Ladder(2*width/5, height-550, 100));
  ladders.add(new Ladder(3*width/5, height-550, 100));
  
  //row 6
  x=(width/14)/2;
  y=height-610;
  for (int i=0; i<numberPerRow+1; i++)
  {
    if (i>4 && i<9) {
      scaffolding.add(new Ground(x, y));
    }
    x+=width/14-.6;
  }
  princessX=width/2;
  princessY=height-650;
  kong.setX(width/2);
  kong.setY(height-540);
}
