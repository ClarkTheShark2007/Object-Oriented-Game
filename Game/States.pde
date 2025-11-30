class States {

  PImage gameoverAnimation[];
  PImage titleAnimation[];
  int gameoverFrame;
  int titleFrame;

  States() {
    gameoverAnimation = new PImage[5];
    for (int i = 0; i < gameoverAnimation.length; i++) {
      gameoverAnimation[i] = loadImage("GameOver" + (i + 1) + ".png");
    }

    titleAnimation = new PImage[5];
    for (int i = 0; i < titleAnimation.length; i++) {
      titleAnimation[i] = loadImage("Title" + (i + 1) + ".png");
    }
  }

  void gameOver() {
    if (frameCount % 10 == 0) {
      gameoverFrame = (gameoverFrame + 1) %  gameoverAnimation.length;
    }
    imageMode(CORNER);
    background(0);
    image(gameoverAnimation[gameoverFrame], 0, 0);
    textSize(64);
    textAlign(CENTER);
    text("PUSH ANY BUTTON TO RESTART", width/2, 900);
  }

  void title() {
    if (frameCount % 10 == 0) {
      titleFrame = (titleFrame + 1) %  titleAnimation.length;
    }
    imageMode(CORNER);
    background(0);
    image(titleAnimation[titleFrame], 0, 0);
  }
}
