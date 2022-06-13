
import processing.sound.*;
SoundFile song;
SoundFile collect;
SoundFile intro;
SoundFile ending;
SoundFile restart;


final static float MOVE_SPEED = 5;
final static float COIN_SCALE = 0.4;
final static float SPRITE_SCALE = 50.0/128;
final static float SPRITE_SIZE = 50;

final static float GRAVITY = .6;
final static float JUMP_SPEED = 11; 

//animation
final static int NEUTRAL_FACING = 0;
final static int RIGHT_FACING = 1;
final static int LEFT_FACING = 2;



//margins
final static float RIGHT_MARGIN = 400;
final static float LEFT_MARGIN = 200;
final static float VERTICAL_MARGIN = 200;
//final static float BOTTOM_MARGIN = 100;

//declare global variables
//Sprite p;
ArrayList<Sprite> coins; 
ArrayList<Sprite> endtouch;
PImage snow, crate, red_brick, brown_brick, coin, deathgrass;
PImage playerImage;
Player p;

//global bounds
ArrayList<Sprite> platforms;
//ArrayList<Sprite> actualPlatforms;

float left_bd, right_bd; 
float top_bd, bottom_bd;

float view_x=0;
float view_y=0;
int score;
int total;
boolean lvlTransition = false;
float lvlNum = 0;
//boolean restart = false;
String ingred;

int mode = 0;
PImage bg;

//initialize them in setup().
void setup(){
  if(mode ==0){
  song = new SoundFile(this, "fireflies.wav");
  collect = new SoundFile(this, "coin.wav");
  intro = new SoundFile(this, "colada.wav");
  ending = new SoundFile(this, "bonk.wav");
  restart = new SoundFile(this, "wasted.wav");
  collect.amp(0.5);
  restart.amp(1);
  }
  size(800, 600);
   
  imageMode(CENTER);
  playerImage = loadImage("garf_standright.png");
  p = new Player(playerImage, 0.8);
  p.center_x=width/2;
  p.center_y= height/2;
  coins = new ArrayList<Sprite>();
  endtouch = new ArrayList<Sprite>();
  score = 0;
  total=0; //to change total make sure to add coins in the map!
  
  p.center_x = 100;
  p.center_y = 100;
  platforms = new ArrayList<Sprite>();
  
  view_x = 0;
  view_y = 0;
  
  red_brick = loadImage("rock.png");
  brown_brick = loadImage("metal.PNG");
  crate = loadImage("crate.png");
  snow = loadImage("red_brick.png");
  coin = loadImage("bread1.png");
  deathgrass = loadImage("darkgrass.png");
  //createPlatforms("map.csv");

 if(lvlNum == 0){
   ingred = "Flour:";
   if(intro.isPlaying()|| song.isPlaying()){
     createPlatforms("map.csv");
   }
   else{
     //intro.play();
     if(mode==1){
       song.play();
       song.amp(0.2);
       createPlatforms("map.csv");
     }
     else{
        createPlatforms("map.csv"); 
     }
   }
  }
  else if(lvlNum ==1)
  {
    ingred ="Sugar:";
   // intro.stop();
    //song.play();
    
    if(intro.isPlaying()|| song.isPlaying()){
     createPlatforms("lvl2.csv");
   }
   else{
     //intro.play();
     if(mode==1){
     song.play();
     song.amp(0.2);
     createPlatforms("lvl2.csv");}
     else{
        createPlatforms("lvl2.csv");
     }
   }
  }
  else if(lvlNum ==2)
  {
   // intro.stop();
    //song.play();
   ingred = "Eggs:"; 
    if(intro.isPlaying()|| song.isPlaying()){
     createPlatforms("lvl3.csv");
   }
   else{
     //intro.play();
     if(mode==1){
     song.play();
     song.amp(0.2);
     createPlatforms("lvl3.csv");
     }
     else{
       createPlatforms("lvl3.csv");
     }
   }
  }
  else if (lvlNum == 3)
  {
    song.pause();
    intro.play();
    intro.amp(0.3);
    mode = 3;
  }
}


