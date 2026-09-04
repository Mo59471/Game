class Player {
  
  private int health;
  private int score;
  private int x; //x position
  private int y; // y position
  private PImage img; // avatar image
  private PImage caneImg_norm; // cane image in rest form
  private PImage caneImg_strike; // cane image in striking/attacking/slamming form
  
  //constructor
  public Player(int health, int score, int x, int y) {
    this.health = health;
    this.score = score;
    this.x = x;
    this.y = y;
  }
  
  //Setter for images
  public void setImg(String imgName, String caneImgName, String caneStrikeImgName) {
    this.img = loadImage(imgName);
    this.caneImg_norm = loadImage(caneImgName);
    this.caneImg_strike = loadImage(caneStrikeImgName);
  }
  
  //Player setup; initialize images
  // Cannot be done in the constructor since the class is instantiated prior to 'void setup()' in the main file being called; images can only be loaded after 'void setup()' is called
  public void playerSetup() {
    img.resize(50,75);
    caneImg_norm.resize(70,70);
    caneImg_strike.resize(75,50);
  }
  
  //getter for images
  public PImage[] getImg() {
    PImage[] returnVal = {caneImg_norm, caneImg_strike};
    return returnVal;
  }
  
  //Getter for retrieving player status data
  public int[] status() {
    //returns and integer array of shape 2 with the health at index 0, score at index 1
    int[] returnVal = {health,score};
    return returnVal;
  }
  
  //setter for position data
  public void setPosition(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  //Getter for retrieving position data
  public int[] position() {
    int[] returnVal = {x,y};
    return returnVal;
  }
  
  // check if hitbox is contacted
  public boolean hitbox(int hitX, int hitY) { //takes position of cane as argument
      if(hitX <= x+50 && hitX >=x && hitY >= y && hitY <= y+75) { //conditional statement to check if contacted
        return true; //return true if hit
      } else {
        return false;
      }
    }
  
  //modify health upon damage
  public void takeDamage(int damage) {
    health -= damage;
  }
  
  // modify score upon a hit
  public void addScore(int amount) {
    score += amount;
  }
  
  // move (update x and y values) based on the direction argument
  public void move(char direction) {
    if(direction == 'u') {
      if(y > 0) { //check for screen edge before movign
        y -= 6;
      }
    } else if(direction == 'd') { 
      if(y < height-70) { //check for screen edge before movign
        y += 6;
      }
    } else if(direction == 'l') {
      if(x>0) { //check for screen edge before movign
        x -= 6;
      }
    } else if(direction == 'r') {
      if(x<width-50) { //check for screen edge before movign
        x+= 6;
      }
    }
  }
  
  //draw the player
  public void drawPlayer(boolean strike) { //NOTE: the arg is not used here, but is still denoted so that overriding can be done in the subclasses where the arg is used
    image(img, x, y); //display avatar on screen
  }
  
  public void reset(int health, int score, int x, int y) { //reset member vars
    this.health = health;
    this.score = score;
    this.x = x;
    this.y = y;
  }
}
