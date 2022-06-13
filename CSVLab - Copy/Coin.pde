public class Coin extends AnimatedSprite{
 public Coin(PImage img, float scale){
   super(img,scale);
   standNeutral = new PImage[4];
   if(lvlNum ==0){
     standNeutral[0] = loadImage("flour1.png");
   standNeutral[1] = loadImage("flour2.png");
   standNeutral[2] = loadImage("flour3.png");
   standNeutral[3] = loadImage("flour2.png");
   }
   else if(lvlNum ==1){
    standNeutral[0] = loadImage("sugar1.png");
   standNeutral[1] = loadImage("sugar2.png");
   standNeutral[2] = loadImage("sugar3.png");
   standNeutral[3] = loadImage("sugar4.png");
   }
   else if(lvlNum ==2){
    standNeutral[0] = loadImage("egg1.png");
   standNeutral[1] = loadImage("egg2.png");
   standNeutral[2] = loadImage("egg3.png");
   standNeutral[3] = loadImage("egg2.png");
   }
   else /*if(lvlNum ==1)*/{
    standNeutral[0] = loadImage("bread1.png");
   standNeutral[1] = loadImage("bread2.png");
   standNeutral[2] = loadImage("bread3.png");
   standNeutral[3] = loadImage("bread4.png");
   }
   
   
   
   
   currentImages = standNeutral;
   
 }
}
