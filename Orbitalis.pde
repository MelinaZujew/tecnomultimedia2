import fisica.*;

import ddf.minim.*;

Minim minim;

AudioPlayer[] playlist;

FWorld mundo;

FCircle planeta, planeta2, planeta3;

FCircle bala, bala2;

FBox obstaculo;

FCircle agujero1, agujero2;

Boton boton0, boton1, boton2;

Texto texto0, texto1, texto2, texto3;

Punto [] puntos;

PImage[] img = new PImage [12]; 

float px, py, px2, py2, px3, py3, bx, by, bx2, by2, gx, gy, gx2, gy2, gx3, gy3, g2x, g2y, f, f1, f2, f3, f4, distancia1, distancia2, distancia3, distancia4;

float ox, oy, gox, goy, distanciaObstaculo, fObstaculo;

float r, bs;

float agx1, agy1, agx2, agy2;

float barra = 0;

float b, puntoX, puntoY, puntoF;

int x = 0;

int cantPuntos, temp, vidas, tiempo, puntuacion;

int pantalla;

PImage fondo1;

PFont fuente1;

boolean disparo = false, marca = false, fuerza = false, apuntado = false, chocarse = false, perder = false;

void setup() {

  //probar cambiar a maximo 1280 x 720 (tamaño max de un proyector)
  size(1200, 700, P2D);

  vidas = 3;

  pantalla = 0;

  puntuacion = 0;

  fondo1 = loadImage("fondo1.jpg");

  fuente1 = createFont("tipografia.ttf", 100);

  playlist = new AudioPlayer[6];

  minim = new Minim(this);

  for ( int i=0; i<12; i++) {

    img[i]  = loadImage ("img_" + nf(i, 2) + ".png");
  }

  img[0].resize(40, 40);
  img[1].resize(50, 20);
  img[2].resize(80, 80);
  img[3].resize(110, 110);

  img[4].resize(80, 80);
  img[5].resize(80, 80);
  img[6].resize(50, 50);

  for ( int i=0; i<6; i++) {

    playlist[i] = minim.loadFile ("sonido_" + nf(i, 2) + ".mp3");
  }
  
  playlist[0].loop();

  cantPuntos = 6;

  bs = 0;

  r = 0;

  temp = 0;

  tiempo = 0;

  boton0 = new Boton("D E S P E G A R", width/2, height/2+100, 400, 100);

  boton1 = new Boton("R E I N I C I A R", width/2, height/2+100, 350, 100);

  boton2 = new Boton("C O N T I N U A R", width/2, height/2+100, 400, 100);

  texto0 = new Texto("O R B I T A L I S", width/2, height/4, 80, 255);

  texto1 = new Texto("E S T R E L L A D O", width/2, height/4, 80, color(255, 33, 124));

  texto2 = new Texto("M I S I O N", width/2, height/4, 80, color(255, 33, 124));

  texto3 = new Texto("C O M P L E T A", width/2, height/4+80, 80, color(255, 33, 124));

  puntos = new Punto[cantPuntos];

  puntoX = random(400, 1000);

  puntoY = random(150, 750);

  //puntoF = random(40, 100);

  for ( int i=0; i<puntos.length; i++) {

    if (i == 0) {
      puntos[i] = new Punto(width/2+100, height/3+80, random(50, 100));
    } else if (i == 1) {
      puntos[i] = new Punto(width/2+140, height/3+200, random(50, 100));
    } else if (i == 2) {
      puntos[i] = new Punto(width/2-20, height/3+260, random(50, 100));
    } else if (i == 3) {
      puntos[i] = new Punto(width/2-120, height/3+140, random(50, 100));
    } else if (i == 4) {
      puntos[i] = new Punto(width/2+400, height/2-160, random(50, 100));
    } else if (i == 5) {
      puntos[i] = new Punto(width/2+300, height/2-100, random(50, 100));
    }
  }

  Fisica.init(this);

  mundo = new FWorld();

  //mundo.setEdges(10);
  mundo.setGravity(0, 0);

  planeta = new FCircle(80);
  planeta.setPosition(width/2, height/2);
  planeta.setStatic(true);
  planeta.setFill(10, 10, 120);
  planeta.setNoStroke();
  planeta.setGrabbable(false);
  planeta.setName("planeta");
  planeta.attachImage(img[2]);

  planeta2 = new FCircle(50);
  planeta2.setPosition(width/3*3, height/3*2);
  planeta2.setStatic(true);
  planeta2.setFill(10, 120, 10);
  planeta2.setNoStroke();
  planeta2.setName("planeta2");
  planeta2.attachImage(img[6]);

  planeta3 = new FCircle(110);
  planeta3.setPosition(width/10, height/3*2);
  planeta3.setStatic(true);
  planeta3.setFill(120, 10, 10);
  planeta3.setNoStroke();
  planeta3.setName("planeta3");
  planeta3.attachImage(img[3]);

  bala = new FCircle(40);
  bala.setPosition(width/2, height/2-80);
  bala.setDamping(0);
  bala.setNoStroke();
  bala.setName("bala");
  bala.setRestitution(2);
  bala.setGrabbable(false);
  bala.attachImage(img[0]);

  bala2 = new FCircle(40);
  bala2.setPosition(width/2, height/2-80);
  bala2.setDamping(0);
  bala2.setSensor(true);
  bala2.setFill(255, 100);
  bala2.setNoStroke();
  bala2.setName("balaF");
  bala2.setStatic(true);
  bala2.setGrabbable(false);

  obstaculo = new FBox(50, 20);
  obstaculo.setPosition(width/2+60, height/2-250);
  obstaculo.setDamping(0);
  obstaculo.setDensity(1.5);
  obstaculo.setFill(200, 200, 255, 150);
  obstaculo.setStroke(200, 200, 255, 230);
  obstaculo.setStrokeWeight(2);
  obstaculo.setVelocity(200, 0);
  obstaculo.setName("satelite");
  obstaculo.setRestitution(1.5);
  obstaculo.setGrabbable(false);
  obstaculo.attachImage(img[1]);

  agujero1 = new FCircle(80);
  agujero1.setPosition(width/2-300, height/3-100);
  agujero1.setStatic(true);
  agujero1.setSensor(true);
  agujero1.setFill(0, 200, 255, 180);
  agujero1.setStroke(0, 200, 255, 235);
  agujero1.setStrokeWeight(12);
  agujero1.attachImage(img[4]);

  agujero2 = new FCircle(80);
  agujero2.setPosition(width/2-400, height/3-100);
  agujero2.setStatic(true);
  agujero2.setSensor(true);
  agujero2.setFill(0, 230, 180, 230);
  agujero2.setStroke(0, 230, 180, 140);
  agujero2.setStrokeWeight(16);
  agujero2.attachImage(img[5]);

  mundo.add(planeta);
  mundo.add(planeta2);
  mundo.add(planeta3);
  mundo.add(bala);
  mundo.add(bala2);
  mundo.add(obstaculo);
  mundo.add(agujero1);
  mundo.add(agujero2);

  textFont(fuente1);
}

