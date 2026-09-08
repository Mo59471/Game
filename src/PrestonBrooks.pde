class PrestonBrooks extends Player {
  
  public PrestonBrooks(int health, int score, int x, int y) {
    super(health, score, x, y); //pass in constructor params into the parent class
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
  
  @Override
  public void incrementCooldown() { //update cooldown (called in draw)
    super.incrementCooldown();
    if(super.getCooldown() == 30) {
      super.setCooldown(0); 
      super.setAbilityUsed(false);
    } //if the dodge is not used, cooldown halts increment, sets to 0
  }
  
  @Override
  public void useAbility(int jumpX, int jumpY) { //take parameters that correspond to the position of p2
    if(super.getCooldown() == 0) {
      super.setPosition(jumpX, jumpY); // jump to p2 position (use the position setter in parent class)
      super.setAbilityUsed(true);
    }
  }
  
}


