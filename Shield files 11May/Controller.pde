/**
*  Controller class.
*  
*  @author Luke Dart, Scott Dimmock, Mark Gatus
*  @version 0.1
*  @since 3 May 2020 (Scott Dimmock)
*  
*  Filename: Controller.pde
*  Date:     27 March 2020
*
*/


class Controller {
  private Player player;
  private CollisionDetect collider;
  private int explosionFrame;
  private int menuIndex = 0;
  private boolean sUP, sDOWN, sLEFT, sRIGHT; 
  private final float SHIP_ACCELERATION = 0.1;
  private final float SHIP_ROTATION = 3.5;
  private final int HUD_MARGIN = 20;
  private final int HUD_HEIGHT = 32;
  private ArrayList<Asteroid> asteroids;
  private Bullets[] bullets;
  private Shield shield;
  private MainMenu mainMenu = new MainMenu();
  private boolean gameStarted = false;
  private final int NEW_ASTEROIDS_ON_DEST = 3;

  // Constructors

  /**
   * Function: Controller()
   *
   * @param Nil
   *
   * @return Controller
   *
   * Desc: Empty Constructor creates a new default Player object and itialises userInput booleans to false.
   */
  Controller() {
    this.player = new Player();
    asteroids = new ArrayList<Asteroid>();
    this.collider = new CollisionDetect();
    this.explosionFrame = 0;
    this.sUP = false;
    this.sLEFT = false;
    this.sRIGHT = false;
    this.sDOWN = false;
    this.bullets = new Bullets[0];
    //for (int i = 0; i < bullets.length; i++){
    //  bullets[i] = new Bullets(player.getLocation(), player.getBearing());
    //}
    shield = new Shield(player.getLocation(), player.getVelocity());
  }


  /**
   * Function: Controller()
   *
   * @param lives int - number of lives player has.
   *
   * @return Controller
   *
   * Desc: Constructor with lives parameter, creates a new Player object with specified number of lives
   * and itialises userInput booleans to false.
   */
  Controller(int lives) {
    player = new Player(lives);
    asteroids = new ArrayList<Asteroid>();
    this.explosionFrame = 0;
    this.sUP = false;
    this.sLEFT = false;
    this.sRIGHT = false;
    this.sDOWN = false;
    //for (int i = 0; i < bullets.length; i++){
    //  bullets[i] = new Bullets(player.getLocation(), player.getBearing());
    //}
    shield = new Shield(player.getLocation(), player.getVelocity());
    
  }  


  /**
   * Function: Controller()
   *
   * @param lives int - number of lives player has.
   * @param score int - Player score.
   *
   * @return Controller
   *
   * Desc: Constructor with lives and score parameters, creates a new Player object with specified score and number of lives 
   * and itialises userInput booleans to false.
   */
  Controller(int lives, int score){
    player = new Player(lives, score);
    asteroids = new ArrayList<Asteroid>();
    this.explosionFrame = 0;
    this.sUP = false;
    this.sLEFT = false;
    this.sRIGHT = false;
    this.sDOWN = false;
    //for (int i = 0; i < bullets.length; i++){
    //  bullets[i] = new Bullets(player.getLocation(), player.getBearing());
    //}
    shield = new Shield(player.getLocation(), player.getVelocity());
  }

  // Mutators

  /**
   * Function: setSUP()
   * 
   * @param state boolean - state to set variable to.
   *
   * @return void
   *
   * desc: Sets sUP variable to desired state.
   *
   * calls: Nil
   *
   * Affects: sUP
   */
  public void setSUP(boolean state) {
    this.sUP = state;
  }


  /**
   * Function: setSDOWN()
   * 
   * @param state boolean - state to set variable to.
   *
   * @return void
   *
   * desc: Sets sUP variable to desired state.
   *
   * calls: Nil
   *
   * Affects: sUP
   */
  public void setSDOWN(boolean state) {
    this.sDOWN = state;
  }

  /**
   * Function: setSLEFT()
   * 
   * @param state boolean - state to set variable to.
   *
   * @return void
   *
   * desc: Sets sLEFT variable to desired state.
   *
   * calls: Nil
   *
   * Affects: sLEFT
   */
  public void setSLEFT(boolean state) {
    this.sLEFT = state;
  }


  /**
   * Function: setSRIGHT()
   * 
   * @param state boolean - state to set variable to.
   *
   * @return void
   *
   * desc: Sets sRIGHT variable to desired state.
   *
   * calls: Nil
   *
   * Affects: sRIGHT
   */
  public void setSRIGHT(boolean state) {
    this.sRIGHT = state;
  }


  // Other Methods

