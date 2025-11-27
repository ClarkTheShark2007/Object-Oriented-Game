class Player {

  PImage playerBlue;
  PVector playerLocation = new PVector(0, 0);
  PVector playerVelocity = new PVector(0, 0);
  PVector playerLeftAcceleration = new PVector(-0.1, 0);
  PVector playerRightAcceleration = new PVector(0.1, 0);
  int direction = 3;

  Player() {
    playerBlue = loadImage("PlayerBlue.png");
  }

  void drawPlayer() {
    playerLeftAcceleration = new PVector(-0.1, 0);
    image(playerBlue, playerLocation.x, playerLocation.y);
    movePlayer();
    println(direction);
    println(playerVelocity);
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
}
