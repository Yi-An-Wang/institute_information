syms b2 b3 b4 b5
a2=pi/4;
a3=0;
a4=-pi/4;
a5=59*pi/180;
M1=[exp(1i*b2)-1 exp(1i*a2)-1 1+2i;...
   exp(1i*b3)-1 exp(1i*a3)-1 2+3i;...
   exp(1i*b4)-1 exp(1i*a4)-1 3+2i];
eq=det(M1)==0;
b2=solve(eq,b2);
M2=[exp(1i*b3)-1 exp(1i*a3)-1 2+3i;...
    exp(1i*b4)-1 exp(1i*a4)-1 3+2i;...
    exp(1i*b5)-1 exp(1i*a5)-1 0.799+1.42i];
eq=det(M2)==0;
b5=solve(eq,b5);