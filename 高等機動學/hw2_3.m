syms th1 th3 d2
a=[0; 1; 0.2];
apha=[pi/2; 0; pi/2];
theta=[th1; 0; th3];
d=[0.5; d2; 0];
p=[1.28; 0.253; 0.442; 1];
[jacobian,J,T]=transformation(a,apha,theta,d);
f=T{1,2}*[0; 0; 0; 1]-p;
Ans=solve(f,th1,th3,d2);