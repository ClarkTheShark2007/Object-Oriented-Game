class Cannonball {

  PImage cannonBall;
  float fireCooldown = 0;
  boolean isFired = false;
  PVector cannonballLocation = new PVector(0, height*2);
  PVector cannonballVelocity = new PVector(0, -8);
  float cannonballX;
  float cannonballY;
  float cannonballRadius;

  Cannonball() {
    cannonBall = loadImage("CannonBall.png");
    cannonballRadius = 80;
  }

  void drawCannonball() {
    fireCooldown--;
    cannonballX = cannonballLocation.x+632;
    cannonballY = cannonballLocation.y+657;
    
    imageMode(CORNER);
    image(cannonBall, cannonballLocation.x, cannonballLocation.y);
    ellipseMode(CENTER);
    fill(255,255,255,100);
    //circle(cannonballX, cannonballY, cannonballRadius);
    if (isFired == true)
    {
      cannonballLocation.add(cannonballVelocity);
    }
    //println("Fire!");
  }

  void shootCannonball(float playerPostion) {
    if (fireCooldown <= 0)
    {
      cannonballLocation.x = playerPostion;
      cannonballLocation.y = 100;
      isFired = true;
      fireCooldown = 120;
      println("Fire!");
    } else
    {
      println("Cooldown!");
    }
  }
}
