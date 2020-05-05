/**************************************************************
* File: AsteroidsGame.pde
* Group: Luke Dart, Scott Dimmock, Mark Gatus, group number 10
* Date: 27/03/2020
* Updated: 03/05/2020 (Scott Dimmock)
* Course: COSC101 - Software Development Studio 1
* Desc: Astroids is a ...
* ...
* Usage: Make sure to run in the processing environment and press play etc...
* Notes: If any third party items are use they need to be credited (don't use anything with copyright - unless you have permission)
* ...
**************************************************************/

Controller controller;

void setup(){
 size(800,800);
 textSize(15);
 controller = new Controller();
 controller.addNewAsteroids(1);
}

void draw(){
 background(0); 
 controller.updateShip(); 
 controller.moveShip();
 controller.drawHUD();
 controller.drawAllAsteroids();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      controller.setSUP(true);
      
    }
    if (keyCode == RIGHT) {
      controller.setSRIGHT(true);
    }
    if (keyCode == LEFT) {
      controller.setSLEFT(true);
    }
  }
  if (key == ' ') {
    //TO-DO: IMPEMENT FIRING - SPACEBAR?
    //fire a shot
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      controller.setSUP(false);
    }
    if (keyCode == RIGHT) {
      controller.setSRIGHT(false);
    }
    if (keyCode == LEFT) {
      controller.setSLEFT(false);
    }
  }
}
  
