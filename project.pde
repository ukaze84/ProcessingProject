import ddf.minim.*;
Minim minim;
AudioPlayer song;
AudioPlayer ding;
candy[] candies;
heart[] hearts;
star[] stars;
bomb[] bombs;
roach[] roaches;
hentai[] hentais;
player[] aplayer;
ohoh_struct[] ohoh_obj;
ohno_struct[] ohno_obj;
int score=0;
int x=600, y=585;
PImage back, player1, candy1, heart1, star1, bomb1, roach1, hentai1, ohno, ohoh, start, end, temp;
PFont font;
//boolean show = true;
boolean justClick=true;
boolean justStart=true;
boolean dead;
int posX=(int)random(width);
int posY=(int)random(height);
void setup() {
  size(1280, 720);
  score=0;
  justStart=true;
  dead=false;
  font=loadFont("Ravie-48.vlw");
  back=loadImage("background.jpg");
  player1=loadImage("player.png");
  candy1=loadImage("candy.png");
  heart1=loadImage("heart.png");
  star1=loadImage("star.png");
  bomb1=loadImage("bomb.png");
  roach1=loadImage("roach.png");
  hentai1=loadImage("hentai.png");
  ohno=loadImage("ohno.png");
  ohoh=loadImage("ohoh.png");
  start=loadImage("start.png");
  end=loadImage("end.png");
  aplayer=new player[1];
  textFont( font );
  for (int i=0; i<=0; i++) {
    aplayer[i]=new player();
  }
  candies = new candy[100];
  for ( int i = 0; i<100; i++) {
    candies[i] = new candy();
  }
  hearts = new heart[100];
  for ( int i = 0; i<100; i++) {
    hearts[i] = new heart();
  }
  stars = new star[100];
  for ( int i = 0; i<100; i++) {
    stars[i] = new star();
  }
  bombs = new bomb[50];
  for ( int i = 0; i<50; i++) {
    bombs[i] = new bomb();
  }
  roaches = new roach[50];
  for ( int i = 0; i<50; i++) {
    roaches[i] = new roach();
  }
  hentais = new hentai[30];
  for ( int i = 0; i<30; i++) {
    hentais[i] = new hentai();
  }
  ohoh_obj = new ohoh_struct[1];
  ohoh_obj[0] = new ohoh_struct();
  ohno_obj = new ohno_struct[1];
  ohno_obj[0] = new ohno_struct();
  minim = new Minim(this);
  song = minim.loadFile("song.mp3");
  song.loop();
}
void draw() {
  if (justStart && mousePressed && mouseButton == LEFT&& mouseX<=1220 && mouseX >=810 && mouseY <=440 && mouseY >=240)
    justStart=false;
  else if (dead && mousePressed && mouseButton == LEFT&& mouseX<=1030 && mouseX >=700 && mouseY <=650 && mouseY >=460)
    setup();
  if (score<0) {
    minim.stop();
    dead=true;
  }
  if (justStart) image(start, 0, 0);
  else if (dead) image(end, 0, 0);
  else { //game start
    image(back, 0, 0);
    for (int i=0; i<1; i++) {
      aplayer[i].drawIt();
    }
    for ( int i = 0; i<100; i++) {
      candies[i].drawIt();
      hearts[i].drawIt();
      stars[i].drawIt();
    }
    for ( int i = 0; i<50; i++) {
      bombs[i].drawIt();
      roaches[i].drawIt();
    }
    for ( int i = 0; i<30; i++) {
      hentais[i].drawIt();
    }
    ohoh_obj[0].drawIt();
    ohno_obj[0].drawIt();
    textSize(30);
    fill(136, 241, 250);
    text("Score:"+score, 1000, 50);
  }
}
void keyPressed() {
  if ((x<=width-80) && (keyPressed == true) && (key == 'D'||key == 'd') ) x+=20;
  if ( (x>=0) && (keyPressed == true) && (key == 'A'||key == 'a') ) x-=20;
}
void mouseReleased() {
  justClick=true;
}
void mousePressed() {
  if (justClick && (mousePressed == true) && (mouseButton == LEFT)) {
    justClick=false;
    bombs[(int)random(49)].alive();
  }
  if (justClick && (mousePressed == true) && (mouseButton == RIGHT)) {
    justClick=false;
    roaches[(int)random(49)].alive();
  }
}
class player {
  boolean show = false;  
  void drawIt() {
    image(player1, x, y);
    catchcandy();
    catchheart();
    catchstar();
    catchbomb();
    catchroach();
    catchhentai();
  }
  void hide() {
    show = false;
  }
  void catchcandy() {
    for ( int i = 0; i<100; i++) {
      if (candies[i].inRange(x, y)) {
        hide();
        candies[i].hide();
        score+=5;
        ding = minim.loadFile("ding.mp3");
        ding.play();
      }
    }
  }
  void catchheart() {
    for ( int i = 0; i<100; i++) {
      if (hearts[i].inRange(x, y)) {
        hide();
        hearts[i].hide();
        score+=5;
        ding = minim.loadFile("ding.mp3");
        ding.play();
      }
    }
  }
  void catchstar() {
    for ( int i = 0; i<100; i++) {
      if (stars[i].inRange(x, y)) {
        hide();
        stars[i].hide();
        score+=5;
        ding = minim.loadFile("ding.mp3");
        ding.play();
      }
    }
  }
  void catchbomb() {
    for ( int i = 0; i<50; i++) {
      if (bombs[i].inRange(x, y)) {
        hide();
        bombs[i].hide();
        score-=10;
        //image(ohno,x,y-200);
        ohno_obj[0] = new ohno_struct();
      }
    }
  }
  void catchroach() {
    for ( int i = 0; i<50; i++) {
      if (roaches[i].inRange(x, y)) {
        hide();
        roaches[i].hide();
        score-=10;
        //image(ohno,x,y-200);
        ohno_obj[0] = new ohno_struct();
        //ohno_obj[0].active(x,y-200);
      }
    }
  }
  void catchhentai() {
    for ( int i = 0; i<30; i++) {
      if (hentais[i].inRange(x, y)) {
        hide();
        hentais[i].hide();
        score-=100;
        //showSth(ohoh,x,y-200);
        ohoh_obj[0] = new ohoh_struct();
        //image(ohoh,x,y-200);
      }
    }
  }
}
//
class ohoh_struct {
  boolean show;
  int posX;
  int posY;
  int run;
  ohoh_struct() {
    posX=x-90;
    posY=y-200;
    run=(justStart?0:15);
    show=true;
  }
  void active() {
    posX=x;
    posY=y;
  }
  void hide() {
    show = false;
  }
  void drawIt() {
    if ( show ) {
      image(ohoh, posX, posY);
      run--;
      if ( run<=0 ) {
        hide();
      }
    }
  }
}
class ohno_struct {
  boolean show;
  int posX;
  int posY;
  int run;
  ohno_struct() {
    posX=x-50;
    posY=y-200;
    run=(justStart?0:15);
    show = true;
  }
  void active() {
    posX=x;
    posY=y;
  }
  void hide() {
    show = false;
  }
  void drawIt() {
    if ( show ) {
      image(ohno, posX, posY);
      run--;
      if ( run<=0 ) {
        hide();
      }
    }
  }
}
class candy {
  boolean show = true;
  int posX;
  int posY;
  candy() {
    posX=(int)random(width-60);
    posY=(int)random(-30000);
  }
  void drawIt() {
    if ( show ) {
      image(candy1, posX, posY);
      posY+=2;
      if ( posY >= height ) {
        hide();
      }
    }
  }

