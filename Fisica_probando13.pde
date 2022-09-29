import fisica.*;

import ddf.minim.*;

Minim minim;

AudioPlayer[] playlist;

FWorld mundo;

FCircle planeta, planeta2, planeta3;

FCircle bala, bala2;

Fondo fondo;

FBox obstaculo, obstaculo2;

FCircle agujero1, agujero2;

Boton boton0, boton1, boton2;

Texto texto0, texto1, texto2, texto3, texto4, texto5;

Punto [] puntos;

int frame1, frame2;

ArrayList <PVector> historial;

PImage[] img = new PImage [11]; 

PImage[] explosion = new PImage[4];

PImage[] agj1 = new PImage[3];

PImage[] agj2 = new PImage[3];

float px, py, px2, py2, px3, py3, bx, by, bx2, by2, gx, gy, gx2, gy2, gx3, gy3, g2x, g2y, f, f1, f2, f3, f4, distancia1, distancia2, distancia3, distancia4;

float ox, oy, gox, goy, distanciaObstaculo, fObstaculo;

float r, r2, bs, agujeroR, planetaR, orbitaT, orbitaF;

float agx1, agy1, agx2, agy2;

float ta, tb, tc;

float barra = 0;

float b, puntoX, puntoY, puntoF;

float vol;

int x = 0;

int expFrame, agjFrame;

int cantPuntos, temp, vidas, choques, tiempo, tiempoExp, puntuacion, largoTrazo;

int pantalla;

PFont fuente1;

boolean disparo = false, marca = false, fuerza = false, apuntado = false, chocarse = false, perder = false;

