class Cannonball {

  PImage cannonBall;
  float fireCooldown = 120;
  PVector cannonballLocation = new PVector(0, height*2);
  PVector cannonballVelocity = new PVector(0, 0);

  Cannonball() {
    cannonBall = loadImage("CannonBall.png");
  }

  void drawCannonball() {
    imageMode(CORNER);
    image(cannonBall, cannonballLocation.x, cannonballLocation.y);
    //println("Fire!");
  }

  void shootCannonball(float playerPostion) {
    cannonballLocation.x = playerPostion;
    cannonballLocation.y = 100;
    println("Fire!");
  }
}
