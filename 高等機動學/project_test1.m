syms x
a=20*exp(-pi/3*1i);
b=20*exp(-pi*1i);
c=x;
eq=a+b+c==0;
result=solve(eq,x);