void draw() {

  println(vidas + " .  " + tiempo);

  background(5);

  //pantalla de inicio
  if (pantalla == 0) {

    tint(255, 80);
    image(fondo1, 0, 0);

    boton0.dibujaBoton();
    texto0.dibujaTexto();

    if (boton0.colisionBoton(mouseX, mouseY) && mousePressed) {

      pantalla = 1;
    }

    //pantalla jugando
  } else if (pantalla == 1) {

    tint(180, 120);
    image(fondo1, 0, 0);

    //area de la orbita planeta y planeta2
    push();
    fill(255, 5);
    noStroke();
    circle(px, py, 600);
    circle(px2, py2, 300);
    circle(px3, py3, 500);
    pop();

    //dibuja los puntos
    for ( int i=0; i<puntos.length; i++) {
      puntos[i].dibujaPunto();
      puntos[i].recojePunto();
    }

    //comienza la simulacion de fisica
    mundo.step();

    //comienza el dibujo del mundo y sus elementos
    mundo.draw();

    //funciones
    reiniciar();
    apuntar();
    seDisparo();
    marcaTiro();
    atraccionGravitatoria();
    barraTiro();
    tiroVelocidad();
    agujeroGusano();
    seChoco();

    if (vidas == 0) {
      pantalla = 2;
    }

    if (puntuacion >= 4) {

      pantalla = 3;
    }

    //pantalla de perder
  } else if (pantalla == 2) {

    mundo.clear();

    tint(255, 80);
    image(fondo1, 0, 0);

    boton1.dibujaBoton();
    texto1.dibujaTexto();

    if (boton1.colisionBoton(mouseX, mouseY) && mousePressed) {
      
      playlist[0].pause();

      setup();
    }
  } else if (pantalla == 3) {

    mundo.clear();

    tint(255, 80);
    image(fondo1, 0, 0);

    boton2.dibujaBoton();
    texto2.dibujaTexto();
    texto3.dibujaTexto();

    if (boton2.colisionBoton(mouseX, mouseY) && mousePressed) {
      
      playlist[0].pause();

      setup();
    }
  }
}

