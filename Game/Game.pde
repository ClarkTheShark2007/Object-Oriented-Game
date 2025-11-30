States state;
Player player;
Player2 player2;
Cannonball cannonball;
Cannonball2 cannonball2;
Hamster[] hamster = new Hamster[100];

PImage selected[];
PImage grass;
PImage wall[];

float stateCooldown = 120;
boolean newGame = true;
int P2Selected = 1;


static int playerHealth = 1;
int hasmterToSpawn = 0;
static int totalHamstersKilled = 0;
static int totalWaves = 0;


void setup() {
  size(1280, 1024, P2D);
  frameRate(60);
  state = new States();
  player = new Player();
  player2 = new Player2();
  cannonball = new Cannonball();
  cannonball2 = new Cannonball2();

  grass = loadImage("Grass.png");

  selected = new PImage[2];
  selected[0] = loadImage("Selected0.png");
  selected[1] = loadImage("Selected1.png");

  wall = new PImage[5];
  wall[0] = loadImage("Wall0.png");
  wall[1] = loadImage("Wall1.png");
  wall[2] = loadImage("Wall2.png");
  wall[3] = loadImage("Wall3.png");
  wall[4] = loadImage("Wall4.png");

  for (int i=0; i<hamster.length; i++) {
    float x = int(random(50, width-50));
    float y = int(random(-300, -100));
    hamster[i] = new Hamster(x, y, 50, 50);
  }
}

void draw() {
  if (newGame == true) {
    state.title();
    imageMode(CORNER);
    image(selected[P2Selected], 0, 0);
  }
  if (playerHealth <= 0) {
    state.gameOver();
    if (keyPressed == true) {
      playerHealth = 4;
      hasmterToSpawn = 0;
      totalHamstersKilled = 0;
      totalWaves = 0;
      newGame = true;
    }
  } else if (newGame == false) {
    drawBackground();
    player.drawPlayer();
    player.checkCollisionPlayer1(player2);
    player2.checkCollisionPlayer2(player);
    checkToSpawnHamsters();
    cannonball.drawCannonball();
    if (P2Selected == 1) {
      player2.drawPlayer();
      cannonball2.drawCannonball();
    }
  }
}

void drawBackground() {
  imageMode(CORNER);
  image(grass, 0, 0);
  image(wall[playerHealth], 0, 0);
}

void checkToSpawnHamsters()
{
  if (totalHamstersKilled >= hasmterToSpawn)
  {
    totalWaves++;
    hasmterToSpawn = int(random(1, totalWaves));
    for (int i = 0; i < hasmterToSpawn; i++) {
      hamster[i].respawn();
    }
  }

  for (int i = 0; i < hasmterToSpawn; i++) {
    hamster[i].checkCollision(cannonball);
    hamster[i].checkCollision2(cannonball2);
    hamster[i].display();
  }
}

void keyReleased() {
  if (key == 'a' || key == 'd') {
    player.direction = 0;
  }
  
  if(keyCode == LEFT || keyCode == RIGHT) {
    player2.direction = 0;
  }
}

void keyPressed() {
  if (key == 'a') {
    if (newGame == true)
    {
      P2Selected = 0;
    }
    player.direction = -1;
  } else if (key == 'd') {
    if (newGame == true)
    {
      P2Selected = 1;
    }
    player.direction = 1;
  }
  if (key == 'r' || key == 't' || key == 'y' || key == 'f' || key == 'g' || key == 'h' || key == 'v' || key == 'b')
  {
    if (newGame == true) {
      newGame = false;
    }
    cannonball.shootCannonball(player.playerLocation.x);
  }
  if (P2Selected == 1 && newGame == false)
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
