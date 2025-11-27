class Cannonball {

  PImage cannonBall;
  float fireCooldown = 0;
  boolean isFired = false;
  PVector cannonballLocation = new PVector(0, height*2);
  PVector cannonballVelocity = new PVector(0, -8);

  Cannonball() {
    cannonBall = loadImage("CannonBall.png");
  }

  void drawCannonball() {
    fireCooldown--;
    imageMode(CORNER);
    image(cannonBall, cannonballLocation.x, cannonballLocation.y);
    rect(cannonballLocation.x, cannonballLocation.y, 10, 10);
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
