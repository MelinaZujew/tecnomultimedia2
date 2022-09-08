class Punto {

  float x, y, f, espacioX, espacioY;

  float rAncho, rAlto, cRadio, rTran, cTran;

  boolean agarroPunto;

  Punto(float x_, float y_, float f_) {

    x = x_;

    y = y_;

    f = f_;

    //espacioX = x + f;

    //espacioY = y + f;

    rAncho = 10;

    rAlto = 10;

    cRadio = 25;

    rTran = 255;

    cTran = 80;

    agarroPunto = false;
  }

  void dibujaPunto() {

    if (agarroPunto) {

      rAlto += 2;

      rAncho += 2;

      cRadio += 4;

      rTran -= 12;

      cTran -= 1;
    } 

    if (rTran >= 0) {
      push();

      noStroke();
      fill(255, rTran);
      translate(x, y);
      rotate(1.0);
      rectMode(CENTER);
      rect(0, 0, rAlto, rAncho);

      fill(0, 200, 255, cTran);
      circle(0, 0, cRadio);

      pop();
    }
  }

  void recojePunto() {

    if (agarroPunto == false) {
      
      if (dist(x, y, bx, by) < 20) {
        
        playlist[1].play();

        agarroPunto = true;
        
        puntuacion ++;
        
        tiempo = 0;
        
        playlist[1].rewind();
      }
    }

  }
}
