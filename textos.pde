class Texto {

  float x, y, s;

  color c;

  String t;

  Texto(String t_, float x_, float y_, float s_, int c_) {

    t = t_;

    x = x_;

    y = y_;

    s = s_;

    c = c_;
  }

  void dibujaTexto() {

    pushMatrix();
    pushStyle();

    translate(x, y);

    fill(c);
    textAlign(CENTER, CENTER);
    textSize(s);
    text(t, 0, 0);

    popStyle();
    popMatrix();
  }
}
