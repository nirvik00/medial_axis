//************************************************************************
//**** CIRCLES
//************************************************************************
CIRCLE C(pt P, float r) {return new CIRCLE(P,r);} // shortcut for creating circle

class CIRCLE 
  { 
  
  pt C=P(200,200); // center
  float r=200;     // radius
  CIRCLE (pt P, float s) {C.setTo(P); r=s;}; // CREATE  circle
  CIRCLE () {} 
  void drawCirc() {show(C,r);} // draw
  pt ProjectionOf(pt P) {return T(C,r,P);} // closest projection of point P onto Circle, T(C,r,P) returns point at distance r from C towards P
  pt PtOnCircle(float a) {return P(r*cos(a)+C.x , r*sin(a)+C.y);}   // Computes point on this circle (for animation or drawing)
  boolean contains(pt P, pt Q){//rick func
     return (d(this.C, P) < this.r) && (d(this.C, Q) < this.r);
  }
} //*********** END CIRCLE CLASS


PShape drawCircleArcInHat(pt PA, pt B, pt PC, int num_) // draws circular arc from PA to PB that starts tangent to B-PA and ends tangent to PC-B
  {
    int num_div=num_;
    float e = (d(B,PC)+d(B,PA))/2;
    pt A = P(B,e,U(B,PA));
    pt C = P(B,e,U(B,PC));
    vec BA = V(B,A), BC = V(B,C);
    float d = dot(BC,BC) / dot(BC,W(BA,BC));  
    pt X = P(B,d,W(BA,BC));
    float r=abs(det(V(B,X),U(BA)));
    vec XA = V(X,A), XC = V(X,C); 
    float a = angle(XA,XC), da=a/num_div;  
    PShape s=createShape();
    s.beginShape(); 
    ArrayList<vec>norList=new ArrayList<vec>();
    if(a>0){     
       for (float w=a; w>-da; w-=da){
         pt Q=(P(X,R(XA,w)));
         s.vertex(Q.x,Q.y);
         //
         
         vec V0=U(V(Q,X));
         pt Q0=new pt(Q.x,Q.y).add(S(10,V0));
         //line(Q0.x,Q0.y,Q.x,Q.y);
         norList.add(U(V(Q,Q0)));         
       }
     }
     else {
       for (float w=0; w>=a; w+=da){
         pt Q=(P(X,R(XA,w)));
         s.vertex(Q.x,Q.y);
         //
         
         vec V0=U(V(Q,X));
         pt Q0=new pt(Q.x,Q.y).add(S(-10,V0));
         //line(Q0.x,Q0.y,Q.x,Q.y);
         norList.add(U(V(Q,Q0)));
         
       }
     }
    s.endShape();
    //shape(s);
    return s;
  }
  
  void drawDisc(pt PA, pt B, pt PC, int num_) // draws circular arc from PA to PB that starts tangent to B-PA and ends tangent to PC-B
  {
    int num_div=num_;
    float e = (d(B,PC)+d(B,PA))/2;
    pt A = P(B,e,U(B,PA));
    pt C = P(B,e,U(B,PC));
    vec BA = V(B,A), BC = V(B,C);
    float d = dot(BC,BC) / dot(BC,W(BA,BC));  
    pt X = P(B,d,W(BA,BC));
    float r=abs(det(V(B,X),U(BA)));
    stroke(20,150,50,150);
    strokeWeight(1);
    ellipse(X.x,X.y,2*r,2*r);    
  }
  
  
  
  String DataArcInHat(pt PA, pt B, pt PC){
    float e = (d(B,PC)+d(B,PA))/2;
    pt A = P(B,e,U(B,PA));
    pt C = P(B,e,U(B,PC));
    vec BA = V(B,A), BC = V(B,C);
    float d = dot(BC,BC) / dot(BC,W(BA,BC));  
    pt X = P(B,d,W(BA,BC));//center of circle
    return X.x+","+X.y+","+d;
  }
  
  
  float dis(float x,float y, float a, float b){
    float d=sqrt(sq(x-a) + sq(y-b));
    return d;
  }
  
  public class CompareIndex5 implements Comparator<String>{
     @Override
     public int compare(String o1, String o2) {
        double d0=Double.parseDouble(o1.split(",")[4]);
        double d1=Double.parseDouble(o2.split(",")[4]);
        if(d0<d1){
            return -1;
        }else if(d0>d1){            
            return 1;
        }else{
            return 0;
        }
    }
}