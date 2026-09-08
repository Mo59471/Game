class CharlesSumner extends Player {
    
  public CharlesSumner(int health, int score, int x, int y) {
    super(health, score, x, y); //pass in constructor variables to the parent class
  }
  
  @Override //Override annotation; denote the follwoing method overrides the parent class method
  public void playerSetup() {
    super.setImg("CharlesSummer.jpg", "Cane1_norm.png", "Cane1_strike.png"); //pass Charles Sumner images into the parent class setter
    super.playerSetup(); // call the parent class setup method to resize images
  }
  
  @Override
  public void drawPlayer(boolean strike) {
    super.drawPlayer(strike); // call the parent class draw method to display avatar image
    if(strike) { //if attacking, slam cane down (call image data with getter)
      image(super.getImg()[1], super.position()[0]-60, super.position()[1]+30);
    } else { //resting cane position
      image(super.getImg()[0], super.position()[0]-60,super.position()[1]);
    }
  }
  
  @Override
  public void incrementCooldown() { //update cooldown (called in draw)
    super.incrementCooldown();
    if(super.getCooldown() == 60) {
      super.setCooldown(0); 
      super.setAbilityUsed(false);
    } //if the dodge is not used, cooldown halts increment, sets to 0
  }
  
  @Override
  public void useAbility(int jumpX, int jumpY) { //args unused here: these arguments only apply for PrestonBrooks, but are needed since overriding methods must be identical to the parent method definition
    if(super.getCooldown() == 0) {
      int randX = int(random(width-50)); //Select random position vars
      int randY = int(random(height-75));
      super.setPosition(randX, randY); //pass into the setter in the parent class
      super.setAbilityUsed(true);
    }
  }
  
}
