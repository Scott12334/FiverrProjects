public class Button
{
  float x;
  float y;
  int type;
  boolean clicked=false;
  public Button(float x, float y, int type)
  {
    this.x=x;
    this.y=y;
    this.type=type;
  }
  public void display()
  {
    collision();
    //displays each the correct button type, and what to do if it is clicked
    switch(type)
    {
      case 0://play button
      playButton();
      if(clicked==true && song.isPlaying()==false)
      {
        song.play();
        clicked=false;
      }
      break;
      
      case 1://pause button
      pauseButton();
      if(clicked==true && song.isPlaying()==true)
      {
        song.pause();
        clicked=false;
      }
      break;
      
      case 2://next song
      nextSong();
      if(clicked==true)
      {
        newSong();
        clicked=false;
      }
      break;
      
      case 3://last song
      lastSong();
      if(clicked==true)
      {
        oldSong();
        clicked=false;
      }
      break;
      
    }
  }
  //each one of these methods will display a different type of button
  void playButton()
  {
    stroke(0);
    fill(0);
    triangle(x-25,y+25,x-25,y-25,x+25,y);
  }
  void pauseButton()
  {
    stroke(0);
    fill(0);
    rectMode(CENTER);
    rect(x-20,y,20,50);
    rect(x+20,y,20,50);
  }
  void nextSong()
  {
    stroke(0);
    fill(0);
    rect(x,y,15,50);
    triangle(x+25,y+25,x+25,y-25,x+50,y);
  }

  //checks to see if the button is pressed
  void collision()
  {
    if(dist(mouseX,mouseY,x,y)<50 && mousePressed==true && mouseReleased==true)
    {
      clicked=true;
      mouseReleased=false; //prevents multiple clicks without realising the mouse
    }
  }
}