  /**
   * Function: moveShip()
   * 
   * @param Nil
   *
   * @return void
   *
   * desc: Sets sUp variable to desired state.
   *
   * calls: Nil
   *
   * Affects: sUP
   */
  public void moveShip() {

    if (sUP && gameStarted) {
      this.player.accelerate(SHIP_ACCELERATION);
    }

    if (sRIGHT && gameStarted) {
      this.player.rotateShip(SHIP_ROTATION);
    }

    if (sLEFT && gameStarted) {
      this.player.rotateShip(-SHIP_ROTATION);
    }
  }

  public void moveMenu(){
    if (!gameStarted){
      if (sDOWN){
      //menu options go down
        menuIndexDown();
        this.drawMainMenu();
      }

      if (sUP){
      //menu options go up
        menuIndexUp();
        this.drawMainMenu();
      }
    }
  }

  private void menuIndexDown(){
    if (menuIndex == mainMenu.getMenuLength() - 1){
      menuIndex = 0;    
    } else {
      menuIndex++;
    }
    
  }

  private void menuIndexUp(){
    if (menuIndex == 0){
      menuIndex = mainMenu.getMenuLength() - 1;
    } else {
      menuIndex--;
    }
  }
  
  public void menuAction(){
    switch(menuIndex){
      
      //Start Game
      case 0:
        gameStarted = true;
        break;
      //High Scores
      case 1:
        break;
      //Quit
      case 2:
        exit();
        break;
      default:
    }
  }
  
  public void drawMainMenu(){
    if(!gameStarted){
      int textSize = 20;
      float textOffset = 40;
      boolean boldText = false;
      float textYPos = (height/2) - (((mainMenu.getMenuLength() * textSize) + (mainMenu.getMenuLength() - 1) * textOffset)/2);
      for (int i = 0; i < mainMenu.getMenuLength(); i++){
        if (menuIndex == i){
          boldText = true;
        }
        mainMenu.drawMenuItem(mainMenu.getMenuItems(i), width/2, textYPos + textOffset, boldText);
        textYPos += textOffset;
        boldText = false;        
      }
    }
  }
  
  public boolean getGameState(){
    return(this.gameStarted); 
  }

  /**
   * Function: updateShip()
   *
   * @param Nil 
   *
   * @return void
   *
   * Desc: Updates location based on velocity. 
   *       Checks edges of screen.
   *       Pushes matrix transformations, translate to location and rotate by bearing. 
   *       Draws flame offset on x axis by half image width and offset on y axis by flamePosition.
   *       Draws ship offset on x and y axis by half image width and height.
   *       Pop matrix transformations.
   *       Decelerates ship.
   *
   * Calls: add()
   *        edgeDetection()
   *        pushMatrix()
   *        translate()
   *        rotate()
   *        radians()
   *        drawShip()
   *        popMatrix()
   *        decelerate()
   *
   * Affects: player.location 
   *          display
   *          matrix
   */
  public void updateShip() {
    if (player.getAlive()) {
      player.setLocation(player.getLocation().add(player.getVelocity()));
      player.edgeDetection();
      pushMatrix();
      translate(player.getLocation().x, player.getLocation().y);
      pushMatrix();
      rotate(radians(player.getBearing()));
      player.drawShip();
      popMatrix();
      popMatrix();
      player.decelerate();
      newShield();
    } 
    
    else if(player.getLives() > 0) {
      if (this.explosionFrame < 130) {
        player.die(int(explosionFrame/10) * 192, player.getLocation());
        this.explosionFrame++;
        newShield();
        
      }
      
      else {
        this.explosionFrame = 0;
        player.updateLives(-1);
          if(player.getLives() > 0){
            player = new Player(player.getLives(), player.getScore());
            for (int i =0; i<shield.shieldDest.length; i++){
              shield.shieldDest[i] = 0;
            }
          }
      
          else{
            player.setAlive(false);
          }
        }  
      }
      
     else{
      text("GAME OVER", width / 2, height / 2 - textWidth("GAME")); 
     }
  }


  /**
   * Function: drawHUD()
   * 
   * @param Nil
   *
   * @return void
   *
   * desc: Draws a HUD to the top of the screen
   *
   * calls: Nil
   *
   * Affects: Display
   */
  public void drawHUD() {
    text("Lives:", HUD_MARGIN, HUD_HEIGHT);

    for (int i = 0; i < player.getLives(); i++) {
      player.drawShipIcon(int(HUD_MARGIN * i + textWidth("Lives:") * 2), HUD_MARGIN);
    }

    text("Score: " + player.getScore(), width - HUD_MARGIN - textWidth("Score: XXXXX"), HUD_HEIGHT);
  }

  //Scott's New code below

