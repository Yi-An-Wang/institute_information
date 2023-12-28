syms B b C c
X1=[1 2; 4 5];
L1=[7 5; 2 1];
X2=[5 7; 6 31];
L2=[8 51; 2 3];
v1=[B; b];
v2=[C; c];
eq1=X1*v1==L1*v2;
eq2=X2*v1==L2*v2;
solve([eq1,eq2],B,b,C,c)