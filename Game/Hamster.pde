class Hamster {
  //Collison Guide code based off https://www.jeffreythompson.org/collision-detection/object_oriented_collision.php

  Player player;
  PImage hamster;
  float hamstehw;
  float hamstehh;
  PVector hamsterLocation = new PVector(0, 0);
  PVector hamsterVelocity = new PVector(0, 1);
  boolean hit = false;
  boolean dead = false;

  Hamster (float _x, float _y, float _w, float _h) {
    hamster = loadImage("Hamster1.png");
    player = new Player();

    hamsterLocation.x = _x;
    hamsterLocation.y = _y;
    hamstehw = _w;
    hamstehh = _h;
  }

  // draw the rectangle
  // if hit, change the fill color
  void checkCollision(Cannonball c) {
    hit = hamsterCannonball(c.cannonballX, c.cannonballY, c.cannonballRadius, hamsterLocation.x, hamsterLocation.y, hamstehw, hamstehh);
  }

  void display() {
    if (hit == true) {
      Game.totalHamstersKilled++;
      hamsterLocation.x = width + 100;
      hamsterLocation.y = height + 100;
      dead = true;
    }
    if (dead == false) {
      fill(0, 150, 255);
      noStroke();
      imageMode(CENTER);
      image(hamster, hamsterLocation.x, hamsterLocation.y);
      hamsterLocation.add(hamsterVelocity);
      hamsterAttack();

      //rectMode(CORNER);
      //rect(hamsterLocation.x, hamsterLocation.y, hamstehw, hamstehh);
    }
  }

  void respawn() {
    hamsterLocation.x = int(random(50, width-50)/50) * 50;
    hamsterLocation.y = int(random(-100, 0)/50) * 50;
    dead = false;
    totalHamstersKilled = 0;
  }

  void hamsterAttack() {
    if (hamsterLocation.y >= 724)
    {
      playerHealth--;
      hamsterLocation.x = int(random(50, width-50)/50) * 50;
      hamsterLocation.y = int(random(-100, 0)/50) * 50;
    }
  }

  boolean hamsterCannonball(float cx, float cy, float radius, float hx, float hy, float hw, float hh) {

    // temporahy variables to set edges for testing
    float testX = cx;
    float testY = cy;

    // which edge is closest?
    if (cx < hx)         testX = hx;      // compare left edge
    else if (cx > hx+hw) testX = hx+hw;   // right edge
    if (cy < hy)         testY = hy;      // top edge
    else if (cy > hy+hh) testY = hy+hh;   // bottom edge

    // get distance from closest edges
    float distX = cx-testX;
    float distY = cy-testY;
    float distance = sqrt( (distX*distX) + (distY*distY) );

    // if the distance is less than the radius, collision!
    if (distance <= radius) {
      return true;
    }
    return false;
  }
}
