class Player2 {

  PImage playerRed;
  PVector player2Location = new PVector(0, 0);
  PVector player2Velocity = new PVector(0, 0);
  PVector player2LeftAcceleration = new PVector(-0.1, 0);
  PVector player2RightAcceleration = new PVector(0.1, 0);
 int direction = 3;

  Player2() {
    playerRed = loadImage("PlayerRed.png");
  }

  void drawPlayer() {
    imageMode(CORNER);
    image(playerRed, player2Location.x, player2Location.y);
    movePlayer();
    checkPlayerPosistion();
    //println(direction);
    //println(player2Velocity);
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
   if(player2Location.x <= -640) 
   {
     direction = 0;
     player2Location.x = player2Location.x + 10;
     player2Velocity.x = player2Velocity.x * -1;
   }
      if(player2Location.x >= 640) 
   {
     direction = 0;
     player2Location.x = player2Location.x - 10;
     player2Velocity.x = player2Velocity.x * -1;
   }
  }
}
