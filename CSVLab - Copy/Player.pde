public class Player extends AnimatedSprite{
  boolean inPlace;
  PImage[] standLeft;
  PImage[] standRight;
 // PImage[] OUCH;
  //PImage[] neutral;
  public Player(PImage img, float scale){
    super(img, scale);
    direction = NEUTRAL_FACING; //RIGHT_FACING;
    inPlace = true;
  //  OUCH = new PImage[1];
   // OUCH[0] = loadImage("garf_hurt.png");
    standLeft = new PImage[1];
    standLeft[0] = loadImage("garf_standleft.png");
    standRight = new PImage[1];
    standRight[0] = loadImage("garf_standright.png");
    moveLeft = new PImage[2];
    moveLeft[0] = loadImage("garf_walkleft1.png");
    moveLeft[1] = loadImage("garf_walkleft2.png");
    moveRight = new PImage[2];
    moveRight[0] = loadImage("garf_walkright1.png");
    moveRight[1] = loadImage("garf_walkright2.png"); 
   /* neutral = new PImage[1];
    neutral[0] = loadImage("player_stand_right.png");*/
    currentImages = standRight;
  }
  @Override
  public void updateAnimation(){
    // TODO:
    // update inPlace variable: player is inPlace if it is not moving
    // in both direction.
    // call updateAnimation of parent class AnimatedSprite.
    selectDirection();
    if(direction != RIGHT_FACING && direction != LEFT_FACING)
    {
        inPlace = true;
        //print("true");
    }
    else
     {   inPlace = false;
        //print("false");
  
     }
    super.updateAnimation();    

  }
  @Override
  public void selectDirection(){
   // print("Select");
    if(change_x > 0){
    //print("right");
      direction = RIGHT_FACING;}
    else if(change_x < 0)
      direction = LEFT_FACING; 
   else if(change_x == 0)
   {
      //print("Neutral");
      direction = NEUTRAL_FACING;
   }
  }
  @Override
  public void selectCurrentImages(){
   // if(checkCollisionListo(p, endtouch).size() <= 0){
    if(direction == NEUTRAL_FACING)
    {
     currentImages = standRight;
    } 
    else  if(direction == RIGHT_FACING){
     
        currentImages = moveRight;
    }
    else if(direction == LEFT_FACING)
    {
        currentImages = moveLeft;
    }
   // }
   // else{
   //   print("potato");
   //   currentImages = OUCH;
   // }
    
 
}

}
