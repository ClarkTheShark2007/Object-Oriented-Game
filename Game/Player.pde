class Player {

  Player2 player2;
  PImage playerBlue;
  PVector playerLocation = new PVector(-150, 0);
  PVector playerVelocity = new PVector(0, 0);
  float playerX;
  float playerY;
  float playerRadius = 95;
  PVector playerLeftAcceleration = new PVector(-0.1, 0);
  PVector playerRightAcceleration = new PVector(0.1, 0);
  int direction = 3;
  boolean hit = false;

  Player() {
    playerBlue = loadImage("PlayerBlue.png");
    player2 = new Player2();
  }

  void drawPlayer() {
    playerX = playerLocation.x + 642;
    playerY = 950;
    imageMode(CORNER);
    image(playerBlue, playerLocation.x, playerLocation.y);
    movePlayer();
    checkPlayerPosistion();
    //println(direction);
    //println(playerVelocity);
  }

  void checkCollisionPlayer1(Player2 p) {
    println(hit);
    hit = playerToPlayer(playerX, playerY, playerRadius, p.player2X, p.player2Y, playerRadius);
  }

  void movePlayer() {
    if (direction == -1) {
      playerVelocity.add(playerLeftAcceleration);
      playerLocation.add(playerVelocity);
    } else if (direction == 1)
    {
      playerVelocity.add(playerRightAcceleration);
      playerLocation.add(playerVelocity);
    } else if (direction == 0)
    {
      playerLocation.add(playerVelocity);
      if (playerVelocity.x < 0)
      {
        playerVelocity.x = playerVelocity.x + 0.1;
        if (playerVelocity.x >= 0) {
          playerVelocity.x = 0;
        }
      } else if (playerVelocity.x > 0)
      {
        playerVelocity.x = playerVelocity.x - 0.1;
        if (playerVelocity.x <= 0) {
          playerVelocity.x = 0;
        }
      }
    }
  }

  void checkPlayerPosistion() {
    if (hit == true) {
      direction = 0;
      playerLocation.x = playerLocation.x - 50;
      playerVelocity.x = playerVelocity.x * -1;
    }
    if (playerLocation.x <= -640)
    {
      direction = 0;
      playerLocation.x = playerLocation.x + 10;
      playerVelocity.x = playerVelocity.x * -1;
    }
    if (playerLocation.x >= 640)
    {
      direction = 0;
      playerLocation.x = playerLocation.x - 10;
      playerVelocity.x = playerVelocity.x * -1;
    }
  }



  boolean playerToPlayer(float c1x, float c1y, float c1r, float c2x, float c2y, float c2r) {

    // get distance between the circle's centers
    // use the Pythagorean Theorem to compute the distance
    float distX = c1x - c2x;
    float distY = c1y - c2y;
    float distance = sqrt( (distX*distX) + (distY*distY) );

    // if the distance is less than the sum of the circle's
    // radii, the circles are touching!
    if (distance <= c1r+c2r) {
      return true;
    }
    return false;
  }
}
