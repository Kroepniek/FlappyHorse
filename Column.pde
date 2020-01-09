class Column
{
  private int x;
  private int w;
  
  private int holePosY;
  private int holeSize;
  
  private PImage pipeTop, pipeBottom;
  
  private boolean skip = false;
  
  Column(int _x, int _w, int _holePosY, int _holeSize)
  {
    x = _x;
    w = _w;
    
    holePosY = _holePosY;
    holeSize = _holeSize;
    
    pipeTop = loadImage("pictures/pipeTop.png");
    pipeTop.resize(w, height);
    
    pipeBottom = loadImage("pictures/pipeBottom.png");
    pipeBottom.resize(w, height);
  }
  
  boolean checkCollision(PVector loc, int wdth, int hght)
  {
    return
    // Top Pipe
    (loc.x + wdth > x && loc.x < x + w && loc.y + hght > 0 && loc.y < holePosY) ||
    // Bottom Pipe
    (loc.x + wdth > x && loc.x < x + w && loc.y + hght > holePosY + holeSize && loc.y < height);
  }
  
  void move()
  {
    x -= scrollSpeed;
    
    if (x + w < bird.location.x && !skip)
    {
      pipesAfter++;
      
      scrollSpeed += 0.05;
      
      skip = true;
    }
  }
  
  void show()
  {
    image(pipeTop, x, -(height - holePosY));
    image(pipeBottom, x, holePosY + holeSize);
  }
}
