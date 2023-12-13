syms b2 b3 b4 
a2=pi/4;
a3=0;
a4=-pi/4;
M=[exp(1i*b2)-1 exp(1i*a2)-1 1+2i;...
   exp(1i*b3)-1 exp(1i*a3)-1 2+3i;...
   exp(1i*b4)-1 exp(1i*a4)-1 3+2i];
eq=det(M)==0;
r=solve(eq,b3);