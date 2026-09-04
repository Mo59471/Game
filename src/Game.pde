//Mo Spiegel | Period 4B | AP Computer Programming

/** 
PROJECT REFLECTION: 
Your two objects were created from the same class. What did they share, and what remained independent for each object?

Both objects shared the same health upon instantiation (100), and the same score upon instantiation (0).
However, during the game loop, each object individually tracked and updated these parameters.
The name parameter differed between each object, and so did each object's img (avatar) member variable upon instantiation.
Each object started at a different initial position, and each tracked their own position as the game loop progressed independently.
**/


/** 

GAME SUMMARY:
- Basic two player same device fight game
- Player 1 takes the role of Preston Brooks (left on screen)
- Player 2 takes the role of Charles Sumner (right on screen)
- Players have 100 health, each cain hit does 2 damage
- Each hit adds one to a player's score

PLAYER 1 (Preston Brooks) CONTROLS:
- WASD to move
- Q to attack with cane
- E to jump attack (jump to p2's position to cane them, cooldown 1s) 

PLAYER 2 (Charlse Sumner) CONTROLS:
- IJKL to move
- O to attack with cane
- SPACE to dodge (jump to random position, cooldown 2s)

HISTORICAL BACKGROUND:

On May 22, 1856, Representative Preston Brooks of South Carolina brutally beat 
Senator Charles Sumner of Massachusetts at his desk in the U.S. Senate chamber.
This was due to Sumner's fiery anti-slavery speech just two days earlier, 
during which he criticized pro-slavery politicians including
South Carolina Senator Andrew Butler, who was a relative of Preston Brooks.

Brooks then decided to beat Sumner with a cane.

In this reimagination, Sumner and Brooks have an epic 'caning battle'
(highly historically inaccurate) that players control

**/

//instantiate player classes
PrestonBrooks p1 = new PrestonBrooks(100, 0, 50, 250) ;
CharlesSumner p2 = new CharlesSumner(100, 0, 400, 250);

// Control flags:
//booleans for tracking whether the controls for movement are being held (up, down, left right) for each player
boolean p1Up = false;
boolean p1Down = false;
boolean p1Left = false;
boolean p1Right = false;
boolean p2Up = false;
boolean p2Down = false;
boolean p2Left = false;
boolean p2Right = false;

// booleans for tracking whether the attack key is being held down for each player
boolean p1Strike = false;
boolean p2Strike = false;

// char which tracks the current screen (later used in switch block screen manager)
char screen = 'p'; // 'p': play screen | '1': player 1 win screen | '2': player 2 win screen

// Setup (call once at start)
void setup(){
  size(500, 500);
  background(255,255,255);
  /** Call player setup:
  PURPOSE: initialize images (for cane and player avatar)
  that can't be created prior to setup being called, 
  i.e. can't be set in the constructor at class instantiation) **/
  p1.playerSetup();
  p2.playerSetup();
}

