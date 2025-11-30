class Player2 {

  PImage playerRed;
  PVector player2Location = new PVector(+150, 0);
  PVector player2Velocity = new PVector(0, 0);
  PVector player2LeftAcceleration = new PVector(-0.1, 0);
  PVector player2RightAcceleration = new PVector(0.1, 0);
  int direction = 3;
  float player2X;
  float player2Y;
  float playerRadius = 95;
  boolean hit = false;


  Player2() {
    playerRed = loadImage("PlayerRed.png");
  }

  void drawPlayer() {
    player2X = player2Location.x + 642;
    player2Y = 950;
    imageMode(CORNER);
    image(playerRed, player2Location.x, player2Location.y);
    movePlayer();
    checkPlayerPosistion();
    //println(direction);
    //println(player2Velocity);
  }

  void checkCollisionPlayer2(Player p) {
    println(hit);
    hit = playerToPlayer(player2X, player2Y, playerRadius, p.playerX, p.playerY, playerRadius);
  }

  void movePlayer() {
    if (direction == -1) {
      player2Velocity.add(player2LeftAcceleration);
      player2Location.add(player2Velocity);
    } else if (direction == 1)
    {
      player2Velocity.add(player2RightAcceleration);
      player2Location.add(player2Velocity);
    } else if (direction == 0)
    {
      player2Location.add(player2Velocity);
      if (player2Velocity.x < 0)
      {
        player2Velocity.x = player2Velocity.x + 0.1;
        if (player2Velocity.x >= 0) {
          player2Velocity.x = 0;
        }
      } else if (player2Velocity.x > 0)
      {
        player2Velocity.x = player2Velocity.x - 0.1;
        if (player2Velocity.x <= 0) {
          player2Velocity.x = 0;
        }
      }
    }
  }

  void checkPlayerPosistion() {
    if (hit == true) {
      direction = 0;
      player2Location.x = player2Location.x + 50;
      player2Velocity.x = player2Velocity.x * 1;
    }
    if (player2Location.x <= -640)
    {
      direction = 0;
      player2Location.x = player2Location.x + 10;
      player2Velocity.x = player2Velocity.x * -1;
    }
    if (player2Location.x >= 640)
    {
      direction = 0;
      player2Location.x = player2Location.x - 10;
      player2Velocity.x = player2Velocity.x * -1;
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
