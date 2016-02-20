class ball{
 Vec2D loc;
 Vec2D v;
 int size;
 int margin;
 boolean bounce=false;
 boolean live=true;
 

 
 ball(){
 size=10;
 margin=20;
 loc=new Vec2D(width,height);
 v=new Vec2D(0,0);
 }
 
 ball(Vec2D location, Vec2D velocity,int s,int m){
 loc=location;
 v=velocity;
 size=s;
 margin=20;
 }
 
 void update(bar BAR,block BLOCK[][],int speed){
 //if ball hits the wall, it will bounce back.
 if((loc.x ==(margin))||(loc.x ==(width-margin))){
    v.x=v.x*(-1);
 }
 if(loc.y==(margin)){
    v.y=v.y*(-1);
    bounce=true;
 }
 
 //if hits the bar, bounce back.
 if((BAR.y-loc.y)<(5+size) && bounce==true
       &&abs(loc.x-BAR.x)<BAR.len/2 && (BAR.y-loc.y)>0){
           
       v.y=v.y*(-1);
       v.x=abs(v.x)*constrain(v.x*random(0.3,3),2,5)/v.x;
       bounce=false;
 }
 
 if(loc.y==height-margin){
     live=false;
 }
 
 //if hits the block,bounce back.
 if(check_collison(BLOCK)==true){
     v.y=v.y*(-1);
     v.x=abs(v.x)*constrain(v.x*random(0.3,3),2,5)/v.x;
     bounce=true;
     score++;
 }
 
 loc.x=constrain(loc.add(v).x,margin,width-margin);
 loc.y=constrain(loc.add(v).y,margin,height-margin);
 v.y=v.y*speed/abs(v.y);
 }
 
 void display(){
    fill(255,0,0);
    ellipse(loc.x,loc.y,size,size);  
 }
 
 boolean check_collison(block [][]blk){
   if(loc.y<140){ 
    for(int i=row-1;i>=0;i--){
       for(int j=0;j<col;j++){
         if(blk[i][j].check_collision(loc)==true)
            return true;   
       }
    }
    return false;
   }
  return false; 
 }
 
}
