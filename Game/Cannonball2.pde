class Cannonball2 {

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
    ellipseMode(CENTER);
    fill(255,255,255,100);
    circle(cannonball2X, cannonball2Y, cannonball2Radius);
    if (isFired2 == true)
    {
      cannonball2Location.add(cannonball2Velocity);
    }
    //println("Fire!");
  }

  void shootCannonball(float playerPostion) {
    if (fireCooldown2 <= 0)
    {
      cannonball2Location.x = playerPostion;
      cannonball2Location.y = 100;
      isFired2 = true;
      fireCooldown2 = 120;
      println("Fire!");
    } else
    {
      println("Cooldown!");
    }
  }
}
