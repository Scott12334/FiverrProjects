import controlP5.*;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 
import ddf.minim.*; 
import ddf.minim.analysis.*; 

Minim minim;
AudioPlayer song;
FFT fft;
PShape spinCircle;
float rotation=0;
int cB=0;
int lB=0;
float actualHeight;
ArrayList<Button> buttons;
ArrayList<Particle> particles;
int currentSong;
boolean mouseReleased=true;
ArrayList<Integer> numbers;
int[] songList;
PImage[] buttonImages;
ControlP5 cp5;
float volume=1;
public void setup()
{
  cp5 = new ControlP5(this);
  size(900, 900);
  //these lines of code generate the song list

  //start by creating 21 numbers
  numbers= new ArrayList<Integer>();
  for (int i=1; i<22; i++)
  {
    numbers.add(i);
  }
  //this array will control what current song is playing, needs to be random
  songList= new int[21];
  for (int i=0; i<songList.length; i++)
  {
    int nextSong = (int)random(numbers.size()); //get a random index from the arraylist of numbers
    songList[i]=numbers.get(nextSong); //set the index in the array to the random number from the arraylist
    numbers.remove(nextSong); //remove that index from the possible numbers
  }
  buttonImages= new PImage[2];
  buttonImages[0]= loadImage("pause.png");
  buttonImages[1]= loadImage("play.png");
  minim = new Minim(this);
  currentSong=0; //start at the first song
  String songFile= "Song "+songList[currentSong]+".mp3"; //create a string using the number song that should play and grab that file
  actualHeight=height-100; //allows for the bottom grey box
  song = minim.loadFile(songFile, 512); //create the sound object
  song.play();
  //object that reads sound frequency
  fft = new FFT(song.bufferSize(), song.sampleRate());
  //spinning circle in middle
  spinCircle = createShape(ELLIPSE, 0, 0, width/2, width/2);
  spinCircle.setFill(0);
  spinCircle.setStroke(color(0, 0, 255));
  //create the buttons on the bottom
  buttons=new ArrayList<Button>();
  imageMode(CENTER);
  cp5.addButton("Pause").setImage(loadImage("pause.png")).updateSize().setPosition(width/2-75, height-90);
  cp5.addButton("Play").setImage(loadImage("play.png")).updateSize().setPosition(width/2+25, height-83);
  cp5.addButton("nextSong").setImage(loadImage("nextSong.png")).updateSize().setPosition(width/2+125, height-81);
  cp5.addButton("lastSong").setImage(loadImage("lastSong.png")).updateSize().setPosition(width/2-175, height-81);
  cp5.addSlider("Volume").setPosition(width/2-450,height-60).setSize(200,30).setRange(0,100).setValue(90);
  //create the arraylist that will hold all the particles
  particles=new ArrayList<Particle>();
  for (int i=0; i<30; i++)
  {
    //add the particles to the list
    particles.add(new Particle(random(width), random(height-100)));
  }
}

public void draw()
{
  background(0);
  fft.forward(song.mix);
  strokeWeight(6);
  spinCircle.rotate(rotation); //rotates the circle in the middle
  shape(spinCircle, width/2, actualHeight/2); //draws the big circle in the middle
  strokeWeight(2);
  stroke(255, 0, lB);
  for (int i = 0; i < fft.specSize(); i++) { 
    //control the lines of the left side of the screen by taking the base and making that the height
    line(i, actualHeight, i, actualHeight - fft.getBand(i)*16);
    line(i, 0, i, 0 + fft.getBand(i)*16);
    //controls the lines on the right side of the screen
    line(width-i, 0, width-i, 0 + fft.getBand(i)*16);
    line(width-i, actualHeight, width-i, actualHeight - fft.getBand(i)*16);
    if (lB<255) {
      lB++;
    } else {
      lB=0;
    }
  } 
  //controls the circles in the middle and their size, again based on the base
  for (int i = 0; i < fft.specSize(); i+=8) { 
    fill(0, 255, cB);
    circle(width/2, actualHeight/2, fft.getBand(i));
    circle(width/5, 2*actualHeight/3, fft.getBand(i)/3);
    circle(4*width/5, 2*actualHeight/3, fft.getBand(i)/3);
    for (int x=0; x<particles.size(); x++)
    {
      //the same values that control the size of the lines and circles control the speed of the particles
      particles.get(x).display(fft.getBand(i)/3, fft.getBand(i)/3);
    }    
    //change the color of the circles
    if (cB<255) {
      cB++;
    } else {
      cB=0;
    }
  }
  rotation+=.5f; //rotate the colors
  //display the bottom and the buttons
  rectMode(CENTER);
  fill(#babdc2);
  rect(width/2, height-50, width+100, 100);
  for (int i=0; i<buttons.size(); i++)
  {
    buttons.get(i).display();
  }
  song.setGain(volume-35);
}
//runs when the next song button is pressed
void newSong()
{
  song.pause(); //stops the current song
  //checks to make sure the current song isn't the last one
  if (currentSong<songList.length)
  {
    currentSong++;//moves to the next index
  }
  //creates the new object
  String songFile= "Song "+songList[currentSong]+".mp3";
  song = minim.loadFile(songFile, 512);
  //plays that new object
  song.play();
}
//runs when the last song button is pressed
void oldSong()
{
  song.pause();
  //makes sure the current song isn't the first one
  if (currentSong>0)
  {
    currentSong--; //moves the index back
  }
  //creates a new object
  String songFile= "Song "+songList[currentSong]+".mp3";
  song = minim.loadFile(songFile, 512);
  song.play();
  //plays that new object
}
public void Pause()
{
  if(song.isPlaying()==true)
  {
    song.pause();
  }
}
public void Play()
{
  if(song.isPlaying()==false)
  {
    song.play();
  }
}
public void nextSong()
{
  newSong();
}
public void lastSong()
{
  oldSong();
}
public void Volume(int value)
{
  volume=value;
}
void mouseReleased() {
  mouseReleased=true;
}
