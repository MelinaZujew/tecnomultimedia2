class Boton {

  float x, y, ancho, alto, op, c, tf;
  String texto;
  

  Boton(String texto_, float x_, float y_, float ancho_, float alto_) {

    x = x_;
    y = y_;

    ancho = ancho_;
    alto = alto_;

    op = 180;

    c = 0;
    
    tf = 40;

    texto = texto_;
  }

  void dibujaBoton() {

    pushStyle();
    pushMatrix();

    translate(x, y); 

    rectMode(CENTER);
    stroke(254, 94, 120, 140);
    strokeWeight(10);
    fill(254, 33, 124, op);
    rect(0, 0, ancho, alto, 30);

    fill(255);

    textAlign(CENTER, CENTER);
    textSize(tf);
    text(texto, 0, 0-5);

    popMatrix();
    popStyle();
  }

  boolean colisionBoton(float x_, float y_) {

    if (
      x - ancho/2 < x_+23
      && x + ancho/2 > x_-23
      && y - alto/2 < y_+30
      && y + alto/2 > y_-30
      ) {  
      c = 255;

      if (op <= 0) {

        op = 0;
      } else {

        tf +=0.7;
        op -=20;
        
        ancho +=1;
        alto +=1;
      }
    } else {

      if (op < 255) {
        op +=20;
        tf -=0.7;
        
        ancho -=1;
        alto -=1;
      } else if (op >=255) {

        op = 255;
      }
    }
    if (op <= 0) {
      return true;
    } else {
      return false;
    }
  }
}
