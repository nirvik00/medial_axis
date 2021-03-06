import java.util.*;
int ver_in_arc=15;
// LecturesInGraphics: vector interpolation
// Template for sketches
// Author: Jarek ROSSIGNAC
PImage KimPix; // picture of author's face, should be: data/pic.jpg in sketch folder
PImage MartinPix; // picture of author's face, should be: data/pic.jpg in sketch folder

//**************************** global variables ****************************
pts P = new pts();

float t=0.5, f=0;
Boolean animate=true, linear=true, circular=true, beautiful=true;
boolean b1=true, b2=true, b3=true, b4=true;
float len=200; // length of arrows

//**************************** initialization ****************************
float q=0;
void setup() {               // executed once at the begining 
  size(800, 800, P2D);            // window size
  frameRate(30);             // render 30 frames per second
  smooth();                  // turn on antialiasing
  KimPix = loadImage("data/Kim.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  MartinPix = loadImage("data/Martin.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  P.declare().resetOnCircle(4);
  P.loadPts("data/pts");
  }

//**************************** display current frame ****************************
void draw() {      // executed at each frame
  background(white); // clear screen and paints white background
  if(snapPic) beginRecord(PDF,PicturesOutputPath+"/P"+nf(pictureCounter++,3)+".pdf"); // start recording for PDF image capture
  if(animating) {t+=0.01; if(t>=1) {t=1; animating=false;}} 

  strokeWeight(2);
  pt S=P.G[0], E=P.G[1], L=P.G[2], R=P.G[3]; // named points defined for convenience
  stroke(black); edge(S,L); edge(E,R);
  float s=d(S,L), e=d(E,R); // radii of control circles computged from distances
  CIRCLE Cs = C(S,s), Ce = C(E,e); // declares circles
  stroke(dgreen); Cs.drawCirc(); stroke(red); Ce.drawCirc(); // draws both circles in green and red
  
 /*
 *  
 */
   stroke(200); 
   noFill();
   vec rSL=U(R(V(S,L)));
   float t=(d2(E,R) - d2(E,L))/(2*dot(rSL, V(E,L)));      
   pt O=new pt(L.x,L.y).add(S(t,rSL));
   float rad=d(E,R);
   float ang=acos(rad/d(E,O));   
   pt M=new pt(E.x,E.y);
   M.add(S(rad, U(R(V(E,O),ang))));
   PShape A0=drawCircleArcInHat(L,O,M,ver_in_arc);
   shape(A0);
   String dat0=DataArcInHat(L,O,M);
   float pt0x=Float.parseFloat(dat0.split(",")[0]);
   float pt0y=Float.parseFloat(dat0.split(",")[1]);
   float pt0r=Float.parseFloat(dat0.split(",")[2]);
   pt pt0S=new pt(pt0x,pt0y);
   
   vec rER=U(R(V(E,R)));
   float t_=(d2(S,L) - d2(S,R))/(2*dot(rER, V(S,R)));
   pt O_=new pt(R.x,R.y).add(S(t_,rER));
   float rad2=d(S,L);
   float ang2=acos(rad2/d(S,O_));
   pt N=new pt(S.x,S.y);
   N.add(S(rad2, U(R(V(S,O_),ang2))));   
   PShape A1=drawCircleArcInHat(R,O_,N,ver_in_arc);
   shape(A1);
   String dat1=DataArcInHat(R,O_,N);
   float pt1x=Float.parseFloat(dat1.split(",")[0]);
   float pt1y=Float.parseFloat(dat1.split(",")[1]);
   float pt1r=Float.parseFloat(dat1.split(",")[2]);
   pt pt1E=new pt(pt1x,pt1y);
   
   ArrayList<String>vec0=new ArrayList<String>();
   ArrayList<String>vec1=new ArrayList<String>();
   for(int i=0; i<A1.getVertexCount(); i++){
     try{
       PVector ve0=A0.getVertex(i);
       vec0.add(ve0.x+","+ve0.y+","+(sqrt(ve0.x*ve0.x + ve0.y*ve0.y)));       
       PVector ve1=A1.getVertex(i);
       vec1.add(ve1.x+","+ve1.y+","+(sqrt(ve1.x*ve1.x + ve1.y*ve1.y)));
     }catch(Exception exc){
     }
   }
   Collections.sort(vec0, new CompareIndex2());
   Collections.sort(vec1, new CompareIndex2());
   PShape me_Axis=createShape();
   me_Axis.beginShape();
   for(int i=0; i<vec0.size(); i++){
     float x0=Float.parseFloat(vec0.get(i).split(",")[0]);
     float y0=Float.parseFloat(vec0.get(i).split(",")[1]);
     pt pt0L=new pt(x0,y0);
     float x1=Float.parseFloat(vec1.get(i).split(",")[0]);
     float y1=Float.parseFloat(vec1.get(i).split(",")[1]);
     pt pt1R=new pt(x1,y1);
     stroke(0);
     PShape trans_arc0=getArc(pt0S,pt0L,pt1E,pt1R);
     float dcheck0=dis(x0,y0,x1,y1);
     boolean t0=check(trans_arc0,dcheck0,1.25);
     if(t0==true){
       shape(trans_arc0);
     }else{
       PShape trans_arc1=getArc(pt1E,pt1R,pt0S,pt0L);
       float dcheck1=dis(x0,y0,x1,y1);
       boolean t1=check(trans_arc0,dcheck0,2);
       if(t1==true){
         shape(trans_arc1);
       }
     }
     
     me_Axis.vertex((x0+x1)/2,(y0+y1)/2);
     
   }
   me_Axis.endShape();
   shape(me_Axis);
  
  /*
  *  CONSTRUCT PURE MEDIAL AXIS
  */

 /*
 *  
 */
  
  strokeWeight(5);
  if(b1)
    {
    // your code for part 1
    }
    
  if(b2)
    {
    // your code for part 2
    }

   stroke(black);   strokeWeight(1);

   if(b3)
     {
     fill(black); scribeHeader("t="+nf(t,1,2),2); noFill();
     // your code for part 4
      strokeWeight(3); stroke(blue); 
     //    drawCircleInHat(Mr,M,Ml);  
     }
   strokeWeight(1);
  
  noFill(); stroke(black); P.draw(white); // paint empty disks around each control point
  fill(black); label(S,V(-1,-2),"S"); label(E,V(-1,-2),"E"); label(L,V(-1,-2),"L"); label(R,V(-1,-2),"R"); noFill(); // fill them with labels
  
  if(snapPic) {endRecord(); snapPic=false;} // end saving a .pdf of the screen

  fill(black); displayHeader();
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 
  if(filming && (animating || change)) saveFrame("FRAMES/F"+nf(frameCounter++,4)+".tif"); // saves a movie frame 
  change=false; // to avoid capturing movie frames when nothing happens
  }  // end of draw()

  
//**************************** user actions ****************************
void keyPressed() { // executed each time a key is pressed: sets the "keyPressed" and "key" state variables, 
                    // till it is released or another key is pressed or released
  if(key=='?') scribeText=!scribeText; // toggle display of help text and authors picture
  if(key=='!') snapPicture(); // make a picture of the canvas and saves as .jpg image
  if(key=='`') snapPic=true; // to snap an image of the canvas and save as zoomable a PDF
  if(key=='~') {filming=!filming; } // filming on/off capture frames into folder FRAMES 
  if(key=='a') {animating=true; f=0; t=0;}  
  if(key=='s') P.savePts("data/pts");   
  if(key=='l') P.loadPts("data/pts"); 
  if(key=='1') b1=!b1;
  if(key=='2') b2=!b2;
  if(key=='3') b3=!b3;
  if(key=='4') b4=!b4;
  if(key=='Q') exit();  // quit application
  change=true; // to make sure that we save a movie frame each time something changes
  }

void mousePressed() {  // executed when the mouse is pressed
  P.pickClosest(Mouse()); // used to pick the closest vertex of C to the mouse
  change=true;
  }

void mouseDragged() {
  if (!keyPressed || (key=='a')) P.dragPicked();   // drag selected point with mouse
  if (keyPressed) {
      if (key=='.') t+=2.*float(mouseX-pmouseX)/width;  // adjust current frame   
      if (key=='t') P.dragAll(); // move all vertices
      if (key=='r') P.rotateAllAroundCentroid(Mouse(),Pmouse()); // turn all vertices around their center of mass
      if (key=='z') P.scaleAllAroundCentroid(Mouse(),Pmouse()); // scale all vertices with respect to their center of mass
      }
  change=true;
  }  

//**************************** text for name, title and help  ****************************
String title ="6491 2017 P1: Caplets", 
       name ="Student: Pierre Martin, Jay Kim",
       menu="?:(show/hide) help, s/l:save/load control points, a: animate, `:snap picture, ~:(start/stop) recording movie frames, Q:quit",
       guide="click and drag to edit, press '1' or '2' to toggle LINEAR/CIRCULAR,"; // help info


  
float timeWarp(float f) {return sq(sin(f*PI/2));}

public pt findIntersection(float x0,float y0,float x1,float y1,float x2,float y2,float x3,float y3){
  if(x1-x0==0){
    x1+=0.001;
  }
  if(x3-x2==0){
    x3+=0.001;
  }
  float m0=(y1-y0)/(x1-x0);
  float m1=(y3-y2)/(x3-x2);
  float c0=y1- (m0*x1);
  float c1=y3- (m1*x3);
  float x=(c0-c1)/(m1-m0);
  float y=(m0*x) + c0;
  return P(x,y);
}
public class CompareIndex2 implements Comparator<String>{
     @Override
    public int compare(String o1, String o2) {
        double d0=Double.parseDouble(o1.split(",")[2]);
        double d1=Double.parseDouble(o2.split(",")[2]);
        if(d0<d1){
            return -1;
        }else if(d0>d1){            
            return 1;
        }else{
            return 0;
        }
    }
}

public PShape getArc(pt S, pt L, pt E, pt R){
   vec rSL=U(R(V(S,L)));
   float t=(d2(E,R) - d2(E,L))/(2*dot(rSL, V(E,L)));      
   pt O=new pt(L.x,L.y).add(S(t,rSL));
   float rad=d(E,R);
   float ang=acos(rad/d(E,O));   
   pt M=new pt(E.x,E.y);
   M.add(S(rad, U(R(V(E,O),ang))));
   PShape A0=drawCircleArcInHat(L,O,M,50);  
   drawDisc(L,O,M,50);
   return A0;
}

boolean check(PShape a0, float d0, float dx){
  PVector ve0=a0.getVertex(0);
  PVector ve1=a0.getVertex(a0.getVertexCount()-1);
  if(dist(ve0.x,ve0.y,ve1.x,ve1.y)>dx*d0){
    return false;
  }else{
    return true;
  }
}

pt lineCircleInX(float x1, float y1, float x2, float y2, float p, float q, float r){
  ellipse(p,q,2*r,2*r);
  float m=(y2-y1)/(x2-x1);
  float c=y1-m*x1;
  float A=(sq(m)+1);
  float B=2*((m*c)-(m*q)-p);
  float C=(sq(p)+sq(q)+sq(c)-sq(r)-(2*c*q));
  float t=sqrt(sq(B) - 4*A*C);
  float x=(-B-t)/(2*A);
  float x_=(-B+t)/(2*A);
  float y=m*x + c;
  float y_=m*x_ + c;
  ellipse(x,y,5,5);
  ellipse(x_,y_,5,5);
  println(x,y);
  line(x1,y1,x2,y2);
  pt P=new pt(x,y);
  return P;
}