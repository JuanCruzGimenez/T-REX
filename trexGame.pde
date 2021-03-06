import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
int ledPin = 13;
int buttonPin = 7;
int ldrpin = 0;

Player b; 
PImage pl; 

int score=0; 
int highScore=0; 
boolean safe=true; 
boolean start=false; 

PVector gravity = new PVector(0, 0.1);
ArrayList<Barrier> barriers = new ArrayList<Barrier>(); 
int wid = 1100; 

void setup()
{
  arduino = new Arduino(this, Arduino.list()[1], 57600);
  arduino.pinMode(ledPin, Arduino.OUTPUT);
  arduino.pinMode(buttonPin, Arduino.INPUT);
  
  size(1100,400); 
  b = new Player(); 
  pl = loadImage("snowball.png"); 
  
}

void draw()
{
  
  if(start) 
    {
    
      if(random(1)<0.5&&frameCount % 60 == 0)
        {
          barriers.add(new Barrier()); 
        }
    }
    
    
   if(keyPressed || arduino.digitalRead(buttonPin)==Arduino.HIGH || arduino.analogRead(ldrpin)<800)
    {
      start = true;
      if(b.pos.y == height-170)
        {
          PVector up = new PVector(0,-100); 
          b.applyForce(up);
        }
      
    }
  
   background(255,255,102); 
   b.update(); 
   b.show(); 

 
    for(int i=barriers.size()-1; i>=0; i--)
    {
        Barrier p = barriers.get(i);
        p.update();
        
        if (p.hits(b))
          {
            p.show(true);
            safe=false;
          }
        else
          {
            p.show(false);
            safe=true;
          }
        
       
        if(p.x < -p.w)
          {
            barriers.remove(i);
          }
    }
  
  if(safe&&start)
    {
      score++;
    }
  else
    {

      score=0;
      text("CLICK TO START",width/2-500,50);
      start=false; 
    }
    
    fill(16,53,201); 
    textSize(32);
    
    //Display score
    text("Score",width/2-100,50);
    text(score,width/2,50);
    

    if(highScore < score)
    {
      highScore = score;
    }
    
    text(highScore,width/2+310,50);
    text("High Score",width/2+300-170,50);
  
}