void atraccionGravitatoria() {

  //se puede simplificar haciendo una especie de for o array (?) y hacer un getBodies de todo el mundo y hacer un solo calculo

  px = planeta.getX();
  py = planeta.getY();

  px2 = planeta2.getX();
  py2 = planeta2.getY();

  px3 = planeta3.getX();
  py3 = planeta3.getY();

  bx = bala.getX();
  by = bala.getY();

  bx2 = bala2.getX();
  by2 = bala2.getY();

  ox = obstaculo.getX();

  oy = obstaculo.getY();

  gx = px - bx;
  gy = py - by;

  g2x = px - bx2;
  g2y = py - by2;

  gx2 = px2 - bx;
  gy2 = py2 - by;

  gx3 = px3 - bx;
  gy3 = py3 - by;

  gox = px - ox;

  goy = py - oy;

  distancia1 = dist(bx, by, px, py);

  distancia2 = dist(bx, by, px2, py2);

  distancia3 = dist(bx, by, px3, py3);

  distancia4 = dist(bx2, by2, px, py);

  distanciaObstaculo = dist(ox, oy, px, py);

  f1 = map(distancia1, 300, 50, 8, 40);

  f2 = map(distancia2, 150, 30, 15, 30);

  f3 = map(distancia3, 300, 50, 10, 60);

  f4 = map(distancia4, 300, 50, 8, 40);

  fObstaculo = map(distanciaObstaculo, 300, 50, 2, 6);

  if (distancia1 < 300) {

    bala.addForce(gx * f1, gy * f1);
    bala2.addForce(g2x * f4, g2y * f4);
  }
  if (distancia2 < 150) {

    bala.addForce(gx2 * f2, gy2 * f2);
  }
  if (distancia3< 300) {

    bala.addForce(gx3 * f3, gy3 * f3);
  }

  if (distanciaObstaculo < 300) {

    r += 0.8;
    obstaculo.addForce(gox * fObstaculo, goy * fObstaculo);

    //float pAngle;

    // pAngle = atan2(py-oy, px-ox);

    obstaculo.setRotation(radians(r));

    //obstaculo.setAngularVelocity(100);
  }
}

void agujeroGusano() {

  agx1 = agujero1.getX();
  agy1 = agujero1.getY();

  agx2 = agujero2.getX();
  agy2 = agujero2.getY();

  float distanciaA = dist(bx, by, agx1, agy1);

  float distanciaB = dist(bx, by, agx2, agy2);

  if (disparo == true) {
    if (distanciaA < 75) {
      
      playlist[4].play();

      bala.setPosition(agx2, agy2);
      playlist[4].rewind();
    }
  }
}


void contactStarted(FContact contacto) {

  FBody cuerpo1 = contacto.getBody1();

  FBody cuerpo2 = contacto.getBody2();

  if (cuerpo1 != null && cuerpo2 != null && cuerpo2.getName() != "balaF") {

    if (cuerpo1.getName() == "planeta" || cuerpo1.getName() == "planeta2" || cuerpo1.getName() == "planeta3" && cuerpo2.getName() == "bala") {
      
      playlist[2].play();

      chocarse = true;
      
      playlist[2].rewind();
      
    }else if (cuerpo1.getName() == "satelite" && cuerpo2.getName() == "bala") {

      playlist[3].play();

      println(cuerpo1.getName());
      println(cuerpo2.getName());
      
      playlist[3].rewind();
    }
  }
}

