class Player {
  //Collison Guide code based off https://www.jeffreythompson.org/collision-detection/object_oriented_collision.php

  //Class
  Player2 player2;
  
  //Image
  PImage playerBlue;
  
  //Player Varibles 
  PVector playerLocation = new PVector(-150, 0);
  PVector playerVelocity = new PVector(0, 0);
  PVector playerLeftAcceleration = new PVector(-0.1, 0);
  PVector playerRightAcceleration = new PVector(0.1, 0);
  int direction = 3;
  
  //Player Collision 
  float playerX;
  float playerY;
  float playerRadius = 95;
  boolean hit = false;

  Player() {
    playerBlue = loadImage("PlayerBlue.png");
    player2 = new Player2();
  }

  void drawPlayer() { //Constantly drawing the player sprite based off current posistion
    playerX = playerLocation.x + 642;
    playerY = 950;
    imageMode(CORNER);
    image(playerBlue, playerLocation.x, playerLocation.y);
    movePlayer();
    checkPlayerPosistion();
  }

//Adapted from Collison guide
  void checkCollisionPlayer1(Player2 p) { //Only active IF player 2 was selected in the title menu, checks to see if player 1 and 2 are colliding with each other
    hit = playerToPlayer(playerX, playerY, playerRadius, p.player2X, p.player2Y, playerRadius);
  }
//Adapted from Collison guide

  void movePlayer() { //Changes current acceleration AND velocity depending on what the vlaue the direction is currently set too. Direction determined by Game script 
    if (direction == -1) { //Left Movement
      playerVelocity.add(playerLeftAcceleration);
      playerLocation.add(playerVelocity);
    } else if (direction == 1) //Right movement
    {
      playerVelocity.add(playerRightAcceleration);
      playerLocation.add(playerVelocity);
    } else if (direction == 0) //Slow down player if no input is being decected
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

  void checkPlayerPosistion() { //Checks to see if current player is going off the screen, if so then bounce them in the other direction and change current velcoity to match new direction
    if (hit == true) {
      direction = 0;
      playerLocation.x = playerLocation.x - 50;
      playerVelocity.x = playerVelocity.x * -1;
    }
    if (playerLocation.x <= -640) //Left Screen
    {
      direction = 0;
      playerLocation.x = playerLocation.x + 10;
      playerVelocity.x = playerVelocity.x * -1;
    }
    if (playerLocation.x >= 640) //Right screen
    {
      direction = 0;
      playerLocation.x = playerLocation.x - 10;
      playerVelocity.x = playerVelocity.x * -1;
    }
  }

//Collision between Player to Player, used from https://www.jeffreythompson.org/collision-detection/object_oriented_collision.php
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
