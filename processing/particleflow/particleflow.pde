
float t;

final boolean use_texture = false;
final int NUM_PS = 500;

PImage a;

 float div = 150.0;
 
 
class particle {
  float x;
  float y;  
  
  float old_x;
  float old_y;
  
  int counter;
  
  color c;
  
  
 
  final float mv = 60.0;
  
  static final float max_counter = 150;
  
  void draw() {
    stroke(c);
      fill(c);
      
      line(x,y,old_x,old_y);
   //rect(x,y,2,2);  
  }
  
  void update() {
    
    
    
    counter++;
    if (counter > max_counter)  new_pos();
    
    old_x = x;
    old_y = y;

  
    x += mv*(noise(x/div,y/div,t) - 0.5);
    y += mv*(noise(width + x/div,y/div,t) - 0.5);   
  }
  
  void new_pos() {
   
    
 
    
        counter = 0;
          int sel = (int)(random(4)%4);    
       
          if (sel == 0) {
             x = random(width);
             y = 0;    
          } else if (sel == 1) {
             x = random(width);
             y = height;    
          } else if (sel == 2) {
             x = 0;
             y = random(height);
          } else if (sel == 3) {
            x = width;
            y = random(height);
          }
          
          old_x = x;
          old_y = y;
          
               float c1 = x/width*255;
      float g = y/height*255;
      float b = random(255);
      //if (random(1) > 0.9)c1 = 0;
      
      c = color(c1,g,b,10+random(10));
      if (use_texture)  c = color(c1,g,b,10+random(90));
         
  }
  
  particle() {
     new_pos();
  }
  
  void test_respawn() {
    final float f = 0.1;
    if ((x > width*(1.0+f))  || (x < -width*f) || 
        (y > height*(1.0+f)) || (y < -height*f) ) {
          
          new_pos();

        }  
  }
  
};

particle ps[];

void setup() {
  
  
  frameRate(30);
  size(800,600,P3D);
  
     a = new PImage();
     a.width = width;
     a.height = height;
     a.pixels = new color[a.width*a.height];
     
  
  ps = new particle[NUM_PS];  
  
  for (int i = 0; i< ps.length; i++) {
     ps[i] = new particle();  
     ps[i].counter = (int)random(particle.max_counter);
  }
  
  background(0);
}

int counter;
void draw() {
  
  
  if (use_texture) {
  float ofs[] = new float[8];
  for (int i = 0; i< ofs.length; i++) {
  ofs[i] = 0; //1.0*(noise(t*10+i*1000)-0.5);
}

  beginShape();
texture(a);
vertex(0,     0,      0+ofs[0],       0+ofs[1]);
vertex(width, 0,      a.width+ofs[2], 0+ofs[3]);
vertex(width, height, a.width+ofs[4], a.height+ofs[5]);
vertex(0,     height, 0+ofs[6],       a.height+ofs[7]);
endShape();

  
  } else {
      
  
  counter++;
  if (counter % 100 == 0) { 
    fill(0,0,0,1);
    rect(0,0, width, height);
  }
  }
  t += 0.005;
  
  
   noStroke();
   
  
  for (int i = 0; i< NUM_PS; i++) {
     ps[i].update();
     ps[i].draw();
     ps[i].update();
      ps[i].draw();
     ps[i].update();
     ps[i].draw();
     ps[i].update();
      ps[i].draw();
      
   ps[i].test_respawn();
   
   
   
   
   
  

 
  }
  
  //div += 1.0*(noise(t)-0.5);
  
  if (use_texture) {
  loadPixels();
  arraycopy(pixels,a.pixels);
  }
}
