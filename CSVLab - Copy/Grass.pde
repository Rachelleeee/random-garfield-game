public class Grass extends AnimatedSprite{
 public Grass(PImage img, float scale){
   super(img,scale);
   standNeutral = new PImage[4];
   standNeutral[0] = loadImage("darkgrass.png");
   standNeutral[1] = loadImage("darkgrass2.png");
   standNeutral[2] = loadImage("darkgrass3.png");
   standNeutral[3] = loadImage("darkgrass2.png");
   currentImages = standNeutral;
   
 }
}
