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


class Controller{
  private Player player;
  private CollisionDetect collider;
  private boolean sUP, sLEFT, sRIGHT; 
  private final float SHIP_ACCELERATION = 0.1;
  private final float SHIP_ROTATION = 3.5;
  private final int HUD_MARGIN = 20;
  private final int HUD_HEIGHT = 32;
  private ArrayList<Asteroid> asteroids;

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
  Controller(){
    this.player = new Player();
    this.asteroids = new ArrayList<Asteroid>();
    this.collider = new CollisionDetect();
    this.sUP = false;
    this.sLEFT = false;
    this.sRIGHT = false;
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
  Controller(int lives){
    player = new Player(lives);
    asteroids = new ArrayList<Asteroid>();
    this.sUP = false;
    this.sLEFT = false;
    this.sRIGHT = false;
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
  Controller(int lives, int score, int screenWidth, int screenHeight){
    player = new Player(lives, score);
    asteroids = new ArrayList<Asteroid>();
    this.sUP = false;
    this.sLEFT = false;
    this.sRIGHT = false;
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
  public void setSUP(boolean state){
    this.sUP = state; 
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
  public void setSLEFT(boolean state){
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
  public void setSRIGHT(boolean state){
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
  public void moveShip(){
  
    if(sUP){
      this.player.accelerate(SHIP_ACCELERATION);
    
    }

    if(sRIGHT){
      this.player.rotateShip(SHIP_ROTATION);
    }

    if(sLEFT){
      this.player.rotateShip(-SHIP_ROTATION);
    }
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
   public void updateShip(){
    player.setLocation(player.getLocation().add(player.getVelocity()));
    player.edgeDetection();
    shape(player.getBoundingBox());
    pushMatrix();
    translate(player.getLocation().x, player.getLocation().y);
    pushMatrix();
    rotate(radians(player.getBearing()));
    player.drawShip();
    popMatrix();
    popMatrix();
    player.decelerate();
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
  public void drawHUD(){
    text("Lives:", HUD_MARGIN, HUD_HEIGHT);
    
    for(int i = 0; i < player.getLives(); i++){
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
  private PVector randomPointOnCirc(){
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
  private PVector randomVelocity(int minSpeed, int maxSpeed){
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
  private int randomDir(){
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
  private Asteroid generateAsteroid(){
    PVector initPosition = randomPointOnCirc();
    Asteroid newAsteroid = new Asteroid(3, initPosition);
    newAsteroid.setVelocity(randomVelocity(newAsteroid.MIN_SPEED, newAsteroid.MAX_SPEED));
    return(newAsteroid);
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
  public void addNewAsteroids(int numberOfAsteroids){
    for (int i = 0; i < numberOfAsteroids; i++){
      asteroids.add(generateAsteroid());
    }
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
  public void drawAllAsteroids(){
    int j = 0;
    for (int i = 0; i < asteroids.size(); i++){
      Asteroid currentAsteroid = asteroids.get(i);
      currentAsteroid.updatePosition();
      if (currentAsteroid.getLocation().x > width || currentAsteroid.getLocation().x < -currentAsteroid.getImageSize().x) {
        currentAsteroid.wrapXAxis();
      }
      if (currentAsteroid.getLocation().y > height || currentAsteroid.getLocation().y < -currentAsteroid.getImageSize().y) {
        currentAsteroid.wrapYAxis();
      }
      currentAsteroid.drawAsteroid();
      if(checkForCollisions()){
//****Collision has occurred
      }
    }
  }
  
  /**
  * Function: checkForCollisions()
  *
  * @param Nil
  *
  * @return boolean
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
  private boolean checkForCollisions(){
    for (int i = 0; i < asteroids.size(); i++) {
      Asteroid currentAsteroid = asteroids.get(i);
      if(collider.detectCollision(currentAsteroid, player.getBoundingBox())){
        return(true);
      }
    }
    return(false);
  }

}
