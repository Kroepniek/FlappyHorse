static class Pipe
{
  enum side
  {
    Top,
    Bottom
  };
}

class Column
{
  private int x;
  private int w;
  
  private int holePosY;
  private int holeSize;
  
  private PImage pipeTop, pipeBottom;
  private boolean pipeTopColliding, pipeBottomColliding;
  
  private boolean skip = false;
  
  Column(int _x, int _w, int _holePosY, int _holeSize)
  {
    x = _x;
    w = _w;
    
    holePosY = _holePosY;
    holeSize = _holeSize;
    
    pipeTop = loadImage("pictures/pipeTop.png");
    pipeTop.resize(w, height);
    pipeTopColliding = true;
    
    pipeBottom = loadImage("pictures/pipeBottom.png");
    pipeBottom.resize(w, height);
    pipeBottomColliding = true;
  }
  
  boolean checkCollision(PVector loc, int wdth, int hght)
  {
    boolean topCollided = (loc.x + wdth > x && loc.x < x + w && loc.y + hght > 0 && loc.y < holePosY);
    boolean bottomCollided = (loc.x + wdth > x && loc.x < x + w && loc.y + hght > holePosY + holeSize && loc.y < height);
    
    if (bird.rage)
    {
      if (topCollided)
      {
        dissolve(Pipe.side.Top);
      }
      else if (bottomCollided)
      {
        dissolve(Pipe.side.Bottom);
      }
    }
    
    return
      (topCollided && pipeTopColliding) ||
      (bottomCollided && pipeBottomColliding);
  }
  
  void dissolve(Pipe.side pS)
  {
    switch (pS)
    {
      case Top:
        pipeTopColliding = false;
        break;
       
      case Bottom:
        pipeBottomColliding = false;
        break;
    }
  }
  
  void move()
  {
    x -= int(scrollSpeed);
    
    if (x + w < bird.location.x && !skip)
    {
      pipesAfter++;
      pipesAfterCache++;
            
      skip = true;
    }
  }
  
  void show()
  {
    if (!pipeTopColliding)
    {
      tint(255, 0);
    }
    image(pipeTop, x, -(height - holePosY));
    
    if (bird.rage)
    {
      tint(255, 0, 0);
    }
    else
    {
      tint(255, 255);
    }
    
    if (!pipeBottomColliding)
    {
      tint(255, 0);
    }
    image(pipeBottom, x, holePosY + holeSize);
    
    if (bird.rage)
    {
      tint(255, 0, 0);
    }
    else
    {
      tint(255, 255);
    }
  }
}
