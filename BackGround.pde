class BackGround
{
  private PImage bg;
  private PImage wp;

  BackGround()
  {
    prepareBackground();
  }
  
  PImage getImage()
  {
    return bg;
  }
  
  private void prepareBackground()
  {
    bg = createImage(width * 2, height + shakeAmp * 2, RGB);
    wp = loadImage("pictures/bg.png");
    wp.resize(width, height + shakeAmp * 2);
    
    bg.loadPixels();
    wp.loadPixels();
    
    for (int j = 0; j < wp.height; j++)
    {
      for (int i = 0; i < wp.width; i++)
      {
        int bgFirstPixelIndex = j * bg.width + i;
        int bgSecondPixelIndex = j * bg.width + i + wp.width;
        int wpPixelIndex = j * wp.width + i;
        
        bg.pixels[bgFirstPixelIndex] = wp.pixels[wpPixelIndex];
        bg.pixels[bgSecondPixelIndex] = wp.pixels[wpPixelIndex];
      }
    }
    
    bg.updatePixels();
  }
}
