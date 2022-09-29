class Punto {

  float x, y, f, f1, r, espacioX, espacioY, xr, yr, random;

  float rAncho, rAlto, cRadio, rTran, cTran;

  boolean agarroPunto;

  Punto(float x_, float y_) {

    x = x_;

    y = y_;

    r = 0;

    f = 0;

    f1 = 0;

    //espacioX = x + f;

    //espacioY = y + f;

    rAncho = 10;

    xr = 0;

    yr = 0;

    rAlto = 10;

    cRadio = 15;

    random = 0;

    rTran = 255;

    cTran = 10;

    agarroPunto = false;
  }

  void dibujaPunto() {

    if (agarroPunto) {

      r += 1;

      rAlto += 2;

      rAncho += 2;

      cRadio += 4;

      rTran -= 12;

      cTran -= 1; 

      for (int i = 0; i < 10; i++) {

        push();

        noStroke();
        translate(x, y);

        fill(255, rTran*1.2);
        rotate(radians(r+i*150));
        rectMode(CENTER);
        rect(xr, yr, 10, 10);

        pop();

        xr+=0.2+i/8;
        yr-=0.2+i/8;
      }
    } else {

      cTran =f;

      cRadio +=f1;

      f = map(cRadio, 25, 40, 80, 0);

      if (cRadio <= 15) {

        f1 = 0.2;
      } else if (cRadio >= 45) {

        cRadio = 15;
      }
    }

    if (rTran >= 0) {

      r += 1;

      push();

      noStroke();
      translate(x, y);

      fill(0, 200, 255, cTran);
      circle(0, 0, cRadio);

      fill(255, rTran);
      rotate(radians(r));
      rectMode(CENTER);
      rect(0, 0, rAlto, rAncho);


      pop();
    }
  }

  void recojePunto() {

    if (agarroPunto == false) {

      if (dist(x, y, bx, by) < 20) { 

        playlist[1].play();

        puntuacion ++;

        largoTrazo += 20;

        tiempo = 0;

        playlist[1].rewind();

        agarroPunto = true;
      }
    }
  }
}
