syms a b c d w z
a2=pi/4;
a3=0;
a4=-pi/4;
a5=59*pi/180;
A=[a exp(1i*a2)-1; b exp(1i*a3)-1; c exp(1i*a4)-1; d exp(1i*a5)-1];
delt=[complex(1,2); complex(2,3); complex(3,2); complex(0.799,1.42)];
eq=A*[w; z]==delt;
r1=solve(eq,a,d,w,z);

M1=[a exp(1i*a2)-1 1+2i;...
    b exp(1i*a3)-1 2+3i;...
    c exp(1i*a4)-1 3+2i];
eq=det(M1)==0;
a=solve(eq,a);
M2=[b exp(1i*a3)-1 2+3i;...
    c exp(1i*a4)-1 3+2i;...
    d exp(1i*a5)-1 0.799+1.42i];
eq=det(M2)==0;
d=solve(eq,d);