class States {
  
  //Images 
  PImage gameoverAnimation[];
  PImage titleAnimation[];
  
  //Animation Frames 
  int gameoverFrame;
  int titleFrame;

  States() {
    
    //Loads full animations for Title and Game over states
    gameoverAnimation = new PImage[5];
    for (int i = 0; i < gameoverAnimation.length; i++) {
      gameoverAnimation[i] = loadImage("GameOver" + (i + 1) + ".png");
    }

    titleAnimation = new PImage[5];
    for (int i = 0; i < titleAnimation.length; i++) {
      titleAnimation[i] = loadImage("Title" + (i + 1) + ".png");
    }
  }

  void gameOver() { //Called in the Game class only when player health is at 0
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

  void title() { //Called in the Game class only when a new game is being started 
    if (frameCount % 10 == 0) {
      titleFrame = (titleFrame + 1) %  titleAnimation.length;
    }
    imageMode(CORNER);
    background(0);
    image(titleAnimation[titleFrame], 0, 0);
  }
}
