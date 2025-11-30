class Cannonball {

  //Image 
  PImage cannonBall;
  
  //Varibles 
  PVector cannonballLocation = new PVector(0, height*2);
  PVector cannonballVelocity = new PVector(0, -8);
  float cannonballX;
  float cannonballY;
  float cannonballRadius;
  float fireCooldown = 0;
  boolean isFired = false;

  Cannonball() {
    cannonBall = loadImage("CannonBall.png");
    cannonballRadius = 80;
  }

  void drawCannonball() {
    fireCooldown--;
    cannonballX = cannonballLocation.x+632; //Images are the full screen width and height, this makes it the correct position when being drawn
    cannonballY = cannonballLocation.y+657;
    imageMode(CORNER);
    image(cannonBall, cannonballLocation.x, cannonballLocation.y);
    if (isFired == true)
    {
      cannonballLocation.add(cannonballVelocity);
    }
  }

  void shootCannonball(float playerPostion) { //Only shoots if the fire cooldown is below 0, Resets cannonball position back at the player, and sets cooldown to 120
    if (fireCooldown <= 0)
    {
      fire.play();
      cannonballLocation.x = playerPostion;
      cannonballLocation.y = 100;
      isFired = true;
      fireCooldown = 120;
    } 
  }

  void hitHamster() { //If a hamster is hit, draws cannonball off screen and resets cooldown
    cannonballLocation.y = -9999;
    fireCooldown = 0;
  }
}
