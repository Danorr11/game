import processing.serial.*;
Serial port;
int leer; 
float mapeado;
PImage Tanque, others, ert, car, car2, licence;
float posX;
float posY;
PFont myFont;
float X;
float Y;

int r=0;

int s=0;

int p=0;

int []dvy={-50, 100, 250, 400, 550, 700, 900};

int dvp=2;

int x=350, y=800;
int rx1() {
  return int(random(175, 315));
}
int rx2() {
  return int(random(385, 525));
}
int ry() {
  return int(random(-60, -59));
}
int rs() {
  return int(random(2));
}
int[]cx={rx1(), rx1(), rx2(), rx2()};
int[]cx1={rx1(), rx1(), rx2(), rx2()};
float[]cy={-59, -200, -350, -600};
float[]cyr={-59, -200, -350, -600};

int Puntaje;

int k=0;

int roadside =rs();

float m=5;

float d=m;

float n=0.001;


int pos=0;

void setup() {
  size(700, 900);
  textAlign(CENTER, CENTER);
  Tanque=loadImage("Tanque2D.png");
  car2=loadImage("car2.png");
  licence=loadImage("lic.png");
  others=loadImage("Misil2D.png");
port = new Serial(this, "COM8",9600);


  for (int i=0; i<=3; i++) {
    cy[i]=ry();
    cx[i]=p;
  }
}
void draw() {
  background(0, 0, 150); //FONDO AZUL

  //println(d);
  imageMode(CENTER); 
  if (r==0) {
    fill(0);
    textSize(50);
    text("Presiona ENTER para empezar", width/2, height/2);
  }
  if (r==1) {
    gameover();
  }
  if (r==2) {
  //FONDO IN-GAME
 background(#FFFFFF);
    }
    //image(Tanque, x, y);
    for (int i=0; i<=3; i++) {
      image(others, cx[i], cy[i]);
    }
    
    //PUNTAJE
    fill(0);
    textSize(50);
    text(Puntaje, 80, 80);
    m+=n;
    for (int i=0; i<=3; i++) {
      cy[i]+=d;
    }
    for (int i=0; i<=3; i++) {
      if (cy[i]>=959) {
        Puntaje+=5;
        cy[i]=ry();

       

      }
    }
    if (x>=521) {
      x=521;
    } else if (x<=179) {
      x=179;
    }
    if (y>=840) {
      y=840;
    } else if (y<=60) {
      y=60;
    }
    for (int i=0; i<=3; i++) {
      if (cy[i]>=(y-117) && cy[i]<=(y+117) && cx[i]>=(x-46) && cx[i]<=(x+46)) {
        gameover();
      }
    }
     if ( 0 < port.available ())
{
  leer = port.read();
  println(leer);
   mapeado =  map (leer,0,255,0,768);
   posX=mapeado;
   posY=900;
   
   image(Tanque,posX,posY);
   
}
  }


void keyPressed() {  

  if (key=='X') {
    r=2;
    Puntaje=0;
    reset();
    m=5;
    d=m;
    s=0;
  }
}

void keyReleased() {

  k=0;


  println(mouseY);
}
void gameover() {


  r=1;

  fill(0);
  if (Puntaje<=49) {
    image(car2, 350, 462);
    textSize(50);
    text("Not good", 350, 100);
    text("Tu puntaje:", 350, 150);
    text(Puntaje, 350, 300);
    textSize(10);
    text("Presiona ENTER para empezar", 350, 350);
    textSize(30);
    text("You failed in test. We can't give you licence", 350, 602);
  }
 
  s++;
  reset();
}
void reset() {
  x=350;
  y=800;
  d=5;
  for (int i=0; i<=3; i++) {
    cx[i]=cx1[i];
    cy[i]=cyr[i];
  }
}
