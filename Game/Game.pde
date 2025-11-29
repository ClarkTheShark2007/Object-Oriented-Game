Player player;
Cannonball cannonball;
Hamster[] hamster = new Hamster[100];

PImage grass;
PImage wall[];

static int playerHealth = 4;

int hasmterToSpawn = 0;
static int totalHamstersKilled = 0;
static int totalWaves = 0;


void setup() {
  size(1280, 1024, P2D);
  frameRate(60);
  player = new Player();
  cannonball = new Cannonball();

  grass = loadImage("Grass.png");
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
  drawBackground();
  player.drawPlayer();
  checkToSpawnHamsters();
  cannonball.drawCannonball();
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
  if (keyCode == LEFT || keyCode == RIGHT) {
    player.direction = 0;
  }
}

void keyPressed() {
  if (keyCode == LEFT) {
    player.direction = -1;
  } else if (keyCode == RIGHT) {
    player.direction = 1;
  }
  if (key == 'v')
  {
    cannonball.shootCannonball(player.playerLocation.x);
  }
}
