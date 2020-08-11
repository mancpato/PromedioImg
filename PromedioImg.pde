/* Promedio de imágenes para quitar ruido Sal y Pimienta */

PImage imgSP,img;
PImage PromImg;

void setup() { 
  size(600, 256);
//  frameCount=0;
  img = loadImage("Irma.bmp");
  imgSP = loadImage("Irma.bmp");
  PromImg = loadImage("Irma.bmp");
  fill(0);
  textSize(20);
}

void draw() 
{
  int r,SP,p;
  float v,vo;
  
  background(150);
  img.loadPixels();      // Imagen original //<>//
  imgSP.loadPixels();    // Imagen con ruido
  PromImg.loadPixels();  // Imagen promedio
  
  // Poniendo ruido sal y pimienta en imgSP
  for (int y = 0; y < img.height; y++) { 
    for (int x = 0; x < img.width; x++) {
      p = y*img.width + x;
      imgSP.pixels[p] = img.pixels[p];
      r = int(random(20));
      if ( r<8) {
        SP = r%2==0 ? 0:255;
        imgSP.pixels[p] = color(SP, SP, SP);
      }
    }
  }
  
  // Solo la primera imagen con ruido se copia a PromImg
  if ( frameCount==1 ) { //<>//
    for (int y = 0; y < img.height; y++)
      for (int x = 0; x < img.width; x++) {
        p = y*img.width + x;
        PromImg.pixels[p] = imgSP.pixels[p];
      }
    PromImg.updatePixels();
    image(PromImg, 256, 0);
  }
  
  imgSP.updatePixels(); //<>//
  image(imgSP, 0, 0);
  
  // Se calcula la imagen promedio, a partir del promedio anterior
  for (int y = 0; y < img.height; y++) { 
    for (int x = 0; x < img.width; x++) {
      p = y*img.width + x;
      v = red(PromImg.pixels[p]);
      vo = red(imgSP.pixels[p]);
      v = (frameCount*v+vo)/(frameCount+1)+.7;
      v = constrain(v, 0, 255);
      PromImg.pixels[y*img.width + x] = color(v, v, v);
    }
  }
  PromImg.updatePixels();
  image(PromImg, 256, 0);
  text(str(frameCount),550,50);
  noLoop();
}

void mouseClicked()
{
  loop();
}
