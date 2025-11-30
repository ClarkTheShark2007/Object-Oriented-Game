States state;
Player player;
Cannonball cannonball;
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
  player = new Player();
  cannonball = new Cannonball();
  state = new States();

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
    println(P2Selected);
    
    
  }
  if (playerHealth <= 0) {
    state.gameOver();
    if (keyPressed == true) {
      playerHealth = 4;
      hasmterToSpawn = 0;
      totalHamstersKilled = 0;
      totalWaves = 0;
    }
  } else if (newGame == false) {
    drawBackground();
    player.drawPlayer();
    checkToSpawnHamsters();
    cannonball.drawCannonball();
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
    hamster[i].display();
  }
  println(hasmterToSpawn + " " + totalHamstersKilled + " " + totalWaves);
}

void keyReleased() {
  if (key == 'a' || key == 'd') {
    player.direction = 0;
  }
}

void keyPressed() {
  if (key == 'a') {
     if(newGame == true) 
    {
      P2Selected = 0;
    }
    player.direction = -1;
  } else if (key == 'd') {
    if(newGame == true) 
    {
      P2Selected = 1;
    }
    player.direction = 1;
  }
  if (key == 'v')
  {
    if(newGame == true) { 
      newGame = false;
    }
    cannonball.shootCannonball(player.playerLocation.x);
  }
}
