///////////////////////////////////////////////////////////////////////
//
//  Assignment #4 Object Game - Legend of: Ham by Clark Osborne      //
//
//////////////////////////////////////////////////////////////////////

import processing.sound.*;

//Sounds - Used in diffrent scripts
SoundFile music;
SoundFile fire;
SoundFile gun;
SoundFile broken;
SoundFile explosion;

//Images
PImage selected[];
PImage grass;
PImage wall[];
PImage round;

//Classes
States state;
Player player;
Player2 player2;
Cannonball cannonball;
Cannonball2 cannonball2;
Hamster[] hamster = new Hamster[100];

//Non static Varibles
boolean newGame = true;
int P2Selected = 0; //0 = 1 player, 1 = 2 palyers

//Static Varibles - Used by hamster objects
static int playerHealth = 4;
int hasmterToSpawn = 0;
static int totalHamstersKilled = 0;
static int totalWaves = 0;


void setup() {
  size(1280, 1024, P2D);
  frameRate(60);
  
  //Load all sound files
  music = new SoundFile(this, "Background.wav");
  music.loop();

  fire = new SoundFile(this, "Cannon.wav");
  gun = new SoundFile(this, "Gun.wav");
  broken = new SoundFile(this, "Damage.wav");
  explosion = new SoundFile(this, "Explosion.wav");

  //Load Images
  grass = loadImage("Grass.png");
  round = loadImage("RoundsBar.png");

  selected = new PImage[2];
  selected[0] = loadImage("Selected0.png");
  selected[1] = loadImage("Selected1.png");

  wall = new PImage[5];
  wall[0] = loadImage("Wall0.png");
  wall[1] = loadImage("Wall1.png");
  wall[2] = loadImage("Wall2.png");
  wall[3] = loadImage("Wall3.png");
  wall[4] = loadImage("Wall4.png");

  //Class setup
  state = new States();
  player = new Player();
  player2 = new Player2();
  cannonball = new Cannonball();
  cannonball2 = new Cannonball2();

  //Randomize spawn location of all hamsters
  for (int i=0; i<hamster.length; i++) {
    float x = int(random(50, width-50));
    float y = int(random(-300, -100));
    hamster[i] = new Hamster(x, y, 50, 50);
  }
}

void draw() {
  if (newGame == true) { //If the game has been opened OR restarted, bool will become true only drawing the title screen
    state.title();
    imageMode(CORNER);
    image(selected[P2Selected], 0, 0); //Visual indicator of what option the player is currently selected
  }
  if (playerHealth <= 0) { //Game over checker, if the player is 0 HP, itll restart the varibles back to default and will await input to bring the player back to title screen
    state.gameOver();
    if (keyPressed == true) {
      playerHealth = 4;
      hasmterToSpawn = 0;
      totalHamstersKilled = 0;
      totalWaves = 0;
      newGame = true;
    }
  } else if (newGame == false) { //If the bool is false AND the player has health, then draw the game
    drawBackground();
    player.drawPlayer();
    checkToSpawnHamsters();
    cannonball.drawCannonball();
    drawUI();
    if (P2Selected == 1) { //Call Player 2 depedenent functions if selected, such as Collisons between both players
      player2.drawPlayer();
      cannonball2.drawCannonball();
      player.checkCollisionPlayer1(player2);
      player2.checkCollisionPlayer2(player);
    }
  }
}

void drawBackground() {
  imageMode(CORNER);
  image(grass, 0, 0);
  image(wall[playerHealth], 0, 0); //Draws a diffrent a wall depending on how much health the player has left 
}

void drawUI() {
  imageMode(CORNER);
  image(round, 0, 0);
  textSize(42);
  fill(255);
  textAlign(CENTER);
  text("Round " + totalWaves, width/2, 50);
}

void checkToSpawnHamsters()
{
  if (totalHamstersKilled >= hasmterToSpawn) //If the hamster that were all spawned for this round are eqaule to the amount that are dead, then go to the next wave
  {
    totalWaves++;
    hasmterToSpawn = int(random(1, totalWaves)); // Randomly chooses a number from 1 to how much wave have gone by
    for (int i = 0; i < hasmterToSpawn; i++) { //Only respawns how much hamsters were choosen
      hamster[i].respawn();
    }
  }

  for (int i = 0; i < hasmterToSpawn; i++) { //Constantly checking for collisions from cannonball and drawing the current hamster.
    hamster[i].checkCollision(cannonball);
    hamster[i].display();
    if (P2Selected == 1) {
      hamster[i].checkCollision2(cannonball2);
    }
  }
}

void keyReleased() { //Stops player from moving after a release of the key 
  if (key == 'a' || key == 'd') {
    player.direction = 0;
  }

  if (keyCode == LEFT && P2Selected == 1 || keyCode == RIGHT && P2Selected == 1 ) {
    player2.direction = 0;
  }
}

void keyPressed() { //Checks to see what screen the player is on, chaning the interacvity from each key 
  if (key == 'a') {
    if (newGame == true) 
    {
      P2Selected = 0; //Moves selection for title screen left
    }
    player.direction = -1; //Moves player to the left
  } else if (key == 'd') {
    if (newGame == true) 
    {
      P2Selected = 1; //Moves selection for title screen right
    }
    player.direction = 1; //Moves player to the Right
  }
  if (key == 'r' || key == 't' || key == 'y' || key == 'f' || key == 'g' || key == 'h' || key == 'v' || key == 'b') //If any of the right side arcade cabinet keys is pushed THEN
  {
    if (newGame == true) {
      newGame = false; //Brings player into the game and confirms amount of player choosen
    }
    cannonball.shootCannonball(player.playerLocation.x); //Calls the cannonball object
  }
  if (P2Selected == 1 && newGame == false) //IF the 2 players were selected, then allow for other side of arcade cabinit inputs to work
  {
    if (keyCode == LEFT) {
      player2.direction = -1;
    } else if (keyCode == RIGHT) {
      player2.direction = 1;
    }
    if (key == 'o' || key == 'p' || key == '[' || key == 'i' || key == ';' || key == 'h' || key == '.' || key == '/')
    {
      cannonball2.shootCannonball(player2.player2Location.x);
    }
  }
}