void seChoco() {

  if (chocarse == true) {

    bs +=0.3;

    //bala.setSize(bala.getSize()+bs);

    bala.setStatic(true);
    bala.setSensor(true);
 
    bala.setImageAlpha(0.1);

    if (bs >= 20) {

      perder = true;
    }
  }

  if (tiempo >= 400) {

    chocarse = true;
  }

  if (bx > width+40) {

    bala.setPosition(0-40, bala.getY());
  } else if (bx < 0-41) {

    bala.setPosition(width+39, bala.getY());
  }

  if (by > height+40) {

    bala.setPosition(bala.getX(), 0-40);
  } else if (by < 0-41) {

    bala.setPosition(bala.getX(), height+39);
  }
}


void barraTiro() {

  float fuerza = constrain(map(mouseY, 500, 300, 0, -200), -200, 0);

  if (keyPressed) {

    barra = fuerza;
  } else if (barra < 0) {

    barra += 10;
  } else {

    barra = 0;
  }

  push();
  noStroke();
  fill(200, 100, 100);
  rect(100, 500, 20, barra);

  noFill();
  strokeWeight(2);
  stroke(255);
  rect(100, 300, 20, 200);
  pop();
}

void apuntar() {

  float mI = constrain(map(mouseY, 500, 300, width/2, 2500), width/2, 2500);

  if (keyPressed ) {

    if (key != 'r') {

      bala2.setStatic(false);

      bala2.resetForces();

      if (apuntado == false) {

        bala2.addImpulse(mI, 0);

        apuntado = true;
      }

      if (temp < 60) {

        temp++;
      } else if (temp >= 60) {

        mundo.remove(bala2);

        mundo.add(bala2);

        temp = 0;

        apuntado = false;
      }
    }
  } else if (disparo == true) {

    temp = 0;

    mundo.remove(bala2);

    tiempo +=1;
  }
}


void keyReleased() {

  if (key != 'r') {
    disparo = true;
    fuerza = true;
    marca = true;
    
    playlist[5].play();
    
    playlist[5].rewind();

    bala.resetForces();

    b = constrain(map(mouseY, 500, 300, 0, -200), -200, 0);
  }
}

void tiroVelocidad() {

  float mI = constrain(map(mouseY, 500, 300, width/2, 2500), width/2, 2500);

  if (disparo == true && fuerza == true) {

    bala.addImpulse(mI, 0);

    fuerza = false;
  }
}

void seDisparo() {

  if (disparo == true) {

    bala.setStatic(false);
  } else {

    bala.setStatic(true);
  }
}

void marcaTiro() {

  //b = constrain(map(mouseY, 500, 300, 0, -200), -200, 0);

  if (marca == true) {

    push();
    stroke(200, 20, 20);
    strokeWeight(2);
    line(130, 500 + b, 150, 500 + b);
    pop();
  }
}


void pasarPantallas() {

  if (key == 'f') {

    pushStyle();
    fill(0, 255, 0);
    textSize(20);
    text(pantalla, 50, 50);
    popStyle();
  }

  if (key == 'e') {

    pantalla ++;
  } else if (key == 'q') {

    pantalla --;
  }
}

void keyPressed() {

  pasarPantallas();
}