// Key detection logic
// Detects user input; sets the boolean control flags correspondingly
void keyPressed() {
  if(key == 'w') {
    p1Up = true;
  } 
  if (key == 's') {
    p1Down = true;
  } 
  if (key == 'a') {
    p1Left = true;
  } 
  if (key == 'd') {
    p1Right = true;
  } 
  if(key == 'i') {
    p2Up = true;
  } 
  if(key == 'k') {
    p2Down = true;
  } 
  if(key == 'j') {
    p2Left = true;
  } 
  if(key == 'l') {
    p2Right = true;
  }
  
  if(key == 'q') {
    if(!p1Strike) { //Insures that a hit only registers the first time the attack key is pressed instead of registering over and over while held
      p1Strike = true;
      if(p2.hitbox(p1.position()[0] + 100,p1.position()[1]+30)) { //Check if player 2's hitbox is contacted; pass in position of player 1's cane
        p2.takeDamage(2); //Pass in damage
        p1.addScore(1); //Update score
        println("Damage"); 
      }
    }
  }
  if(key == 'o') {
    if(!p2Strike) {
      p2Strike = true;
      if(p1.hitbox(p2.position()[0] - 50,p2.position()[1]+30)) {
        p1.takeDamage(2);
        p2.addScore(1);
        println("Damage");
      }  
    }
  }
  if(key == 'e') {
    p1.jumpAttack(p2.position()[0], p2.position()[1]); // jump attack; pass in p2's position using the getter 
  }
  if(key == ' ' && (screen == '1' || screen == '2')) {
    screen = 'p';
    //Reset players (reinstantiate)
    p1.reset(100, 0, 50, 250);
    p2.reset(100, 0, 400, 250);
  } else if (key == ' ') { //dodge move
    p2.dodge();
  }
}
//Key release logic; sets corresponding boolean control flags to false once key is released
void keyReleased() {
  if(key == 'w') {
    p1Up = false;
  } 
  if (key == 's') {
    p1Down = false;
  } 
  if (key == 'a') {
    p1Left = false;
  } 
  if (key == 'd') {
    p1Right = false;
  } 
  if(key == 'i') {
    p2Up = false;
  } 
  if(key == 'k') {
    p2Down = false;
  }
  if(key == 'j') {
    p2Left = false;
  } 
  if(key == 'l') {
    p2Right = false;
  }
  
  if(key == 'q') {
    p1Strike = false;
  }
  if(key == 'o') {
    p2Strike = false;
  }
}

// interaction/draw loop
void draw() {
  switch(screen) { //screen manager
    case 'p': // play screen
      background(255,255,255);
      
      //Strings corresponding to player 1 and player 2 health and score (accessed with the 'getter' status)
      String brooksHealth = "Preston Brooks Health: " + str(p1.status()[0]);
      String brooksScore = "Preston Brooks Score: " +str(p1.status()[1]);
      String sumnerHealth = "Charles Sumner Health: " + str(p2.status()[0]);
      String sumnerScore = "Charles Sumner Score: " +str(p2.status()[1]);
      
      //display health and score
      textAlign(CORNER);
      fill(0,0,0);
      textSize(15);
      text(brooksHealth, 10, 20);
      text(brooksScore, 10, 35);
      text(sumnerHealth, 300, 20);
      text(sumnerScore, 300, 35);
      
      //Draw the players (show cane being slammed if attack keys have been pressed)
      p1.drawPlayer(p1Strike);
      p2.drawPlayer(p2Strike);
    
      // move players based on boolean control flags
      if(p1Up) {
        p1.move('u'); //char argument denotes which direction to move in
      }
       if(p1Down) {
        p1.move('d');
      }
       if(p1Left) {
        p1.move('l');
      }
       if(p1Right) {
        p1.move('r');
      }
      if(p2Up) {
        p2.move('u');
      }
       if(p2Down) {
        p2.move('d');
      }
       if(p2Left) {
        p2.move('l');
      }
       if(p2Right) {
        p2.move('r');
      }
      //Update screen if either of the player's health drops to 0
      if (p1.status()[0] == 0) {
        screen = '2';
      } else if (p2.status()[0] == 0) {
        screen = '1';
      }
      p2.incrementCooldown(); //Increment cooldowns for both player's dodge/jumpAttack
      p1.incrementCooldown();
      break;
    case '1': //player 1 win screen
      background(0,0,0);
      fill(255,255,255);
      textAlign(CENTER);
      textSize(30);
      text("Preston Brooks Wins!",width/2,height/2);
      textSize(15);
      text("Press the spacebar to play again", width/2, height/2+20);
      break;
    case '2': //player 2 win screen
      background(0,0,0);
      fill(255,255,255);
      textAlign(CENTER);
      textSize(30);
      text("Charles Sumner Wins!",width/2,height/2);
      textSize(15);
      text("Press the spacebar to play again", width/2, height/2+20);      
      break;
  }

}