void setup() {

  //probar cambiar a maximo 1280 x 720 (tamaño max de un proyector)
  size(1280, 720, P2D);

  historial = new ArrayList<PVector>();

  largoTrazo = 40;

  frame1 = 0;

  frame2 = 0;

  choques = 3;

  tiempoExp = 0;

  expFrame = 0;

  agjFrame = 0;

  vidas = 3;

  agujeroR = 0;

  pantalla = 0;

  puntuacion = 0;

  fuente1 = createFont("tipografia.ttf", 100);

  playlist = new AudioPlayer[7];

  fondo = new Fondo();

  minim = new Minim(this);

  for ( int i=0; i<11; i++) {

    img[i]  = loadImage ("img_" + nf(i, 2) + ".png");
  }

  for ( int i=0; i<4; i++) {

    explosion[i]  = loadImage ("exp_" + nf(i, 2) + ".png");

    explosion[i].resize(400, 400);
  }

  for ( int i=0; i<3; i++) {

    agj1[i]  = loadImage ("agj1_" + nf(i, 2) + ".png");

    agj2[i]  = loadImage ("agj2_" + nf(i, 2) + ".png");

    agj1[i].resize(140, 140);

    agj2[i].resize(140, 140);
  }

  img[0].resize(40, 40);
  img[1].resize(50, 20);
  img[2].resize(80+79, 80+79);
  img[3].resize(110, 110);

  img[4].resize(80, 80);
  img[5].resize(80, 80);
  img[6].resize(50+80, 50+80);

  img[8].resize(40, 40);
  img[9].resize(40, 40);
  img[10].resize(260, 52);

  for ( int i=0; i<7; i++) {

    playlist[i] = minim.loadFile ("sonido_" + nf(i, 2) + ".mp3");
  }

  playlist[0].loop();

  playlist[0].setGain(0);
  playlist[1].setGain(0);

  cantPuntos = int(random(6, 11));

  bs = 0;

  r = 0;

  temp = 0;

  tiempo = 0;

  boton0 = new Boton("D E S P E G A R", width/2, height/2+100, 400, 100);

  boton1 = new Boton("R E I N I C I A R", width/2, height/2+100, 350, 100);

  boton2 = new Boton("V O L V E R", width/2, height/2+100, 400, 100);

  texto0 = new Texto("O R B I T A L I S", width/2, height/4, 80, 255);

  texto1 = new Texto("E S T R E L L A D O", width/2, height/4, 80, color(255, 33, 124));

  texto2 = new Texto("M I S I O N", width/2, height/4, 80, color(255, 33, 124));

  texto3 = new Texto("C O M P L E T A", width/2, height/4+80, 80, color(255, 33, 124));

  texto4 = new Texto("S I N", width/2, height/4, 80, color(255, 33, 124));

  texto5 = new Texto("T I E M P O", width/2, height/4+80, 80, color(255, 33, 124));

  puntos = new Punto[cantPuntos];

  puntoX = random(400, 1000);

  puntoY = random(150, 750);

  //puntoF = random(40, 100);

  for ( int i=0; i<puntos.length; i++) {

    if (i == 0) {
      puntos[i] = new Punto(width/2+100, height/3+80);
    } else if (i == 1) {
      puntos[i] = new Punto(width/2+140, height/3+200);
    } else if (i == 2) {
      puntos[i] = new Punto(width/2-20, height/3+260);
    } else if (i == 3) {
      puntos[i] = new Punto(width/2-120, height/3+140);
    } else if (i == 4) {
      puntos[i] = new Punto(width/2+420, height/2-160);
    } else if (i == 5) {
      puntos[i] = new Punto(width/2+320, height/2-80);
    } else if (i == 6) {
      puntos[i] = new Punto(width/2+220, height/2-160);
    } else if (i == 7) {
      puntos[i] = new Punto(width/2-460, height/2+240);
    } else if (i == 8) {
      puntos[i] = new Punto(width/2-280, height/2+120);
    } else if (i == 9) {
      puntos[i] = new Punto(width/2-410, height/2);
    } else if (i == 10) {
      puntos[i] = new Punto(width/2-400, height/2-180);
    } else if (i == 11) {
      puntos[i] = new Punto(width/2-420, height/2-200);
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
  planeta.setGroupIndex(-1);

  planeta2 = new FCircle(50);
  planeta2.setPosition(width/4*3, height/3-50);
  planeta2.setStatic(true);
  planeta2.setFill(10, 120, 10);
  planeta2.setNoStroke();
  planeta2.setName("planeta2");
  planeta2.attachImage(img[6]);
  planeta2.setGroupIndex(-1);

  planeta3 = new FCircle(110);
  planeta3.setPosition(width/6, height/3*2);
  planeta3.setStatic(true);
  planeta3.setFill(120, 10, 10);
  planeta3.setNoStroke();
  planeta3.setName("planeta3");
  planeta3.attachImage(img[3]);
  planeta3.setGroupIndex(-1);

  bala2 = new FCircle(40);
  bala2.setPosition(width/2, height/2-80);
  bala2.setDamping(0);
  bala2.setSensor(true);
  bala2.setFill(255, 100);
  bala2.setNoStroke();
  bala2.setName("balaF");
  bala2.setStatic(true);
  bala2.setGrabbable(false);

  bala = new FCircle(40);
  bala.setPosition(width/2, height/2-80);
  bala.setDamping(0);
  bala.setNoStroke();
  bala.setNoFill();
  bala.setName("bala");
  bala.setRestitution(1.5);
  bala.setGrabbable(false);
  //bala.attachImage(img[0]);

  obstaculo = new FBox(50, 20);
  obstaculo.setPosition(width/2, height/2-260);
  obstaculo.setDamping(0);
  obstaculo.setDensity(1.5);
  obstaculo.setVelocity(200, 0);
  obstaculo.setName("satelite");
  obstaculo.setRestitution(1.5);
  obstaculo.setGrabbable(false);
  obstaculo.attachImage(img[1]);
  obstaculo.setGroupIndex(-1);

  obstaculo2 = new FBox(50, 20);
  obstaculo2.setPosition(width/2, height/2-170);
  obstaculo2.setDamping(0);
  obstaculo2.setDensity(1.5);
  obstaculo2.setVelocity(-200, 0);
  obstaculo2.setName("satelite");
  obstaculo2.setRestitution(1.5);
  obstaculo2.setGrabbable(false);
  obstaculo2.attachImage(img[1]);
  obstaculo2.setGroupIndex(-1);

  agujero1 = new FCircle(80);
  agujero1.setPosition(width/4*3+50, height/3*2+100);
  agujero1.setStatic(true);
  agujero1.setSensor(true);
  agujero1.setNoFill();
  //agujero1.attachImage(img[4]);

  agujero2 = new FCircle(80);
  agujero2.setPosition(width/4, height/3-100);
  agujero2.setStatic(true);
  agujero2.setNoFill();
  agujero2.setSensor(true);
  //agujero2.attachImage(img[5]);

  mundo.add(planeta);
  mundo.add(planeta2);
  mundo.add(planeta3);
  mundo.add(bala);
  mundo.add(bala2);
  mundo.add(obstaculo);
  mundo.add(obstaculo2);
  mundo.add(agujero1);
  mundo.add(agujero2);

  textFont(fuente1);
}

void draw() {

  //println("Frames: " + frame1/4 + " . " + frame2/4 + "   .   expFrame: "  + expFrame + "    .    tiempo: " + tiempo  + "    .   choques: " + choques); 
  //println("Frames: " + frameCount/24 + "   .   agujeroframe:" + agjFrame); 
  println(cantPuntos + "  . " + mouseX + " . " + mouseY);

  background(5);

  //pantalla de inicio
  if (pantalla == 0) {

    fondo.dibujaFondo(100);

    boton0.dibujaBoton();
    texto0.dibujaTexto();

    if (boton0.colisionBoton(mouseX, mouseY) && mousePressed) {

      pantalla = 1;
    }

    //pantalla jugando
  } else if (pantalla == 1) {

    fondo.dibujaFondoR();

    if (orbitaT <= 0) {
      orbitaF = 0.15;
    } else if (orbitaT >= 20) {

      orbitaF = -0.15;
    }

    orbitaT += orbitaF;

    //area de la orbita planeta y planeta2
    push();
    fill(255, 1+orbitaT/2);
    noStroke();
    circle(px, py, 600+orbitaT);
    circle(px2, py2, 300+orbitaT);
    circle(px3, py3, 500+orbitaT);
    pop();

    //dibuja los puntos
    for ( int i=0; i<puntos.length; i++) {
      puntos[i].dibujaPunto();
      puntos[i].recojePunto();
    }

    //comienza la simulacion de fisica
    mundo.step();

    //están antes del "mundo.draw" para que se dibujen detras de la bala
    trazoBala();

    //comienza el dibujo del mundo y sus elementos
    mundo.draw();

    //funciones
    apuntar();
    reiniciar();
    seDisparo();
    marcaTiro();
    atraccionGravitatoria();
    barraTiro();
    tiroVelocidad();
    agujeroGusano(); 
    cambiaBala();
    seChoco();
    volumenFondo();

    if (vidas == 0 && tiempo < 300) {
      pantalla = 2;
    } else if (vidas == 0 && tiempo >= 300) {
      pantalla = 4;
    }

    if (puntuacion >= 5) {

      pantalla = 3;
    }

    //pantalla de perder
  } else if (pantalla == 2) {

    fondo.dibujaFondo(100);

    mundo.clear();

    boton1.dibujaBoton();
    texto1.dibujaTexto();

    if (boton1.colisionBoton(mouseX, mouseY) && mousePressed) {

      playlist[0].pause();

      setup();

      bala.setStatic(true);
    }
  } else if (pantalla == 3) {

    fondo.dibujaFondo(100);

    mundo.clear();

    boton2.dibujaBoton();
    texto2.dibujaTexto();
    texto3.dibujaTexto();

    if (boton2.colisionBoton(mouseX, mouseY) && mousePressed) {

      playlist[0].pause();

      setup();

      bala.setStatic(true);
    }
  } else if (pantalla == 4) {

    fondo.dibujaFondo(100);

    mundo.clear();

    boton1.dibujaBoton();
    texto4.dibujaTexto();
    texto5.dibujaTexto();

    if (boton1.colisionBoton(mouseX, mouseY) && mousePressed) {

      playlist[0].pause();

      setup();

      bala.setStatic(true);
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////


void atraccionGravitatoria() {

  //rotacion de planetas (mini animacion)

  planetaR += map(historial.size(), 0, 80, 0.1, 2);

  planeta.setRotation(radians(planetaR));
  planeta2.setRotation(radians(-planetaR));
  planeta3.setRotation(radians(-planetaR));

  float ox2, oy2, gox2, goy2, distanciaObstaculo2, fObstaculo2;

  float g2x2, g2y2, g2x3, g2y3, distancia5, distancia6, f5, f6;

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
  ox2 = obstaculo2.getX();

  oy = obstaculo.getY();
  oy2 = obstaculo2.getY();

  gx = px - bx;
  gy = py - by;

  g2x = px - bx2;
  g2y = py - by2;

  gx2 = px2 - bx;
  gy2 = py2 - by;

  g2x2 = px2 - bx2;
  g2y2 = py2 - by2;

  gx3 = px3 - bx;
  gy3 = py3 - by;

  g2x3 = px3 - bx2;
  g2y3 = py3 - by2;

  gox = px - ox;
  goy = py - oy;

  gox2 = px - ox2;
  goy2 = py - oy2;

  distancia1 = dist(bx, by, px, py);

  distancia2 = dist(bx, by, px2, py2);

  distancia3 = dist(bx, by, px3, py3);

  distancia4 = dist(bx2, by2, px, py);

  distancia5 = dist(bx2, by2, px2, py2);

  distancia6 = dist(bx2, by2, px3, py3);

  distanciaObstaculo = dist(ox, oy, px, py);

  distanciaObstaculo2 = dist(ox2, oy2, px, py);

  f1 = map(distancia1, 300, 50, 8, 40);

  f2 = map(distancia2, 150, 30, 15, 30);

  f3 = map(distancia3, 300, 50, 10, 45);

  f4 = map(distancia4, 300, 50, 8, 40);

  f5 = map(distancia5, 150, 30, 15, 30);

  f6 = map(distancia6, 300, 50, 10, 45);

  fObstaculo = map(distanciaObstaculo, 300, 50, 2, 6);

  fObstaculo2 = map(distanciaObstaculo2, 300, 50, 2, 6);

  if (distancia1 < 300) {

    bala.addForce(gx * f1, gy * f1);
  }

  if (distancia2 < 150) {

    bala.addForce(gx2 * f2, gy2 * f2);
  }
  if (distancia3< 300) {

    bala.addForce(gx3 * f3, gy3 * f3);
  }

  // calculos para la bala fantasma
  if (disparo == false) {
    if (distancia4 < 300) {

      bala2.addForce(g2x * f4, g2y * f4);
    }

    if (distancia5 < 150) {

      bala2.addForce(g2x2 * f5, g2y2 * f5);
    }

    if (distancia6 < 300) {

      bala2.addForce(g2x3 * f6, g2y3 * f6);
    }
  }

  if (distanciaObstaculo < 300) {

    r += 0.8;
    obstaculo.addForce(gox * fObstaculo, goy * fObstaculo);

    //float pAngle;

    // pAngle = atan2(py-oy, px-ox);

    obstaculo.setRotation(radians(r));

    //obstaculo.setAngularVelocity(100);
  }

  if (distanciaObstaculo2 < 300) {

    r2 += 0.8;
    obstaculo2.addForce(gox2 * fObstaculo2, goy2 * fObstaculo2);

    obstaculo2.setRotation(radians(-r2));
  }
}

void trazoBala() {

  int gas1 = int(constrain(map(tiempo, 0, 300, largoTrazo, 4), 2, 200));

  float gasC = constrain(map(tiempo, 0, 300, 0, 255), 0, 255);

  //println(gas1 + " .... " + historial.size());

  //println(gasC + " .... " + tiempo);

  if (disparo) { 

    for (int i=0; i<historial.size(); i++) {

      PVector p = historial.get(i);

      //println(i + "    .   " + historial.size()/2);

      float tt = constrain(map(i, 0, historial.size(), 0, 255), 0, 255);
      /*

       //version de cambios de color del trazo en todo momento (siempre se veran los 4 colores)
       if (i < historial.size()/4) {
       
       ta = map(i, 0, 20, 12, 255);
       
       tb = map(i, 0, 20, 255, 33);
       
       tc = map(i, 0, 20, 225, 124);
       
       //fill(ta, tb, tc, tt-gasC);
       
       fill(255,33,124, 255);
       
       }else if( i >= historial.size()/4 && i < historial.size()/2){
       
       fill(12, 255, 225, 255);
       }else if( i >= historial.size()/2 && i < historial.size()/4*3){
       
       fill(12, 255, 225, 255);
       }else if( i >= historial.size()/4*3){
       
       fill(255,212,134,255);
       }
       
       */

      //version de cambios de color del trazo según la cantidad de puntos (solo se vera más de 1 color si se tiene varios puntos acumulados)
      if (i <= 40) {
        //rosa
        fill(255, 33, 124, 255);
      } else if ( i > 40 && i < 60) {
        //cian
        fill(12, 255, 225, 255);
      } else if ( i >=60 && i < 80) {

        fill(255, 212, 134, 255);
      } else if ( i >=80 && i < 100) {

        fill(255, 134, 124, 255);
      }

      push();
      //color con degradado
      //fill(12, 255-i*2, 225-i*2, constrain(i*1, 0, 200));

      //color plano verde
      //fill(12, 255-i*2, 225-i*2, 255);
      //fill(198,227,112,255)

      //color plano naranja
      //fill((255,134,124,255)

      //color amarillo
      //fill(255,212,134,255);

      //color plano rosa
      //fill(255,33,124, i*4);

      //color plano cian
      //fill(12, 255, 225, i*6-gasC);

      //!!!version final con color degradado!!!
      //fill(ta, tb, tc, tt-gasC);

      //version final con color plano
      //fill(12, 255, 225, 255);

      //stroke(255, tt-gasC);
      noStroke();
      ellipse(p.x, p.y, constrain(i*1, 0, 50), constrain(i*1, 0, 50));
      pop();
    }

    PVector xy = new PVector(bx, by);

    // el trazo se agrande mientras mas estrellas agarres? Quiza hasta se haga mas luminoso o cambie de color?

    historial.add(xy);

    if (historial.size() > gas1 && historial.size() > 1) {

      historial.remove(0);
      historial.remove(1);
    } 

    /*
    if (tiempo < 200) {
     
     historial.add(xy);
     
     if (historial.size() > 40) {
     
     historial.remove(0);
     }
     } else {
     if (frameRate%2 == 2) {
     historial.remove(0);
     }
     }
     */
  }
}

void volumenFondo() {

  vol = map(historial.size(), 0, 70, 0, 6);

  playlist[0].setGain(vol);

  float vol1 = map(puntuacion, 0, 3, 0, 6);

  playlist[1].setGain(vol1);
}

void agujeroGusano() {

  agujeroR += 0.1;

  agujero1.setRotation(radians(agujeroR));
  agujero2.setRotation(radians(-agujeroR));

  agx1 = agujero1.getX();
  agy1 = agujero1.getY();

  agx2 = agujero2.getX();
  agy2 = agujero2.getY();

  float distanciaA = dist(bx, by, agx1, agy1);

  float distanciaB = dist(bx2, by2, agx1, agy1);

  agjFrame = frameCount/8 % 3;

  for (int i=0; i<1; i++) {
    push();
    translate(agx2, agy2);
    imageMode(CENTER);
    rotate(radians(agujeroR));
    image(agj1[(agjFrame)], 0, 0);
    pop();

    push();
    translate(agx1, agy1-5);
    imageMode(CENTER);
    rotate(radians(-agujeroR));
    image(agj2[(agjFrame)], 0, 0);
    pop();
  }

  if (disparo == true) {
    if (distanciaA < 75) {

      playlist[4].play();

      bala.setPosition(agx2, agy2);
      playlist[4].rewind();
    }
  }

  if (apuntado == true) {
    if (distanciaB < 75) {

      bala2.setPosition(agx2, agy2);
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
    } else if (cuerpo1.getName() == "satelite" && cuerpo2.getName() == "bala") {

      playlist[3].play();

      println(cuerpo1.getName());
      println(cuerpo2.getName());

      playlist[3].rewind();
    }
  }
}

void seChoco() {

  float c1, c2, c3;

  float gas = constrain(map(tiempo, 0, 300, 208, 0), 0, 210);

  c1 = map(tiempo, 0, 300, 13, 255);

  c2 = map(tiempo, 0, 300, 255, 20);

  c3 = map(tiempo, 0, 300, 255, 100);

  //rgba(13,255,225,255)  -  rgba(3,204,202,255)  rgba(255,33,124,255)

  if (chocarse == true) {

    bs +=5;

    choques --;

    if (choques <= 0) {

      frame1 += 1; 

      playlist[6].play();

      if (expFrame >= 3) {

        tiempoExp += 1;

        if (tiempoExp >= 50) {
          expFrame = 0;

          playlist[6].pause(); 
          playlist[6].rewind();
          perder = true;
        }
      } else { 
        expFrame = frame1/4 % 4;
      }

      for (int i=0; i<1; i++) {
        push();
        imageMode(CENTER);
        image(explosion[(expFrame)], bx, by);
        pop();
      }
    } else {
      chocarse = false;
    }
  } else {

    frame1 = 0;
  }

  if (tiempo >= 300) {

    frame2 +=1;

    playlist[6].play();

    if (expFrame >= 3) {

      tiempoExp += 1;

      if (tiempoExp >= 50) {

        playlist[6].pause(); 
        playlist[6].rewind();
        expFrame = 0;
        perder = true;
      }
    } else { 
      expFrame = frame2/4 % 4;
    }

    for (int i=0; i<1; i++) {
      push();
      imageMode(CENTER);
      image(explosion[(expFrame)], bx, by);
      pop();
    }
  } else {

    frame2 = 0;
  }

  push();
  noStroke();
  fill(c1, c2, c3);
  rect(100, 38, gas, 38, 15);

  image(img[10], 50, 30);

  /*
  noFill();
   stroke(255);
   strokeWeight(2);
   rect(50, 40, 200, 20, 60);
   */

  pop();

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

  float c1 = map(fuerza, 0, -200, 212, 124);


  // rgba(255,212,134,255) rgba(255,33,124,255)

  if (keyPressed && disparo == false) {

    barra = fuerza;
  } else if (barra < 0) {

    barra += 10;
  } else {

    barra = 0;
  }

  push();
  noStroke();
  fill(255, c1, 140);
  rect(50, 500, 20, barra, 60);

  noFill();
  strokeWeight(2);
  stroke(255);
  rect(50, 300, 20, 200, 60);
  pop();
}

void apuntar() {

  float mI = constrain(map(mouseY, 500, 300, width/2, 2500), width/2, 2500);

  if (keyPressed && disparo == false) {

    if (key != 'r') {

      bala2.setStatic(false);

      bala2.resetForces();

      if (apuntado == false) {

        bala2.addImpulse(mI, 0);

        apuntado = true;
      }

      if (temp < 100) {

        temp++;
      } else if (temp >= 100) {

        mundo.remove(bala2);

        mundo.add(bala2);

        bala2.setPosition(width/2, height/2-80);

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

  if (disparo == false && pantalla == 1) {
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
}

void tiroVelocidad() {

  float mI = constrain(map(mouseY, 500, 300, width/2, 2500), width/2, 2500);

  if (disparo == true && fuerza == true) {

    bala.addImpulse(mI, 0);

    fuerza = false;
  }
}

void seDisparo() {

  if (disparo == true && choques > 0 && tiempo < 300) {

    bala.setStatic(false);
    planeta2.setGrabbable(false);
    planeta3.setGrabbable(false);

    agujero1.setGrabbable(false);
    agujero2.setGrabbable(false);
  } else if (choques <= 0) {

    bala.setStatic(true);
  } else if (tiempo >= 300) {

    bala.setStatic(true);
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


void cambiaBala() {

  push();

  imageMode(CENTER);

  float tnt = map(historial.size(), 0, 80, 0, 255);

  if (historial.size() <= 40) {

    //cian
    tint(12, 255, 225, 255);
  } else if (historial.size() > 40 && historial.size() < 60) {
    //amarillo
    tint(255, 212, 134, 255);
  } else if (historial.size() >= 60 && historial.size() < 80) {
    //rosa
    tint(255, 33, 124, 255);
  } else if (historial.size() >= 80 && historial.size() < 100) {
    //naranja
    tint(255, 134, 124, 255);
  }


  if (choques >= 3) {

    image(img[0], bx, by);
  } else if (choques == 2) {

    image(img[8], bx, by);
  } else if (choques == 1) {

    image(img[9], bx, by);
  }

  pop();

  //color con degradado
  //fill(12, 255-i*2, 225-i*2, constrain(i*1, 0, 200));

  //color plano verde
  //fill(12, 255-i*2, 225-i*2, 255);

  //color plano naranja
  //fill(255, 134, 124, 255);

  //color amarillo
  //fill(255,212,134,255);

  //color plano rosa
  //fill(255,33,124, 255);

  //color plano cian
  //fill(12, 255, 225, 255);

  //!!!version final con color degradado!!!
  //fill(ta, tb, tc, 255);

  //version final con color plano
  //fill(12, 255, 225, 255);
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

    largoTrazo = 40;

    frame1 = 0;

    frame2 = 0;

    playlist[0].setGain(0);

    historial.clear();

    choques = 3;

    expFrame = 0;

    agjFrame = 0;

    tiempoExp = 0;

    tiempoExp = 0;

    vidas --;

    barra = 0;

    puntuacion = 0;

    x = 0;

    bs = 0;

    r = 0;

    temp = 0;

    if (vidas > 0) {

      tiempo = 0;
    }

    disparo = false;
    fuerza = false;
    apuntado = false;
    chocarse = false;
    perder = false;

    cantPuntos = int(random(6, 11));

    puntos = new Punto[cantPuntos];

    puntoX = random(400, 1000);

    puntoY = random(150, 750);

    //puntoF = random(40, 100);


    for ( int i=0; i<puntos.length; i++) {

      if (i == 0) {
        puntos[i] = new Punto(width/2+100, height/3+80);
      } else if (i == 1) {
        puntos[i] = new Punto(width/2+140, height/3+200);
      } else if (i == 2) {
        puntos[i] = new Punto(width/2-20, height/3+260);
      } else if (i == 3) {
        puntos[i] = new Punto(width/2-120, height/3+140);
      } else if (i == 4) {
        puntos[i] = new Punto(width/2+420, height/2-160);
      } else if (i == 5) {
        puntos[i] = new Punto(width/2+320, height/2-80);
      } else if (i == 6) {
        puntos[i] = new Punto(width/2+220, height/2-160);
      } else if (i == 7) {
        puntos[i] = new Punto(width/2-460, height/2+240);
      } else if (i == 8) {
        puntos[i] = new Punto(width/2-620, height/2+300);
      } else if (i == 9) {
        puntos[i] = new Punto(width/2-410, height/2);
      } else if (i == 10) {
        puntos[i] = new Punto(width/2-400, height/2-180);
      } else if (i == 11) {
        puntos[i] = new Punto(width/2-420, height/2-200);
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
    planeta.setGroupIndex(-1);

    planeta2 = new FCircle(50);
    planeta2.setPosition(width/3*3-140, height/3*2);
    planeta2.setStatic(true);
    planeta2.setFill(10, 120, 10);
    planeta2.setNoStroke();
    planeta2.setName("planeta2");
    planeta2.attachImage(img[6]);
    planeta2.setGroupIndex(-1);

    planeta3 = new FCircle(110);
    planeta3.setPosition(width/9, height/3*2);
    planeta3.setStatic(true);
    planeta3.setFill(120, 10, 10);
    planeta3.setNoStroke();
    planeta3.setName("planeta3");
    planeta3.attachImage(img[3]);
    planeta3.setGroupIndex(-1);

    bala2 = new FCircle(40);
    bala2.setPosition(width/2, height/2-80);
    bala2.setDamping(0);
    bala2.setSensor(true);
    bala2.setFill(255, 100);
    bala2.setNoStroke();
    bala2.setName("balaF");
    bala2.setStatic(true);
    bala2.setGrabbable(false);

    bala = new FCircle(40);
    bala.setPosition(width/2, height/2-80);
    bala.setDamping(0);
    bala.setNoStroke();
    bala.setNoFill();
    bala.setName("bala");
    bala.setRestitution(1.5);
    bala.setGrabbable(false);
    bala.attachImage(img[0]);

    obstaculo = new FBox(50, 20);
    obstaculo.setPosition(width/2, height/2-260);
    obstaculo.setDamping(0);
    obstaculo.setDensity(1.5);
    obstaculo.setVelocity(200, 0);
    obstaculo.setName("satelite");
    obstaculo.setRestitution(1.5);
    obstaculo.setGrabbable(false);
    obstaculo.attachImage(img[1]);
    obstaculo.setGroupIndex(-1);

    obstaculo2 = new FBox(50, 20);
    obstaculo2.setPosition(width/2, height/2-170);
    obstaculo2.setDamping(0);
    obstaculo2.setDensity(1.5);
    obstaculo2.setVelocity(-200, 0);
    obstaculo2.setName("satelite");
    obstaculo2.setRestitution(1.5);
    obstaculo2.setGrabbable(false);
    obstaculo2.attachImage(img[1]);
    obstaculo2.setGroupIndex(-1);

    agujero1 = new FCircle(80);
    agujero1.setPosition(width/4*3+50, height/3*2+100);
    agujero1.setStatic(true);
    agujero1.setSensor(true);
    agujero1.setNoFill();
    //agujero1.attachImage(img[4]);

    agujero2 = new FCircle(80);
    agujero2.setPosition(width/4, height/3-100);
    agujero2.setStatic(true);
    agujero2.setNoFill();
    agujero2.setSensor(true);
    //agujero2.attachImage(img[5]);

    mundo.add(planeta);
    mundo.add(planeta2);
    mundo.add(planeta3);
    mundo.add(bala);
    mundo.add(bala2);
    mundo.add(obstaculo);
    mundo.add(obstaculo2);
    mundo.add(agujero1);
    mundo.add(agujero2);
  }
}
