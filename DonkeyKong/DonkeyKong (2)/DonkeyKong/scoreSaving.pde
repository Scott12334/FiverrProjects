boolean names[];
int[] scores;
String[] scoreBoardNames;
int changedSpot;
String name1= "";
void loadScore()
{
  String[] inputs= loadStrings("scores.txt");
  for (int i=0; i<10; i++)
  {
    String currentLine=inputs[i+1];
    scores[i]= Integer.parseInt(currentLine.substring(currentLine.indexOf(",")+2, currentLine.length()));
    scoreBoardNames[i]= currentLine.substring(currentLine.indexOf(":"), currentLine.indexOf(","));
    println(scores[i]+scoreBoardNames[i]);
  }
}
void saveScore1()
{

  if (score>scores[0])
  {
    scores[0]=score;
    scoreBoardNames[0]=": "+name1;
    changedSpot=0;
    for (int i=0; i<9; i++)
    {
      if (scores[i]>scores[i+1])
      {
        int tempScore=scores[i+1];
        String tempString=scoreBoardNames[i+1];
        scores[i+1]=scores[i];
        scoreBoardNames[i+1]=scoreBoardNames[i];
        scores[i]=tempScore;
        scoreBoardNames[i]=tempString;
      } else {
        break;
      }
    }
  } 
  println("");
  for (int i=0; i<10; i++)
  {
    print(scoreBoardNames[i]+ ", ");
    print(scores[i]+ ", ");
  }
  String[] outputText= new String[11];
  outputText[0]= "**TOP TEN SCORES**";
  for (int i=0; i<10; i++)
  {
    int place=10-i;
    outputText[i+1]=place+scoreBoardNames[i]+", "+scores[i];
  }
  saveStrings("scores.txt", outputText);
}
