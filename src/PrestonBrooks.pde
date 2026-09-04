class PrestonBrooks extends Player {
  
  private boolean jumpUsed; //boolean flag to track whether the jump attack move is available
  private int coolDown; //cooldown counter
  
  public PrestonBrooks(int health, int score, int x, int y) {
    super(health, score, x, y); //pass in constructor params into the parent class
    this.jumpUsed = false;
    this.coolDown = 0;
  }
  
  @Override
  public void playerSetup() {
    super.setImg("PrestonBrooks.jpg", "Cane2_norm.png", "Cane2_strike.png"); //pass in Preston Brooks images into the parent class img setter
    super.playerSetup();
  }
  
  @Override
  public void drawPlayer(boolean strike) {
    super.drawPlayer(strike); // call the parent class draw method to display the avatar
    if(strike) { // display cane slammed down if striking
      image(super.getImg()[1], super.position()[0]+40, super.position()[1]+30);
    } else { // resting cane image
      image(super.getImg()[0], super.position()[0]+40,super.position()[1]);
    }
  }
  
  public void incrementCooldown() { // update cooldown
    if(jumpUsed) {coolDown += 1;}
    if(coolDown == 30) {coolDown = 0; jumpUsed = false;}
  }
  
  public void jumpAttack(int jumpX, int jumpY) { //take parameters that correspond to the position of p2
    if(coolDown == 0) {
      super.setPosition(jumpX, jumpY); // jump to p2 position (use the position setter in parent class)
      jumpUsed = true;
    }
  }
  
}
