class Cannonball2 {
  //Cannonball2 IS indentical TO Cannonball besides diffrent varible names, for comments at code look at Cannonball. Cannonball2 is used by player2! 
  
  PImage cannonBall;
  float fireCooldown2 = 0;
  boolean isFired2 = false;
  PVector cannonball2Location = new PVector(0, height*2);
  PVector cannonball2Velocity = new PVector(0, -8);
  float cannonball2X;
  float cannonball2Y;
  float cannonball2Radius;

  Cannonball2() {
    cannonBall = loadImage("CannonBall.png");
    cannonball2Radius = 80;
  }

  void drawCannonball() {
    fireCooldown2--;
    cannonball2X = cannonball2Location.x+632;
    cannonball2Y = cannonball2Location.y+657;

    imageMode(CORNER);
    image(cannonBall, cannonball2Location.x, cannonball2Location.y);
    if (isFired2 == true)
    {
      cannonball2Location.add(cannonball2Velocity);
    }
  }

  void shootCannonball(float playerPostion) {
    if (fireCooldown2 <= 0)
    {
      fire.play();
      cannonball2Location.y = 100;
      cannonball2Location.x = playerPostion;
      isFired2 = true;
      fireCooldown2 = 120;
    } 
  }

  void hit2Hamster() {
    cannonball2Location.y = -9999;
    fireCooldown2 = 0;
  }
}
