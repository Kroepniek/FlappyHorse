class RageCoin
{
  PVector location;
  
  PImage coin;
  
  RageCoin(int _x, int _y)
  {
    location = new PVector(_x, _y);
    
    coin = loadImage("pictures/rageCoin.png");
    coin.resize(50, 50);
  }
  
  void show()
  {
    image(coin, location.x, location.y);
  }
}