// modify and update them in draw().
void draw(){
  if(mode ==0){ //start screen
    background(222, 222, 0);
    fill(0, 0, 222);
    textAlign(CENTER, CENTER);
    textFont(createFont("Georgia", 32));
    textSize(36);
    text("Welcome to...", width/2-150, height/2-100);
    textFont(createFont("Cabold Comic.otf", 32));
    textSize(98);
    text("Big Bread", (width/2), height/2);
    textSize(28);
    textFont(createFont("Georgia", 32));
    text("click to start", (width/2), height/2+100);
  }
  if(mode ==2){ //restart screen
    
    background(139, 0, 0);
    fill(250, 235, 215);
    textSize(104);
    textAlign(CENTER, CENTER);
    
    text("YOU FAILED", (width/2), height/2-30);
    fill(220, 25, 65);
    textSize(56);
    textAlign(CENTER, CENTER);
    text("click to restart", (width/2), (height/2)+150);
    
  }
  if (mode ==3){
    //ending.play();
    bg = loadImage("bakery.png");
    background(bg);
    fill(250, 235, 215);
    textSize(86);
    textAlign(CENTER, CENTER);
    textFont(createFont("Cabold Comic.otf", 32));
    text("YOU WON", (width/2), height/2-155);
    fill(220, 25, 65);
    textSize(23);
    textAlign(CENTER, CENTER);
    textFont(createFont("Georgia", 32));
    text("Now Gorfeld can start his baking business!", (width/2), (height/2));
    text("click to restart", (width/2), (height/2)+150);   
  }
  if(mousePressed == true)
  {
     ending.play();
    ending.amp(0.6);
    
    mode = 1;
    if(lvlNum==3){
       lvlNum=0;
       lvlTransition = false;
       intro.stop();
    }
    setup();
  }
  if(mode==1){
  //song.loop();
  bg = loadImage("warehouse.png");
  background(bg);
  scroll();
  p.display();
  resolvePlatformCollisions(p, platforms);
  
  // call display, update and updateAnimation on player.
  //im not sure if this is right
    for(Sprite s: platforms)
    s.display(); 
    
    p.update();
    p.updateAnimation();//((AnimatedSprite)p)
  
  
  
  
    
  for(Sprite c: coins){
    c.display();
    ((AnimatedSprite)c).updateAnimation();
  }
  for(Sprite d: endtouch){
    d.display();
     ((AnimatedSprite)d).updateAnimation();
  }
   ArrayList<Sprite> collisionded = checkCollisionListo(p, endtouch);
  if(collisionded.size() > 0){
    mode = 2;
    restart.play();
    intro.pause();
    song.pause();
    setup();
  }
  
  
   ArrayList<Sprite> collision_list = checkCollisionListo(p, coins);
   if(total == 0)
   total = coins.size();
   if(collision_list.size() > 0){
    for(int i=0; i<coins.size(); i++){
      if(checkCollision(collision_list.get(0), coins.get(i))) 
      {
          coins.remove(i);
          
          collect.play();
         
          score++;
          //break;
      }
    }
   }
  textSize(32);
  fill(255, 0, 0);
  text(ingred + score + "/"+ total, view_x+100, view_y+50);
  if(score == total)
  {
    if(lvlNum == 3)
  {
  textSize(48);
  fill(0, 255, 0);
  textFont(createFont("Cabold Comic.otf", 32));
  text("You got them all!", view_x+400, view_y+300);
  textFont(createFont("Georgia", 32));}
  lvlNum++;
  }
  if(lvlNum ==0)
  {
    if( score == 0){
      textSize(36);
      fill(255, 240, 250);
      textFont(createFont("Cabold Comic.otf", 32));
      text("use arrow keys to move", 360, 650);
      textFont(createFont("Georgia", 32));
    }
    if( score == 3){
      textSize(36);
      fill(255, 240, 250);
      textFont(createFont("Cabold Comic.otf", 32));
      text("collect ingredients for Gorfeld's new bakery", 440, 250);
      textFont(createFont("Georgia", 32));
    }
    
  }
  if(lvlNum != 0){ 
      if(lvlNum ==1){
      if(lvlTransition == false){
          setup();
          //intro.pause();
          //song.pause();
      }
      lvlTransition = true;  
    }
    else if(lvlNum == 2){
      if(lvlTransition == true){
          setup();
          //intro.pause();
          //song.pause();
      }
      lvlTransition = false; 
      
    }
  }
    
    if(lvlNum == 3){
    setup();
    }
} 

}







//this



