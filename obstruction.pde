class Barrier 
{
  float bottom;
  float w = 30; 
  float x; 
  float barrier_speed = 2; 
  
  Barrier()
  {
    bottom = random(150, 170); 
    x = wid + w; 
  }
  void update ()
  {
    if(start)
    {
      x -= barrier_speed; 
    }
  }
  

  boolean hits(Player b)
  {
    return ((b.pos.x > x) && (b.pos.x < (x + wid))) &&  (b.pos.y > (height - bottom - b.r));
  }
  void show(boolean hit)
  {
    
      if(start) 
      {
          if(hit)
          {

            fill(200,60,20,100);
          }
          else
          {

            fill(200,60,20,100);
          }
        stroke(0,0,0);
        strokeWeight(2);
        rect(x, height - bottom, w, bottom-110);
      
      }
    
  }
}