  /**
   * Function: randomPointOnCirc()
   *
   * @param Nil
   *
   * @return PVector
   *
   * Desc: produces a random point on a circle whose radius is the diagonal screen size
   *
   * Calls: random()
   *        sqrt()
   *        sq()
   *        cos()
   *        sin()
   *
   * Affects: Nil
   */
  private PVector randomPointOnCirc() {
    float radius = sqrt(sq(width) + sq(height));  
    float angle = random(359) * TWO_PI;
    float xPoint = cos(angle) * radius;
    float yPoint = sin(angle) * radius;

    return(new PVector(xPoint, yPoint));
  }
  /**
   * Function: randomVelocity()
   *
   * @param minSpeed int    The minimum speed for the random range
   * @param maxSpeed int    The maximum speed for the random range
   *
   * @return PVector
   *
   * Desc: Returns a PVector containing randomised values for use as a velocity.
   *
   * Calls: random()
   *        randomDir()
   *
   * Affects: Nil
   */
  private PVector randomVelocity(int minSpeed, int maxSpeed) {
    int xVel = (int)random(minSpeed, maxSpeed + 1) * randomDir();
    int yVel = (int)random(minSpeed, maxSpeed + 1) * randomDir();
    return(new PVector(xVel, yVel));
  }

  /**
   * Function: randomDir()
   *
   * @param Nil
   *
   * @return int
   *
   * Desc: Returns either a 1 or a -1.
   *
   * Calls: random()
   *
   * Affects: Nil
   */
  private int randomDir() {
    return(-1 + (int)random(2) * 2);
  }

  /**
   * Function: generateAsteroid()
   *
   * @param Nil
   *
   * @return Asteroid
   *
   * Desc: Returns a single Asteroid object with randomly generate position and velocity.
   *
   * Calls: randomPointOnCirc()
   *        randomVelocity()
   *
   * Affects: Nil
   */
  private Asteroid generateAsteroid() {
    PVector initPosition = randomPointOnCirc();
    Asteroid newAsteroid = new Asteroid(3, initPosition);
    newAsteroid.setVelocity(randomVelocity(newAsteroid.MIN_SPEED, newAsteroid.MAX_SPEED));
    return(newAsteroid);
  }
  
  /**
  * Function: addNewAsteroids()
  *
  * @param nil
  *
  * @return int
  *
  * Desc: Adds a single asteroid to the asteroids ArrayList.
  *
  * Calls: generateAsteroid()
  *
  * Affects: ArrayList<Asteroid> asteroids
  */
  public void addNewAsteroids(){
    asteroids.add(generateAsteroid());
  }
  
  /**
   * Function: addNewAsteroids()
   *
   * @param numberOfAsteroids int    The number of asteroids to add
   *
   * @return int
   *
   * Desc: Adds a given number of asteroids to the asteroids ArrayList.
   *
   * Calls: generateAsteroid()
   *
   * Affects: ArrayList<Asteroid> asteroids
   */
  public void addNewAsteroids(int numberOfAsteroids) {
    for (int i = 0; i < numberOfAsteroids; i++) {
      asteroids.add(generateAsteroid());
    }
  }



  
  
  /**
   * Function: drawAllAsteroids()
   *
   * @param Nil
   *
   * @return void
   *
   * Desc: Draws all asteroids in the asteroids ArrayList to the screen.
   *
   * Calls: Asteroid.updatePosition()
   *        Asteroid.getLocation()
   *        Asteroid.getImageSize()
   *        Asteroid.wrapXAxis()
   *        Asteroid.wrapYAxis()
   *        Asteroid.drawAsteroid()
   *        ArrayList.size()
   *        ArrayList.get()
   *
   * Affects: ArrayList<Asteroid> asteroids
   */
  public void drawAllAsteroids() {
    if (gameStarted){
      for (int i = 0; i < asteroids.size(); i++) {
        Asteroid currentAsteroid = asteroids.get(i);
        currentAsteroid.updatePosition();
        if (currentAsteroid.getLocation().x > width || currentAsteroid.getLocation().x < -currentAsteroid.getImageSize().x) {
          currentAsteroid.wrapXAxis();
        }
        if (currentAsteroid.getLocation().y > height || currentAsteroid.getLocation().y < -currentAsteroid.getImageSize().y) {
          currentAsteroid.wrapYAxis();
        }
        currentAsteroid.drawAsteroid();
      }
    }
  }

