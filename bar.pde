class bar{
int x;
int y;
int len;
int th;

bar(){
  y=height-40;
  x=width/2;
  len=40;
  th=10;
}
bar(int LENGTH){
  y=height-40;
  x=width/2;
  len=LENGTH;
  th=10;
}

void display(){
  fill(0,0,255);
  rect(x,y,len,th);
}

}