  void hide() {
    show = false;
  }
  boolean inRange(int x1, int y1) {
    if (show)
      if (x1>=posX-20)
        if (x1<=posX+60)
          if (y1>=posY)
            if (y1<=posY+30) {
              return true;
            }
    return false;
  }
}

class heart {
  boolean show = true;
  int posX;
  int posY;
  heart() {
    posX=(int)random(width-60);
    posY=(int)random(-30000);
  }
  void drawIt() {
    if ( show ) {
      image(heart1, posX, posY);
      posY+=2;
      if ( posY >= height ) {
        hide();
      }
    }
  }

  void hide() {
    show = false;
  }
  boolean inRange(int x1, int y1) {
    if (show)
      if (x1>=posX-20)
        if (x1<=posX+60)
          if (y1>=posY)
            if (y1<=posY+30) {
              return true;
            }
    return false;
  }
}

class star {
  boolean show = true;
  int posX;
  int posY;
  star() {
    posX=(int)random(width-60);
    posY=(int)random(-30000);
  }
  void drawIt() {
    if ( show ) {
      image(star1, posX, posY);
      posY+=2;
      if ( posY >= height ) {
        hide();
      }
    }
  }

  void hide() {
    show = false;
  }
  boolean inRange(int x1, int y1) {
    if (show)
      if (x1>=posX-20)
        if (x1<=posX+60)
          if (y1>=posY)
            if (y1<=posY+30) {
              return true;
            }
    return false;
  }
}

class bomb {
  boolean show = true;
  boolean alive = false;
  int posX;
  int posY;
  bomb() {
    posX=(int)random(width-60);
    posY=-60;
  }
  void drawIt() {
    if ( show && alive ) {
      image(bomb1, posX, posY);
      posY+=3;
      if ( posY >= height ) {
        hide();
      }
    }
  }
  void alive() {
    alive=true;
  }
  void hide() {
    show = false;
  }
  boolean inRange(int x1, int y1) {
    if (show)
      if (x1>=posX-20)
        if (x1<=posX+60)
          if (y1>=posY)
            if (y1<=posY+30) {
              return true;
            }
    return false;
  }
}

class roach {
  boolean show = true;
  boolean alive = false;
  int posX;
  int posY;
  roach() {
    posX=(int)random(width-60);
    posY=-60;
  }
  void drawIt() {
    if ( show&&alive ) {
      image(roach1, posX, posY);
      posY+=3;
      if ( posY >= height ) {
        hide();
      }
    }
  }
  void alive() {
    alive=true;
  }
  void hide() {
    show = false;
  }
  boolean inRange(int x1, int y1) {
    if (show)
      if (x1>=posX-20)
        if (x1<=posX+60)
          if (y1>=posY)
            if (y1<=posY+30) {
              return true;
            }
    return false;
  }
}

class hentai {
  boolean show = true;
  int posX;
  int posY;
  hentai() {
    posX=(int)random(width-319);
    posY=(int)random(-100000);
  }
  void drawIt() {
    if ( show ) {
      image(hentai1, posX, posY);
      posY+=3;
      if ( posY >= height ) {
        hide();
      }
    }
  }

  void hide() {
    show = false;
  }
  boolean inRange(int x, int y) {
    if (show)
      if (x>=posX)
        if (x<=posX+319)
          if (y>=posY)
            if (y<=posY+424) {
              return true;
            }
    return false;
  }
}