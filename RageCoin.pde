class RageCoin
{
  PVector location;
  
  PImage coin;
  
  int appearDelay = 5;
  int delayMin = 10;
  int delayMax = 20;
  
  RageCoin(int _x, int _y)
  {
    location = new PVector(_x, _y);
    
    coin = loadImage("pictures/rageCoin.png");
    coin.resize(50, 50);
  }
  
  boolean checkCollision(PVector loc, int wdth, int hght)
  {
    boolean col = (loc.x + wdth > location.x && loc.x < location.x + coin.width && loc.y + hght > location.y && loc.y < location.y + coin.height);
  
    boolean result = col && appearDelay == 0;

    if (col)
    {
      location = new PVector(-100, -100);
      appearDelay = int(random(delayMin, delayMax));
    }
        
    return result;
  }
  
  void move()
  {
    if (appearDelay == 0)
    {
      location.x -= int(scrollSpeed);
      
      if (location.x + coin.width < 0)
      {
        location = new PVector(-100, -100);
        appearDelay = int(random(delayMin, delayMax));
      }
    }
    else
    {
      if (frameCount % 60 == 0)
      {
        appearDelay--;
      }
      
      if (appearDelay <= 0)
      {
        appear();
      }
    }
  }
  
  void appear()
  {
    appearDelay = 0;

    Column lastPipe = columns.get(columns.size() - 1);
    
    int newX = (lastPipe.x + lastPipe.w / 2) - coin.width / 2;
    int newY = lastPipe.holePosY + lastPipe.holeSize / 2 - coin.height / 2;
    
    location = new PVector(newX, newY);
  }
  
  void show()
  {
    if (appearDelay == 0)
    {
      image(coin, location.x, location.y);
    }
  }
}
