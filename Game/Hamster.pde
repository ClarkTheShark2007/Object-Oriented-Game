class Hamster {
  //Collison Guide code based off https://www.jeffreythompson.org/collision-detection/object_oriented_collision.php

  Player player;
  PImage hamster;
  float hamstehx;
  float hamstehy;
  float hamstehw;
  float hamstehh;
  boolean hit = false;
  boolean dead = false;

  Hamster (float _x, float _y, float _w, float _h) {
    hamster = loadImage("Hamster1.png");
    player = new Player();

    hamstehx = _x;
    hamstehy = _y;
    hamstehw = _w;
    hamstehh = _h;
  }

  // draw the rectangle
  // if hit, change the fill color
  void checkCollision(Cannonball c) {
    hit = hamsterCannonball(c.cannonballX, c.cannonballY, c.cannonballRadius, hamstehx, hamstehy, hamstehw, hamstehh);
  }

  void display() {
    if (hit == true) {
      Game.totalHamstersKilled++;
      hamstehx = width + 100;
      hamstehy = height + 100;
      dead = true;
    }
    if (dead == false) {
      fill(0, 150, 255);
      noStroke();
      imageMode(CENTER);
      image(hamster, hamstehx, hamstehy);
      //rectMode(CORNER);
      //rect(hamstehx, hamstehy, hamstehw, hamstehh);
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