void reiniciar() {

  if (keyPressed) {
    if (key == 'r') {

      vidas = 0;
    }
  }

  if (perder == true) {

    vidas --;

    barra = 0;

    puntuacion = 0;

    x = 0;

    bs = 0;

    r = 0;

    temp = 0;

    tiempo = 0;

    disparo = false;
    fuerza = false;
    apuntado = false;
    chocarse = false;
    perder = false;

    cantPuntos = 6;

    puntos = new Punto[cantPuntos];

    puntoX = random(400, 1000);

    puntoY = random(150, 750);

    //puntoF = random(40, 100);

    for ( int i=0; i<puntos.length; i++) {

      if (i == 0) {
        puntos[i] = new Punto(width/2+100, height/3+80, random(50, 100));
      } else if (i == 1) {
        puntos[i] = new Punto(width/2+140, height/3+200, random(50, 100));
      } else if (i == 2) {
        puntos[i] = new Punto(width/2-20, height/3+260, random(50, 100));
      } else if (i == 3) {
        puntos[i] = new Punto(width/2-120, height/3+140, random(50, 100));
      } else if (i == 4) {
        puntos[i] = new Punto(width/2+400, height/2-160, random(50, 100));
      } else if (i == 5) {
        puntos[i] = new Punto(width/2+300, height/2-100, random(50, 100));
      }
    }

    Fisica.init(this);

    mundo = new FWorld();

    //mundo.setEdges(10);
    mundo.setGravity(0, 0);

    planeta = new FCircle(80);
    planeta.setPosition(width/2, height/2);
    planeta.setStatic(true);
    planeta.setFill(10, 10, 120);
    planeta.setNoStroke();
    planeta.setGrabbable(false);
    planeta.setName("planeta");
    planeta.attachImage(img[2]);

    planeta2 = new FCircle(50);
    planeta2.setPosition(width/3*3, height/3*2);
    planeta2.setStatic(true);
    planeta2.setFill(10, 120, 10);
    planeta2.setNoStroke();
    planeta2.setName("planeta2");

    planeta3 = new FCircle(110);
    planeta3.setPosition(width/10, height/3*2);
    planeta3.setStatic(true);
    planeta3.setFill(120, 10, 10);
    planeta3.setNoStroke();
    planeta3.setName("planeta3");
    planeta3.attachImage(img[3]);

    bala = new FCircle(40);
    bala.setPosition(width/2, height/2-80);
    bala.setDamping(0);
    bala.setNoStroke();
    bala.setName("bala");
    bala.setRestitution(2);
    bala.setGrabbable(false);
    bala.attachImage(img[0]);

    bala2 = new FCircle(40);
    bala2.setPosition(width/2, height/2-80);
    bala2.setDamping(0);
    bala2.setSensor(true);
    bala2.setFill(255, 100);
    bala2.setNoStroke();
    bala2.setName("balaF");
    bala2.setStatic(true);
    bala2.setGrabbable(false);

    obstaculo = new FBox(50, 20);
    obstaculo.setPosition(width/2+50, height/2-250);
    obstaculo.setDamping(0);
    obstaculo.setDensity(1.5);
    obstaculo.setFill(200, 200, 255, 150);
    obstaculo.setStroke(200, 200, 255, 230);
    obstaculo.setStrokeWeight(2);
    obstaculo.setVelocity(200, 0);
    obstaculo.setName("satelite");
    obstaculo.setRestitution(1.5);
    obstaculo.setGrabbable(false);
    obstaculo.attachImage(img[1]);

    agujero1 = new FCircle(80);
    agujero1.setPosition(width/2-300, height/3-100);
    agujero1.setStatic(true);
    agujero1.setSensor(true);
    agujero1.setFill(0, 200, 255, 180);
    agujero1.setStroke(0, 200, 255, 235);
    agujero1.setStrokeWeight(12);
    agujero1.attachImage(img[4]);

    agujero2 = new FCircle(80);
    agujero2.setPosition(width/2-400, height/3-100);
    agujero2.setStatic(true);
    agujero2.setSensor(true);
    agujero2.setFill(0, 230, 180, 230);
    agujero2.setStroke(0, 230, 180, 140);
    agujero2.setStrokeWeight(16);
    agujero2.attachImage(img[5]);

    /*
      for (int i = 0; i < 3; i++) {
     
     obstaculo = new FBox(50, 20);
     obstaculo.setPosition(width/2+50*i, height/2-250);
     obstaculo.setDamping(0);
     obstaculo.setDensity(1.5);
     obstaculo.setFill(200, 200, 255, 150);
     obstaculo.setStroke(200, 200, 255, 230);
     obstaculo.setStrokeWeight(2);
     obstaculo.setVelocity(200, 0);
     obstaculo.setName("satelite");
     obstaculo.setRestitution(0.6);
     
     mundo.add(obstaculo);
     }
     */
    mundo.add(planeta);
    mundo.add(planeta2);
    mundo.add(planeta3);
    mundo.add(bala);
    mundo.add(bala2);
    mundo.add(obstaculo);
    mundo.add(agujero1);
    mundo.add(agujero2);
  }
}