  /**
   * Function: checkForCollisions()
   *
   * @param Nil
   *
   * @return void
   *
   * Desc: Calls the CollisionDetect.detectCollision() method on each asteroid in the asteroids ArrayList
   *       against the player object
   *
   * Calls: CollisionDetect.detectCollision()
   *        Player.getBoundingBox
   *        ArrayList<Asteroid>.get()
   *        ArrayList<Asteroid>.size()
   *
   * Affects: ArrayList<Asteroid> asteroids
   */
  private void checkForCollisions() {
    for (int i = 0; i < asteroids.size(); i++) {
      Asteroid currentAsteroid = asteroids.get(i);
      for (int j=0; j < bullets.length; j++){
        Bullets currentBullet = bullets[j];
        if (collider.detectCollision(currentAsteroid, currentBullet.getLocation())){
          asteroidShot(i);
          bullets[j].setActive(false);
        }
      }
      if (collider.detectCollision(currentAsteroid, player.getBoundingBox())) {
        asteroids.remove(i);
        player.setAlive(false);
      }
      for (int k = 0; k < 4; k++){
          if (collider.detectCollision(currentAsteroid, shield.sx[k], shield.sy[k])){
            if (shield.shieldDest[k] == 0){
              asteroidShot(i);
              shield.shieldDest[k] = 1;
          }
        }
      }
    }
  }
  
  /**
  * Function: createBullet()
  *
  * @param Nil
  *
  * @return void
  *
  * Desc: Generates a bullet instance within a bullet class object array
  *
  * Calls: player.getLocation()
  *        player.getBearing()
  *
  * Affects: Bullets objects array
  */
  public void createBullet(){
    if (gameStarted){
      Bullets bullet = new Bullets(player.getLocation(), player.getBearing());
      bullets = (Bullets[]) append(bullets, bullet);
    }
  }
  
  /**
  * Function: updateBullets()
  *
  * @param Nil
  *
  * @return void
  *
  * Desc: Updates the position of the bullet and draws bullets to canvas
  *
  * Calls: bullets[].drawBullets()
  *        bullets[].updateBullets()
  *        bullets[].checkEdges()
  *
  * Affects: Bullets objects array
  */
  public void updateBullets(){
    for (int i = 0; i<bullets.length; i++){
      if(bullets[i].getActive()){
        bullets[i].drawBullets();
        bullets[i].updateBullets();
        bullets[i].checkEdges();
      }
    }
  }

  /**
  * Function: asteroidShot()
  *
  * @param asteroidIndex Int    The index of the asteroid within ArrayList asteroids that was shot
  *
  * @return void
  *
  * Desc: Destroys the asteroid that has been shot and if it is not at the smallest size replaces it
  *       with NEW_ASTEROIDS_ON_DEST asteroids
  *
  * Calls: Asteroid.getSize()
  *        Asteroid.getLocation()
  *        ArrayList<Asteroid>.get()
  *        ArrayList<Asteroid>.remove()
  *
  * Affects: ArrayList<Asteroid> asteroids
  *          int NEW_ASTEROIDS_ON_DEST
  */  
  public void asteroidShot(int asteroidIndex){
    Asteroid asteroid = asteroids.get(asteroidIndex);
    if (asteroid.getSize() > 1){
      PVector destroyLocation = asteroid.getLocation();
      addNewAsteroids(NEW_ASTEROIDS_ON_DEST, destroyLocation, asteroid.getSize() - 1);
    }
    asteroids.remove(asteroidIndex);
    
  }
  
  /**
  * Function: addNewAsteroids()
  *
  * @param numberOfAsteroids int    The number of asteroids to add
  *
  * @return int
  *
  * Desc: Adds a given number of asteroids to the asteroids ArrayList.
  *
  * Calls: generateAsteroid()
  *
  * Affects: ArrayList<Asteroid> asteroids
  */
  public void addNewAsteroids(int numberOfAsteroids, PVector location, int size){
    for (int i = 0; i < numberOfAsteroids; i++){
      asteroids.add(generateAsteroid(size, location));
    }
  }
  
  /**
  * Function: generateAsteroid()
  *
  * @param size int     The size of the asteroid to create.
  * @param location PVector   The location to generate the asteroid in.
  *
  * @return Asteroid
  *
  * Desc: Returns a single Asteroid object with a specified position and 
  *       a random velocity.
  *
  * Calls: randomVelocity()
  *        
  *
  * Affects: Nil
  */
  private Asteroid generateAsteroid(int size, PVector location){
    Asteroid newAsteroid = new Asteroid(size, location);
    newAsteroid.setVelocity(randomVelocity(newAsteroid.MIN_SPEED, newAsteroid.MAX_SPEED));
    return(newAsteroid);
  }
  
  public void newShield(){
     if (player.alive == false){
      for (int s = 0; s <shield.shieldDest.length; s++){
        shield.shieldDest[s] = 1;
      } 
    }
  }
  
  /**
  * Function: updateShield()
  *
  * @param Nil
  *
  * @return void
  *
  * Desc: Populates shield class and draws position of shield to canvas
  *
  * Calls: shield.shieldPopulate()
  *        shield.drawShield()
  *
  * Affects: Shield object
  */  
  public void updateShield(){
    shield.shieldPopulate(player.getLocation());
    shield.drawShield();
    //for(int i = 0; i<shield.circle.length; i++){
   //   shape(shield.circle[i]);
  //  }
 }  
  
}