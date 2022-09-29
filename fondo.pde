class Fondo {
  //propiedades:
  PImage imgFondo;
  float x;
  float velX, transparencia;

  //constructor:
  Fondo() {
    
    imgFondo = loadImage("fondo1.jpg");
    x = 0;
    velX = 0;
  }

  //funcionalidades:
  void dibujaFondo(float transparencia_) {
    
    transparencia = transparencia_;

    //dibujo:
    push();
    tint(255, transparencia);
    image(imgFondo, x, 0, width, height);
    pop();
    
    push();
    scale(-1,1);
    tint(255, transparencia);
    image(imgFondo, -width*2 - x, 0, width, height);
    pop();

    //ademas cambio el valor de x:
    x+=velX; 
    
    velX = map(historial.size(), 0, 80, -0.2, -1.4);

    if (x<-width) {
      x = 0;
    }
  }
  
  void dibujaFondoR() {
    
    transparencia = map(historial.size(), 0, 80, 70, 200);

    //dibujo:
    push();
    tint(255, transparencia);
    image(imgFondo, x, 0, width, height);
    pop();
    
    push();
    scale(-1,1);
    tint(255, transparencia);
    image(imgFondo, -width*2 - x, 0, width, height);
    pop();

    //ademas cambio el valor de x:
    x+=velX; 
    
    velX = map(historial.size(), 0, 80, -0.2, -1.4);

    if (x<-width) {
      x = 0;
    }
  }
}
