class block{
 Vec2D loc;
 boolean live=true;
 int R;
 int G;
 int B;
 int l;
 int h;
 
 block(){
   R=int(random(255));
   G=int(random(255));
   B=int(random(255));
   loc=new Vec2D(int(random(width)),int(random(height)));
   l=10;
   h=5;
 }
 
 block(Vec2D location,int r,int g,int b,int LENGHT,int HEIGHT){
   loc=location;
   R=r;
   G=g;
   B=b;
   l=LENGHT;
   h=HEIGHT; 
 }
 
 void display(){
   if(live==true){
       fill(R,G,B);
       rect(loc.x,loc.y,l,h);
     }  
 }
 
 boolean check_collision(Vec2D v){
     /*
     if collision,kill the block ann then hide it 
     in the right bottom corner.
     */
     if(abs(v.x-loc.x)<l && abs(v.y-loc.y)<2*h){
        live=false;
        loc.x=width;
        loc.y=height;
        return true;
    }
     else{
        return false;
    }   
 }
 
 
}
