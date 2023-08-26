int n = 50;
float[] x = new float[n];
float[] y = new float[n];
float[] dx = new float[n];
float[] dy = new float[n];
int[] c = {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
float range=100;
float range2=100;
float radius=50;
float beta=0.1;

void setup() {
  size(1200, 800);
  smooth();
  background(0);
  for(int i = 0; i < n; i++){
    x[i] = random(width);
    y[i] = random(height);
    dx[i] = random(-5, 5);
    dy[i] = random(-5, 5);
  }
}

 
void draw() {
  background(255);
  noFill();
  circle(mouseX,mouseY,range2);
  for(int i = 0; i < n; i++){
    x[i]=x[i]+dx[i];
    y[i]=y[i]+dy[i];
     if (x[i] > width){
   x[i]=x[i]-width; 
  }else if(x[i]<0){
   x[i]=-x[i]+width;  
  }
  if (y[i] > height){
   y[i]=y[i]-height; 
  }else if(y[i]<0){
   y[i]=-y[i]+height;  
  }
  stroke(4);  
  fill(255,255,255);
  circle(x[i],y[i],radius);
  if(c[i]==1){
    fill(255,0,0);
  ellipse(x[i], y[i], 10, 10);
  }else if(c[i]==0){
      fill(0,255,0);
  ellipse(x[i], y[i], 10, 10);
  }
  float rm = sqrt(pow((x[i]-mouseX),2) + pow((y[i]-mouseY),2));          
       if(rm<range2){
       strokeWeight(2); 
       line(x[i], y[i], mouseX, mouseY);    
       if(c[i]==1){
           c[i]=0;
         }else{
           c[i]=c[i];
         }
       }
   for(int j = 0; j < n; j++){
       float r = sqrt(pow((x[i]-x[j]),2) + pow((y[i]-y[j]),2));          
       if(r<range){
       strokeWeight(2); 
       line(x[i], y[i], x[j], y[j]);    
       float rn= random(0,1);
       if(c[i]==1 & c[j]==0){
         if(rn<beta){
           c[j]=1;
           c[i]=1;  
         }else{
           c[j]=0;
           c[i]=1;
         }
       }else if(c[i]==0 & c[j]==1){
         if(rn<beta){
           c[j]=1;
           c[i]=1;  
         }else{
           c[j]=1;
           c[i]=0;
         }
         
       }else if(c[i]==0 & c[j]==0){
         c[j]=0;
         c[i]=0;
       }else if(c[i]==1
       & c[j]==1){
         c[j]=1;
         c[i]=1;
       }
       }else{
       c[j]=c[j];
       c[i]=c[i];
       }
   }
  }
}
