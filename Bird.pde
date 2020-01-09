class Bird
{
  PVector location, velocity, gravity;
  int w, h;
  
  float angle = 0;
  float angleVel = 0;
  
  PImage bird;
    
  boolean started = false;
  boolean rage = false;
  float rageDelay = 0;
  
  private int lastPlayedFail = -1;
  private int lastPlayedRage = -1;
  
  Bird(int _x, int _y, int _w, int _h)
  {
    location = new PVector(_x, _y);
    velocity = new PVector(0, 2.1);
    gravity  = new PVector(0, 0.2);
    
    w = _w;
    h = _h;
    
    bird = loadImage("pictures/bird.png");
    bird.resize(w, h);
  }
  
  void go()
  {
    print("GO! \n");
    started = true;
  }
  
  void jump()
  {
    if (started)
    {
      angleVel = -5;
      velocity.y = -5; 
    }
  }
  
  void rage()
  {
    if (!rage)
    { 
      int r;
  
      do
      {
        r = int(random(rageSounds.size()));
      }
      while (r == lastPlayedRage && rageSounds.size() > 1);
      
      lastPlayedRage = r;
      
      rageSounds.get(r).play();

      rage = true;
      rageDelay = int(rageSounds.get(r).duration()) + 1.1;
    }
  }
  
  void update()
  {
    if (started)
    {
      location.add(velocity);
      velocity.add(gravity);
      angle += angleVel;
      
      angleVel *= 0.95;
      
      if (angle <= -10)
      {
        angleVel = 0;
      }
      
      if (velocity.y > 0)
      {
        angleVel = 1;
      }
      
      if (angle >= 0)
      {
        angleVel = 0;
        angle = 0;
      }
      
      if (location.y < 0)
      {
        velocity.y = 2.1;
      }
      
      if (location.y > height)
      {
        started = false;
        gameOver();
      }

      if (rage)
      {
        if (frameCount % 6 == 0)
        {
          rageDelay -= 0.1;
        }
        
        if (rageDelay <= 0)
        {
          rage = false;
          rageDelay = 0;
        }
      }
      
      for (Column column : columns)
      {
        if (scrollSpeed != 0)
        {
          if (column.checkCollision(location, w, h) && false)
          {
            print("Game Over \n");
            gameOver();
            
            rage = false;
            rageDelay = 0;
            
            int r;
            
            do
            {
              r = int(random(failSounds.size()));
            }
            while (r == lastPlayedFail && failSounds.size() > 1);
            
            lastPlayedFail = r;
            
            for (SoundFile rageSound : rageSounds)
            {
              if (rageSound.isPlaying())
              {
                rageSound.stop();
              }
            }
  
            failSounds.get(r).play();
          }  
        }
      }
    }
  }
  
  void show()
  {
    pushMatrix();
    
    translate(location.x, location.y);
    rotate(radians(angle));
    translate(-location.x, -location.y);
    
    image(bird, location.x, location.y);
    
    popMatrix();
  }
}
