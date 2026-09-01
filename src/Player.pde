class Player {
  
  public String name; 
  private int health;
  private int score;
  public int x; //x position
  public int y; // y position
  private PImage img; // avatar image
  private PImage caneImg_norm; // cane image in rest form
  private PImage caneImg_strike; // cane image in striking/attacking/slamming form
  
  //constructor
  public Player(String name, int health, int score, int x, int y) {
    this.name = name;
    this.health = health;
    this.score = score;
    this.x = x;
    this.y = y;
  }
  
  //Player setup; initialize images
  // Cannot be done in the constructor since the class is instantiated prior to 'void setup()' in the main file being called; images can only be loaded after 'void setup()' is called
  public void playerSetup() {
    if(name == "brooks"){
      this.img = loadImage("PrestonBrooks.jpg");
      this.caneImg_norm = loadImage("Cane2_norm.png");
      this.caneImg_strike = loadImage("Cane2_strike.png");
    } else if (name == "sumner") {
      this.img = loadImage("CharlesSummer.jpg");
      this.caneImg_norm = loadImage("Cane1_norm.png");
      this.caneImg_strike = loadImage("Cane1_strike.png");
    }
    img.resize(50,75);
    caneImg_norm.resize(70,70);
    caneImg_strike.resize(75,50);
  }
  
  //Getter for retrieving player data
  public int[] status() {
    //returns and integer array of shape 2 with the health at index 0, score at index 1
    int[] returnVal = {health,score};
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
      y -= 6;
    } else if(direction == 'd') {
      y += 6;
    } else if(direction == 'l') {
      x -= 6;
    } else if(direction == 'r') {
      x+= 6;
    }
  }
  
  //draw the player
  public void drawPlayer(boolean strike) { //takes a boolean denoting whether the player is striking or not as an argument to decide whether or not the cane should be shown slamming down
    image(img, x, y); //display avatar on screen
    if(name == "brooks") {
      if(strike) {
        image(caneImg_strike, x+40, y+30); //display cane being slammed
      } else {
        image(caneImg_norm,x+40,y); //display cane in resting position
      }
    } else {
      if(strike) {
        image(caneImg_strike, x-60, y+30);
      } else {
        image(caneImg_norm,x-60,y);
      }
    }
  }
  
  public void reset(int health, int score, int x, int y) {
    this.health = health;
    this.score = score;
    this.x = x;
    this.y = y;
  }
}
