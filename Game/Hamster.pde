class Hamster {
  //Collison Guide code based off https://www.jeffreythompson.org/collision-detection/object_oriented_collision.php

  PImage hamsterNormal[];
  PImage hamsterKnight[];
  PImage hamsterBomber[];
  PImage hamsterGunner[];

  int hamsterFrame;
  int hamsterType = 1;

  float hamsterSpeed = 1;
  int hamsterHealth = 1;
  int hamsterAnimationSpeed = 18;
  float hitCooldown = 0;
  float hamsterRangeCooldown = 120;

  float hamstehw;
  float hamstehh;
  PVector hamsterLocation = new PVector(0, 0);
  PVector hamsterVelocity = new PVector(0, 1);
  boolean hit = false;
  boolean hit2 = false;

  Hamster (float _x, float _y, float _w, float _h) {
    hamsterNormal = new PImage[2];
    hamsterNormal[0] = loadImage("1Hamster0.png");
    hamsterNormal[1] = loadImage("1Hamster1.png");

    hamsterKnight = new PImage[2];
    hamsterKnight[0] = loadImage("2Hamster0.png");
    hamsterKnight[1] = loadImage("2Hamster1.png");

    hamsterBomber = new PImage[2];
    hamsterBomber[0] = loadImage("3Hamster0.png");
    hamsterBomber[1] = loadImage("3Hamster1.png");

    hamsterGunner = new PImage[2];
    hamsterGunner[0] = loadImage("4Hamster0.png");
    hamsterGunner[1] = loadImage("4Hamster1.png");

    hamsterLocation.x = _x;
    hamsterLocation.y = _y;
    hamstehw = _w;
    hamstehh = _h;
  }

  // draw the rectangle
  // if hit, change the fill color
  void checkCollision(Cannonball c) {
    hit = hamsterCannonball(c.cannonballX, c.cannonballY, c.cannonballRadius, hamsterLocation.x, hamsterLocation.y, hamstehw, hamstehh);
    if(hit == true) {
      c.hitHamster();
    }
  }

  void checkCollision2(Cannonball2 c) {
    hit2 = hamsterCannonball2(c.cannonball2X, c.cannonball2Y, c.cannonball2Radius, hamsterLocation.x, hamsterLocation.y, hamstehw, hamstehh);
    c.hitHamster();
  }

  void display() {
    hitCooldown--;

    if (hit && hitCooldown <= 0 || hit2 && hitCooldown <= 0 )
    {
      hitCooldown = 30;
      hamsterHealth--;
      if (hamsterHealth <= 0) {
        Game.totalHamstersKilled++;
        hamsterLocation.x = -9999;
        hamsterLocation.y = -9999;
      }
    }
    if (hamsterHealth >= 0 && hamsterType == 1) {
      normalHamster();
    } else if (hamsterHealth >= 0 && hamsterType == 2)
    {
      knightHamster();
    } else if (hamsterHealth >= 0 && hamsterType == 3)
    {
      bomberHamster();
    } else if (hamsterHealth >= 0 && hamsterType == 4)
    {
      gunnerHamster();
    }
  }

  void respawn() {
    randomHamster();
    hamsterLocation.x = int(random(50, width-50));
    hamsterLocation.y = int(random(-100, -300));
    totalHamstersKilled = 0;
  }

  void hamsterAttack() {
    if (hamsterLocation.y >= 724)
    {
      playerHealth--;
      hamsterLocation.x = int(random(50, width-50));
      hamsterLocation.y = int(random(-300, -100));
      if(hamsterType == 3) {
        explosion.play();
      } else 
      {
        broken.play();
      }
    }
  }

  void hamsterRangeAttack() {
    if (hamsterLocation.y >= height/3)
    {
      hamsterSpeed = 0;
      hamsterRangeCooldown--;
      if (hamsterRangeCooldown <= 0)
      {
        gun.play();
        playerHealth--;
        hamsterRangeCooldown = 240;
      }
    }
  }
  void randomHamster() {
    if (totalWaves == 1) {
      hamsterType = int(random(1, 2));
    } else if (totalWaves <= 6) {
      hamsterType = int(random(1, 3));
    } else if (totalWaves >= 6) {
      hamsterType = int(random(1, 5));
    }

    hamsterType = int(random(1, 5));
    if (hamsterType == 1) {
      hamsterSpeed = 1;
      hamsterHealth = 1;
      hamsterAnimationSpeed = 18;
    } else if (hamsterType == 2)
    {
      hamsterSpeed = .5;
      hamsterHealth = 3;
      hamsterAnimationSpeed = 28;
    } else if (hamsterType == 3)
    {
      hamsterSpeed = 2.5;
      hamsterHealth = 1;
      hamsterAnimationSpeed = 4;
    } else if (hamsterType == 4)
    {
      hamsterSpeed = .75;
      hamsterHealth = 2;
      hamsterAnimationSpeed = 24;
    }
  }

  void normalHamster() {
    if (frameCount % hamsterAnimationSpeed == 0) {
      hamsterFrame = (hamsterFrame + 1) %  hamsterNormal.length;
    }
    imageMode(CENTER);
    image(hamsterNormal[hamsterFrame], hamsterLocation.x, hamsterLocation.y);
    hamsterLocation.y = hamsterLocation.y + hamsterSpeed;
    hamsterAttack();
  }

  void knightHamster() {
    if (frameCount % hamsterAnimationSpeed == 0) {
      hamsterFrame = (hamsterFrame + 1) %  hamsterNormal.length;
    }
    imageMode(CENTER);
    image(hamsterKnight[hamsterFrame], hamsterLocation.x, hamsterLocation.y);
    hamsterLocation.y = hamsterLocation.y + hamsterSpeed;
    hamsterAttack();
  }

  void bomberHamster() {
    if (frameCount % hamsterAnimationSpeed == 0) {
      hamsterFrame = (hamsterFrame + 1) %  hamsterNormal.length;
    }
    imageMode(CENTER);
    image(hamsterBomber[hamsterFrame], hamsterLocation.x, hamsterLocation.y);
    hamsterLocation.y = hamsterLocation.y + hamsterSpeed;
    hamsterAttack();
  }

  void gunnerHamster() {
    if (frameCount % hamsterAnimationSpeed == 0) {
      hamsterFrame = (hamsterFrame + 1) %  hamsterNormal.length;
    }
    imageMode(CENTER);
    image(hamsterGunner[hamsterFrame], hamsterLocation.x, hamsterLocation.y);
    hamsterLocation.y = hamsterLocation.y + hamsterSpeed;
    hamsterRangeAttack();
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

boolean hamsterCannonball2(float cx2, float cy2, float radius2, float hx, float hy, float hw, float hh) {

  // temporahy variables to set edges for testing
  float testX = cx2;
  float testY = cy2;

  // which edge is closest?
  if (cx2 < hx)         testX = hx;      // compare left edge
  else if (cx2 > hx+hw) testX = hx+hw;   // right edge
  if (cy2 < hy)         testY = hy;      // top edge
  else if (cy2 > hy+hh) testY = hy+hh;   // bottom edge

  // get distance from closest edges
  float distX = cx2-testX;
  float distY = cy2-testY;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  // if the distance is less than the radius, collision!
  if (distance <= radius2) {
    return true;
  }
  return false;
}