public ArrayList<Sprite> checkCollisionListo(Sprite s, ArrayList<Sprite> list){
  // fill in code here
  // see: https://youtu.be/RMmo3SktDJo
  ArrayList<Sprite> collision_list = new ArrayList<Sprite>();
  for(Sprite p: list){
   if(checkCollision(s, p))
     collision_list.add(p);
  }
  return collision_list;
}


void scroll(){
  float right_bound = view_x + width - RIGHT_MARGIN;
  if(p.getRight() > right_bound){
    view_x += p.getRight() - right_bound;
  }
  
  float left_bound = view_x + LEFT_MARGIN;
  if(p.getLeft() < left_bound){
    view_x -= left_bound - p.getLeft();
  }
  
  float bottom_bound = view_y +height - VERTICAL_MARGIN;
  if(p.getBottom() > bottom_bound){
    view_y += p.getBottom() - bottom_bound;
  }
  
  float top_bound = view_y + VERTICAL_MARGIN;
  if(p.getTop() < top_bound){
   view_y -= top_bound - p.getTop(); 
  }
  translate(-view_x, -view_y);
  
}


public boolean isOnPlatforms(Sprite p, ArrayList<Sprite> walls){
  p.center_y += 5;
  ArrayList<Sprite> collision_list = checkCollisionList(p, walls);
  // move back up 5 pixels to restore sprite to original position.
  p.center_y -= 5;
  return collision_list.size() > 0; 
}

public void resolvePlatformCollisions(Sprite p, ArrayList<Sprite> walls){
  // add gravity to change_y of sprite
  p.change_y += GRAVITY;
  
  // move in y-direction by adding change_y to center_y to update y position.
  p.center_y += p.change_y;

ArrayList<Sprite> col_list = checkCollisionList(p, walls);

if(col_list.size() > 0){
    Sprite collided = col_list.get(0);
    if(p.change_y > 0){
      p.setBottom(collided.getTop());
    }
    else if(p.change_y < 0){
      p.setTop(collided.getBottom());
    }
    p.change_y = 0;
  }

p.center_x += p.change_x;

col_list = checkCollisionList(p, walls);

 if(col_list.size() > 0){
    Sprite collided = col_list.get(0);
    if(p.change_x > 0){ //and here
        p.setRight(collided.getLeft());
    }
    else if(p.change_x < 0){//changed stuff
        p.setLeft(collided.getRight());
    }
  }
}



public boolean checkCollision(Sprite s1, Sprite s2){
  boolean noXOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
  boolean noYOverlap = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
  if(noXOverlap || noYOverlap){
    return false;
  }
  else{
    return true;
  }
}




public ArrayList<Sprite> checkCollisionList(Sprite s, ArrayList<Sprite> list){
  ArrayList<Sprite> collision_list = new ArrayList<Sprite>();
  for(Sprite p: list){
    if(checkCollision(s, p))
      collision_list.add(p);
  }
  return collision_list;
}


void createPlatforms(String filename){
  //print("Made it");
  String[] lines = loadStrings(filename);
  for(int row = 0; row < lines.length; row++){
    String[] values = split(lines[row], ",");
    for(int col = 0; col < values.length; col++){
      if(values[col].equals("1")){
        Sprite s = new Sprite(red_brick, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("2")){
        Sprite s = new Sprite(snow, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("3")){
        Sprite s = new Sprite(brown_brick, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("4")){
        Sprite s = new Sprite(crate, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("5")){
        Coin c = new Coin(coin, SPRITE_SCALE);
        c.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        c.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        coins.add(c);
      }
      else if(values[col].equals("6")){
        Grass d = new Grass(deathgrass, SPRITE_SCALE);
        d.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        d.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        endtouch.add(d);
      }
    }
  }
  
  
}

// called whenever a key is pressed.
void keyPressed(){
  if(keyCode == RIGHT){
    p.change_x = MOVE_SPEED;
  }
  else if(keyCode == LEFT){
    p.change_x = -MOVE_SPEED;
  }
  else if(keyCode == UP && isOnPlatforms(p, platforms)){
        p.change_y = -JUMP_SPEED;
  }
}

// called whenever a key is released.
void keyReleased(){
  if(keyCode == RIGHT){
    p.change_x = 0;
  }
  else if(keyCode == LEFT){
    p.change_x = 0;
  }
}
