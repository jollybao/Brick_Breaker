import toxi.geom.*;
import controlP5.*;
import processing.serial.*;
import cc.arduino.*;

//Serial myport;
Arduino arduino;

static int margin=20;
int row=4;
int col=15;
int LEN=30;
int HI=20;
int HEIGHT=500;
int WIDTH=LEN*col+2*margin;
int bar_spd=20;
int ball_spd=2;
int bar_len=40;
public int score=0;
int x_min;
int x_max;
int pin_left=6;
int pin_right=7;
      

ControlP5 bar_speed;
ControlP5 ball_speed;
ControlP5 len_of_bar;

PFont font;
String s="You Lost!";
String p="Pause";
String w="You Win!";
boolean pause=false;
boolean win=false;

block [][]blk=new block[row][col]; //colletion of blocks
ball BALL;
bar BAR;

void setup(){   
//arduino=new Arduino(this,Arduino.list()[0],57600); 
//arduino.pinMode(pin_left,Arduino.INPUT);
//arduino.pinMode(pin_right,Arduino.INPUT);

//myPort = new Serial(this, Serial.list()[0], 9600);
    
size(WIDTH,HEIGHT);
smooth();
//initialize ball.
Vec2D location=new Vec2D(width/2,height-50);
Vec2D v=new Vec2D(2,-1*ball_spd);
BALL=new ball(location,v,10,margin);

//initialize bar.
BAR=new bar(bar_len);

//initialize blocks.   
for(int i=0;i<row;i++){
  for(int j=0;j<col;j++){
     float x=(0.5+j)*LEN+margin;
     float y=(0.5+i)*HI+3*margin;
     Vec2D loc=new Vec2D(x,y);
     int r=int(random(255));
     int g=int(random(255));
     int b=int(random(255));
     blk[i][j]=new block(loc,r,g,b,LEN,HI);
  }
}

//load font
font=loadFont("ItalicT-48.vlw");
textFont(font);
rectMode(CENTER);
stroke(255);

//bar_speed slider
bar_speed=new ControlP5(this);
Slider bar_s=bar_speed.addSlider("bar_spd",10,50,20,0,0,200,15);
bar_speed.controller("bar_spd").setColorActive(#5065CB);
bar_speed.controller("bar_spd").setColorBackground(#559D41);
bar_speed.controller("bar_spd").setColorForeground(#FF0000);
bar_speed.controller("bar_spd").setColorLabel(#AF37A1);

//ball_speed slider
ball_speed=new ControlP5(this);
Slider ball_s=ball_speed.addSlider("ball_spd",1,5,2,245,0,200,15);
ball_speed.controller("ball_spd").setColorActive(#5065CB);
ball_speed.controller("ball_spd").setColorBackground(#559D41);
ball_speed.controller("ball_spd").setColorForeground(#FF0000);
ball_speed.controller("ball_spd").setColorLabel(#AF37A1);

//bar-len slider
len_of_bar=new ControlP5(this);
Slider bar_l=len_of_bar.addSlider("bar_len",10,width-2*margin,40,0,height-15,width,15);
len_of_bar.controller("bar_len").setColorActive(#5065CB);
len_of_bar.controller("bar_len").setColorBackground(#559D41);
len_of_bar.controller("bar_len").setColorForeground(#FF0000);
len_of_bar.controller("bar_len").setColorLabel(#AF37A1);


}

void draw(){
/*    
if(myPort.available() > 0){    
  int val=myport.read();
  //move left while input is one;
  if(val==1){
     BAR.x=constrain(BAR.x-bar_spd,x_min,x_max);
  }
  else{
     BAR.x=constrain(BAR.x+bar_spd,x_min,x_max);
  }
}
*/

x_min=BAR.len/2+margin;
x_max=width-BAR.len/2-margin;

background(255);
fill(0);
rect(width/2,height/2,width-2*margin+BALL.size,
height-2*margin+BALL.size);

for(int i=row-1;i>=0;i--){
   for(int j=0;j<col;j++){
     blk[i][j].display();
  }
} 

if(score==col*row){
   win=true;
}


if(pause==false){
   
  if(win==false){ 
      //game-over determination.
      if(BALL.live==true){
        fill(#6CE3BC);
        textSize(150);
        text(score,150,300);
    
        BAR.len=bar_len;
        BALL.update(BAR,blk,ball_spd);
        BALL.display();
        BAR.display();
        
        //digital input as to move bar.
        /*
        if(arduino.digitalRead(pin_left)==arduino.HIGH){
           BAR.x=constrain(BAR.x-bar_spd,x_min,x_max);
        }
        if(arduino.digitalRead(pin_right)==arduino.HIGH){
           BAR.x=constrain(BAR.x+bar_spd,x_min,x_max);
        }
        */
       }
      else{
        fill(255,0,0);
        textSize(60);
        text(s,60,300);
      }
  }
  else{
       fill(255,0,0);
       textSize(60);
       text(w,60,300);  
  }
}
else{
   fill(255,0,0);
   textSize(60);
   text(p,100,300);
}

}

void keyPressed(){
    if(key=='a'&&BAR.x>20&&BALL.live==true){
      BAR.x=constrain(BAR.x-bar_spd,x_min,x_max);
    }
    if(key=='d'&&BAR.x<(width-BAR.len/2)&&BALL.live==true){ 
      BAR.x=constrain(BAR.x+bar_spd,x_min,x_max);  
    } 
    if(key==' '){
      pause=!pause;  
    } 
    if(key=='r'||key=='R'){
      //reinitialize ball.
      BALL.live=true;
      Vec2D location=new Vec2D(width/2,height-50);
      Vec2D v=new Vec2D(2,-2);
      BALL=new ball(location,v,10,margin);

      //reinitialize blocks.
      for(int i=0;i<row;i++){
        for(int j=0;j<col;j++){
        float x=(0.5+j)*LEN+margin;
        float y=(0.5+i)*HI+3*margin;
        Vec2D loc=new Vec2D(x,y);
        int r=int(random(255));
        int g=int(random(255));
        int b=int(random(255));
        blk[i][j]=new block(loc,r,g,b,LEN,HI);
        }
      }
      
      //reinitialize bar.
      BAR.y=height-40;
      BAR.x=width/2;
      
      //reinitialize score.
      score=0;
      
      win=false;
    }
}
