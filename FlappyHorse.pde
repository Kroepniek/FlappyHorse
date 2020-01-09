import processing.sound.*;

BackGround bg;
Bird bird;

RageCoin rageCoin;

ArrayList<Column> columns;
ArrayList<SoundFile> failSounds;
ArrayList<SoundFile> rageSounds;

int xScroll, xMoved;
float scrollSpeed;

int screenShake, shakeAmp;

int lastPipeX, pipeDist, pipesAfter;
int pipeHoleSizeMin, pipeHoleSizeMax;

int startDelay;

void setup()
{
  size(800, 500, P2D);
  
  background(0);
  
  frameRate(60);
  
  textAlign(CENTER, CENTER);
    
  failSounds = new ArrayList<SoundFile>();
  failSounds.add(new SoundFile(this, "sounds/fail_1.mp3"));
  failSounds.add(new SoundFile(this, "sounds/fail_2.mp3"));
  failSounds.add(new SoundFile(this, "sounds/fail_3.mp3"));
  failSounds.add(new SoundFile(this, "sounds/fail_4.mp3"));
  failSounds.add(new SoundFile(this, "sounds/fail_5.mp3"));
  failSounds.add(new SoundFile(this, "sounds/fail_6.mp3"));
  
  rageSounds = new ArrayList<SoundFile>();
  rageSounds.add(new SoundFile(this, "sounds/rage_1.mp3"));
  
  init();
}

void init()
{
  for (SoundFile failSound : failSounds)
  {
    if (failSound.isPlaying())
    {
      failSound.stop();
    }
  }
  
  xScroll = 0;
  scrollSpeed = 5;
  xMoved = 0;
  
  screenShake = 0;
  shakeAmp = 5;
  
  lastPipeX = 0;
  pipesAfter = 0;
  pipeDist = 200;
  pipeHoleSizeMin = 150;
  pipeHoleSizeMax = 200;
  
  startDelay = 3;
  
  bg       = new BackGround();
  columns  = new ArrayList<Column>();
  bird     = new Bird(200, height / 2 - 50, 75, 80);
  rageCoin = new RageCoin(400, 200);
}

void gameOver()
{ 
  scrollSpeed = 0;
}

void keyPressed()
{
  if (keyCode == ENTER)
  {
    if (!bird.started && scrollSpeed != 0)
    {
      startDelay = 0;
    }
  }
  else if (key == 'r')
  {
    init();
  }
  else if (key == 'g')
  {
    if (scrollSpeed != 0)
    {
      bird.rage();
    }
  }
  else if (key == ' ')
  {
    if (scrollSpeed != 0)
    {
      bird.jump();
    }
  }
}

void draw()
{
  background(255, 0, 0);
  image(bg.getImage(), -shakeAmp + xScroll + screenShake, -shakeAmp + screenShake);
  
  if (bird.rage)
  {
    screenShake = int(random(-shakeAmp, shakeAmp));
    tint(255, 0, 0);
  }
  else
  {
    screenShake = 0;
    noTint();
  }
  
  xScroll = int(xScroll - scrollSpeed <= -width + shakeAmp ? 0 : xScroll - scrollSpeed);
  
  if (startDelay == -1)
  {
    if (scrollSpeed != 0)
    {
      if (!bird.started)
      {
        bird.go();
      }
      
      xMoved += scrollSpeed;
      
      if (xMoved - lastPipeX > pipeDist)
      {
        int pipeHoleSize = int(random(pipeHoleSizeMin, pipeHoleSizeMax));
        int pipeHolePosX = int(random(50, (height - pipeHoleSize) - 50));
        
        columns.add(new Column(800, 50, pipeHolePosX, pipeHoleSize));
        lastPipeX = xMoved;
        
        pipeDist = int(random(200, 300));
      }
    }
  }
  else
  {    
    textSize(64);
    
    String delay = "" + (startDelay == 0 ? "Go!" : startDelay);
    
    fill(255);
    for(int x = -1; x < 2; x++)
    {
        text(delay, width / 2 + x, height / 3);
        text(delay, width / 2, height / 3 + x);
    }
    
    fill(255, 125, 25);
    text(delay, width / 2, height / 3);
    
    if (frameCount % 60 == 0)
    {
      startDelay--;
    }
  }
  
  ArrayList<Column> toRemove = new ArrayList<Column>();
      
  for (Column column : columns)
  {
    column.show();
    column.move();

    if (column.x + column.w < 0)
    {
      toRemove.add(column);
    }
  }
  
  for (Column columnToRemove : toRemove)
  {
    columns.remove(columnToRemove);
  }
  
  rageCoin.show();
  
  bird.show();
  bird.update();
  
  if (scrollSpeed == 0)
  {
    String score = "Distance: " + pipesAfter + " pipe" + (pipesAfter == 1 ? "" : "s");
    
    textSize(64);
    
    fill(255);
    for(int x = -1; x < 2; x++)
    {
        text(score, width / 2 + x, height / 3);
        text(score, width / 2, height / 3 + x);
    }
    
    fill(255, 125, 25);
    text(score, width / 2, height / 3);
  }
}
