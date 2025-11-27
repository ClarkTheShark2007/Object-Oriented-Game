PImage grass;
PImage wall[];

int playerHealth = 4;

void setup() {
  size(1280, 1024);
  grass = loadImage("Grass.png");
  wall = new PImage[5];
  wall[0] = loadImage("Wall0.png");
  wall[1] = loadImage("Wall1.png");
  wall[2] = loadImage("Wall2.png");
  wall[3] = loadImage("Wall3.png");
  wall[4] = loadImage("Wall4.png");
}

void draw() {
  drawBackground();
}

void drawBackground() {
  imageMode(CORNER);
  image(grass, 0, 0);
  image(wall[playerHealth], 0, 0);
}

void keyPressed() {
 playerHealth = playerHealth - 1; 
}
