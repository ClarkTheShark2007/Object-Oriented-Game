class Player {
 
  PImage playerBlue;
  
  Player() {
   playerBlue = loadImage("PlayerBlue.png");
 }
 
 void drawPlayer() {
   image(playerBlue, 0, 0);
 }
 
}
